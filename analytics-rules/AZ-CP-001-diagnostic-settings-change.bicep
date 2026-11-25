targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace onboarded to Microsoft Sentinel.')
param workspaceName string

@description('Keep false until the query is verified against live AzureActivity data.')
param enabled bool = false

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

resource alertRule 'Microsoft.SecurityInsights/alertRules@2022-11-01' = {
  name: guid(workspace.id, 'AZ-CP-001-diagnostic-settings-change')
  scope: workspace
  kind: 'Scheduled'
  properties: {
    displayName: 'AZ-CP-001 - Azure diagnostic settings changed or deleted'
    description: 'Detects successful Azure Monitor diagnostic-setting write or delete operations. Validate each result against an approved change.'
    enabled: enabled
    query: '''
      AzureActivity
      | where TimeGenerated >= ago(1h)
      | where ActivityStatusValue =~ "Success"
      | where OperationNameValue in~ (
          "Microsoft.Insights/diagnosticSettings/write",
          "Microsoft.Insights/diagnosticSettings/delete")
      | extend Action = iff(OperationNameValue endswith "/delete", "Delete", "Write")
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
      'DefenseEvasion'
    ]
    techniques: [
      'T1562'
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
