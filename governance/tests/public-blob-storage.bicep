targetScope = 'resourceGroup'

@description('Short unique marker containing lowercase letters and digits.')
param marker string

@description('Deployment region.')
param location string = resourceGroup().location

@description('Project tag required by the lab tagging policy.')
param projectTag string = 'azure-cloud-security-lab'

// Expected result after GOV-STG-001 propagates: denied because anonymous blob access
// is enabled. If this unexpectedly succeeds, record a control failure and remove it.
resource expectedDeniedStorage 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: take('denied${marker}${uniqueString(resourceGroup().id)}', 24)
  location: location
  tags: {
    project: projectTag
    environment: 'lab-test'
  }
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}
