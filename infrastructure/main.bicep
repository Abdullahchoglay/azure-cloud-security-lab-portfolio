targetScope = 'subscription'

@description('Short fictional prefix containing lowercase letters, digits, and hyphens.')
@minLength(3)
@maxLength(18)
param prefix string

@description('Azure region selected only after availability and price verification.')
param location string

@description('Non-personal portfolio tag value.')
param projectTag string = 'sentinel-cloud-soc-lab'

@description('Planned cleanup date in YYYY-MM-DD form.')
param expiryDate string

var monitoringResourceGroupName = '${prefix}-monitoring-rg'
var workspaceName = '${prefix}-law'

resource monitoringResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: monitoringResourceGroupName
  location: location
  tags: {
    project: projectTag
    environment: 'lab'
    expiresOn: expiryDate
    dataClassification: 'synthetic-and-sanitized'
  }
}

module monitoring './modules/monitoring.bicep' = {
  name: 'deploy-monitoring'
  scope: monitoringResourceGroup
  params: {
    location: location
    workspaceName: workspaceName
    projectTag: projectTag
    expiryDate: expiryDate
  }
}

output monitoringResourceGroupName string = monitoringResourceGroup.name
output workspaceName string = monitoring.outputs.workspaceName
output workspaceResourceId string = monitoring.outputs.workspaceResourceId
