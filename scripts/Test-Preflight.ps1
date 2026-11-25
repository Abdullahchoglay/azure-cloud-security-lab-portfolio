[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

function Get-ToolState {
    param([Parameter(Mandatory)][string]$Name)

    $command = Get-Command $Name -ErrorAction SilentlyContinue | Select-Object -First 1
    [pscustomobject]@{
        Tool      = $Name
        Installed = [bool]$command
        Path      = if ($command) { $command.Source } else { $null }
    }
}

$tools = 'git', 'az', 'gh', 'pwsh' | ForEach-Object { Get-ToolState -Name $_ }
$tools | Format-Table -AutoSize

$azureState = 'Azure CLI is not installed.'
if (Get-Command az -ErrorAction SilentlyContinue) {
    $accounts = az account list --all --output json 2>$null | ConvertFrom-Json
    $azureState = if ($accounts.Count -gt 0) {
        'Azure CLI has at least one visible subscription.'
    } else {
        'Azure CLI is installed but no subscription is visible.'
    }
}

$githubState = 'GitHub CLI is not installed.'
if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh auth status *> $null
    $githubState = if ($LASTEXITCODE -eq 0) {
        'GitHub CLI authentication is available.'
    } else {
        'GitHub CLI is installed but not authenticated.'
    }
}

[pscustomobject]@{
    Azure = $azureState
    GitHub = $githubState
    Warning = 'This script does not prove trial eligibility, licensing, regional price, or spending protection.'
} | Format-List
