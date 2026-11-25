targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace onboarded to Microsoft Sentinel.')
param workspaceName string

@description('Keep false until a controlled test window is approved.')
param enabled bool = false

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

resource alertRule 'Microsoft.SecurityInsights/alertRules@2022-11-01' = {
  name: guid(workspace.id, 'AZ-IAM-001-rbac-assignment-change')
  scope: workspace
  kind: 'Scheduled'
  properties: {
    displayName: 'AZ-IAM-001 - Azure RBAC assignment changed'
    description: 'Detects successful Azure role assignment creation or deletion in the dedicated security lab resource group.'
    enabled: enabled
    query: '''
      AzureActivity
      | where TimeGenerated >= ago(1h)
      | where ActivityStatusValue =~ "Success"
      | where OperationNameValue in~ (
          "Microsoft.Authorization/roleAssignments/write",
          "Microsoft.Authorization/roleAssignments/delete")
      | where ResourceGroup =~ "acslab-security-rg"
      | extend Action = iff(OperationNameValue endswith "/delete", "Delete", "Create")
      | project TimeGenerated, Caller, CallerIpAddress, Action, OperationNameValue,
          ResourceGroup, ResourceId, CorrelationId
    '''
    queryFrequency: 'PT5M'
    queryPeriod: 'PT1H'
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    severity: 'Medium'
    suppressionEnabled: false
    suppressionDuration: 'PT1H'
    tactics: [
      'PrivilegeEscalation'
      'Persistence'
    ]
    techniques: [
      'T1098'
    ]
    eventGroupingSettings: {
      aggregationKind: 'AlertPerResult'
    }
    incidentConfiguration: {
      createIncident: true
      groupingConfiguration: {
        enabled: true
        reopenClosedIncident: false
        lookbackDuration: 'PT1H'
        matchingMethod: 'Selected'
        groupByEntities: []
        groupByAlertDetails: [
          'DisplayName'
        ]
        groupByCustomDetails: []
      }
    }
    customDetails: {
      Action: 'Action'
      Operation: 'OperationNameValue'
      ResourceGroup: 'ResourceGroup'
    }
  }
}

output alertRuleName string = alertRule.name
output alertRuleEnabled bool = enabled
