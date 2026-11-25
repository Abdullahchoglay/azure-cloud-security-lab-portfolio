[CmdletBinding()]
param(
    [string]$BicepPath = 'bicep',
    [switch]$SkipBicep
)

$ErrorActionPreference = 'Stop'
$repositoryRoot = Split-Path -Parent $PSScriptRoot
$failures = [System.Collections.Generic.List[string]]::new()

Get-ChildItem -LiteralPath $repositoryRoot -Recurse -File -Filter '*.ps1' | ForEach-Object {
    $tokens = $null
    $errors = $null
    [void][System.Management.Automation.Language.Parser]::ParseFile($_.FullName, [ref]$tokens, [ref]$errors)
    foreach ($parseError in $errors) {
        $failures.Add("PowerShell parse error in $($_.FullName): $($parseError.Message)")
    }
}

Get-ChildItem -LiteralPath $repositoryRoot -Recurse -File -Filter '*.json' | ForEach-Object {
    try {
        Get-Content -Raw -LiteralPath $_.FullName | ConvertFrom-Json | Out-Null
    } catch {
        $failures.Add("Invalid JSON in $($_.FullName): $($_.Exception.Message)")
    }
}

if (-not $SkipBicep) {
    $compiler = Get-Command $BicepPath -ErrorAction SilentlyContinue
    if (-not $compiler -and (Test-Path -LiteralPath $BicepPath)) {
        $compiler = Get-Item -LiteralPath $BicepPath
    }
    if (-not $compiler) {
        $failures.Add("Bicep compiler not found at '$BicepPath'.")
    } else {
        Get-ChildItem -LiteralPath $repositoryRoot -Recurse -File -Filter '*.bicep' |
            Where-Object { $_.FullName -notmatch '[\\/]private[\\/]' } |
            ForEach-Object {
                & $compiler.Source build $_.FullName --stdout *> $null
                if ($LASTEXITCODE -ne 0) {
                    $failures.Add("Bicep validation failed for $($_.FullName).")
                }
            }
    }
}

$sensitivePatterns = @(
    '(?i)client[_-]?secret\s*[:=]\s*[^<\s]+'
    '(?i)api[_-]?key\s*[:=]\s*[^<\s]+'
    '(?i)authorization:\s*bearer\s+[a-z0-9._-]+'
    '-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----'
)

Get-ChildItem -LiteralPath $repositoryRoot -Recurse -File |
    Where-Object { $_.FullName -notmatch '[\\/]\.git[\\/]' } |
    ForEach-Object {
        $content = Get-Content -Raw -LiteralPath $_.FullName -ErrorAction SilentlyContinue
        foreach ($pattern in $sensitivePatterns) {
            if ($content -match $pattern) {
                $failures.Add("Potential secret pattern in $($_.FullName).")
            }
        }
    }

if ($failures.Count -gt 0) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

Write-Output 'Repository validation passed.'
