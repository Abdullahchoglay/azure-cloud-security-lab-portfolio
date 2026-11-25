param requireProjectTagDefinitionId string
param denyBlobPublicAccessDefinitionId string

resource requireProjectTagAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: guid(resourceGroup().id, 'require-project-tag')
  properties: {
    displayName: 'Require project tag in security lab'
    description: 'Scoped only to the dedicated security lab resource group.'
    enforcementMode: 'Default'
    policyDefinitionId: requireProjectTagDefinitionId
    metadata: {
      category: 'Lab security'
    }
  }
}

resource denyBlobPublicAccessAssignment 'Microsoft.Authorization/policyAssignments@2024-04-01' = {
  name: guid(resourceGroup().id, 'deny-blob-public-access')
  properties: {
    displayName: 'Deny blob public access in security lab'
    description: 'Scoped only to the dedicated security lab resource group.'
    enforcementMode: 'Default'
    policyDefinitionId: denyBlobPublicAccessDefinitionId
    metadata: {
      category: 'Lab security'
    }
  }
}

output requireProjectTagAssignmentId string = requireProjectTagAssignment.id
output denyBlobPublicAccessAssignmentId string = denyBlobPublicAccessAssignment.id
