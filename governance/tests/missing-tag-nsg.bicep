targetScope = 'resourceGroup'

@description('Unique harmless marker included in the test resource name.')
param marker string

@description('Deployment region.')
param location string = resourceGroup().location

// Expected result after GOV-TAG-001 propagates: denied because the project tag is absent.
// If it unexpectedly succeeds, record a control failure and remove the NSG.
resource expectedDeniedNsg 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: 'expected-deny-${marker}'
  location: location
  properties: {
    securityRules: []
  }
}
