targetScope = 'subscription'

@description('Short fictional prefix containing lowercase letters, digits, and hyphens.')
@minLength(3)
@maxLength(18)
param prefix string

@description('Azure region selected after availability and cost checks.')
param location string

@description('Cleanup date in YYYY-MM-DD form.')
param expiryDate string

param projectTag string = 'azure-cloud-security-lab'

var governanceResourceGroupName = '${prefix}-security-rg'

resource governanceResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: governanceResourceGroupName
  location: location
  tags: {
    project: projectTag
    environment: 'lab'
    expiresOn: expiryDate
    dataClassification: 'synthetic-only'
  }
}

resource requireProjectTagDefinition 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'lab-require-project-tag'
  properties: {
    displayName: 'Lab resources must include a project tag'
    description: 'Denies taggable resources when the project tag is absent.'
    mode: 'Indexed'
    metadata: {
      category: 'Lab security'
      version: '1.0.0'
    }
    policyRule: {
      if: {
        field: 'tags[project]'
        exists: 'false'
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

resource denyBlobPublicAccessDefinition 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: 'lab-deny-blob-public-access'
  properties: {
    displayName: 'Lab storage accounts must disable blob public access'
    description: 'Denies storage accounts that allow anonymous blob access.'
    mode: 'Indexed'
    metadata: {
      category: 'Lab security'
      version: '1.0.0'
    }
    policyRule: {
      if: {
        allOf: [
          {
            field: 'type'
            equals: 'Microsoft.Storage/storageAccounts'
          }
          {
            field: 'Microsoft.Storage/storageAccounts/allowBlobPublicAccess'
            notEquals: false
          }
        ]
      }
      then: {
        effect: 'deny'
      }
    }
  }
}

module assignments './modules/policy-assignments.bicep' = {
  name: 'assign-security-policies'
  scope: governanceResourceGroup
  params: {
    requireProjectTagDefinitionId: requireProjectTagDefinition.id
    denyBlobPublicAccessDefinitionId: denyBlobPublicAccessDefinition.id
  }
}

module baseline './modules/secure-baseline.bicep' = {
  name: 'deploy-secure-baseline'
  scope: governanceResourceGroup
  params: {
    prefix: prefix
    location: location
    expiryDate: expiryDate
    projectTag: projectTag
  }
  dependsOn: [
    assignments
  ]
}

output securityResourceGroupName string = governanceResourceGroup.name
output networkSecurityGroupName string = baseline.outputs.networkSecurityGroupName
output storageAccountName string = baseline.outputs.storageAccountName
output keyVaultName string = baseline.outputs.keyVaultName
