targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace onboarded to Microsoft Sentinel.')
param workspaceName string

@description('Enable only for a controlled validation window.')
param enabled bool = false

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

resource alertRule 'Microsoft.SecurityInsights/alertRules@2022-11-01' = {
  name: guid(workspace.id, 'AZ-GOV-001-policy-deny')
  scope: workspace
  kind: 'Scheduled'
  properties: {
    displayName: 'AZ-GOV-001 - Azure Policy blocked a lab resource'
    description: 'Detects failed Azure Policy evaluations in the dedicated security lab resource group.'
    enabled: enabled
    query: '''
      AzureActivity
      | where TimeGenerated >= ago(2h)
      | where ResourceGroup =~ "acslab-security-rg"
      | where CategoryValue =~ "Policy"
      | where ActivityStatusValue in~ ("Failure", "Failed")
      | project TimeGenerated, OperationNameValue, ActivityStatusValue,
          ResourceGroup, ResourceId, CorrelationId
    '''
    queryFrequency: 'PT5M'
    queryPeriod: 'PT2H'
    triggerOperator: 'GreaterThan'
    triggerThreshold: 0
    severity: 'Low'
    suppressionEnabled: false
    suppressionDuration: 'PT1H'
    tactics: [
      'DefenseEvasion'
    ]
    techniques: [
      'T1562'
    ]
    eventGroupingSettings: {
      aggregationKind: 'SingleAlert'
    }
    incidentConfiguration: {
      createIncident: true
      groupingConfiguration: {
        enabled: true
        reopenClosedIncident: false
        lookbackDuration: 'PT2H'
        matchingMethod: 'Selected'
        groupByEntities: []
        groupByAlertDetails: [
          'DisplayName'
        ]
        groupByCustomDetails: []
      }
    }
  }
}

output alertRuleName string = alertRule.name
output alertRuleEnabled bool = enabled
