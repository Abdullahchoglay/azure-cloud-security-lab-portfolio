param prefix string
param location string
param expiryDate string
param projectTag string

var sharedTags = {
  project: projectTag
  environment: 'lab'
  expiresOn: expiryDate
  dataClassification: 'synthetic-only'
}
var compactPrefix = replace(toLower(prefix), '-', '')
var storageAccountName = take('${compactPrefix}${uniqueString(resourceGroup().id, 'storage')}', 24)
var keyVaultName = take('${prefix}-${uniqueString(resourceGroup().id, 'vault')}', 24)

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: '${prefix}-baseline-nsg'
  location: location
  tags: sharedTags
  properties: {
    securityRules: []
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  tags: sharedTags
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: false
    allowCrossTenantReplication: false
    defaultToOAuthAuthentication: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  tags: sharedTags
  properties: {
    tenantId: subscription().tenantId
    enableRbacAuthorization: true
    enableSoftDelete: true
    softDeleteRetentionInDays: 7
    publicNetworkAccess: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      ipRules: []
      virtualNetworkRules: []
    }
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

output networkSecurityGroupName string = networkSecurityGroup.name
output storageAccountName string = storageAccount.name
output keyVaultName string = keyVault.name
