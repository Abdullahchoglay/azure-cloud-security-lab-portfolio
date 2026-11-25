targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace onboarded to Microsoft Sentinel.')
param workspaceName string

@description('Enable only for a controlled validation window.')
param enabled bool = false

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

var analyticRuleName = guid(workspace.id, 'AZ-GOV-001-policy-deny')
var analyticRuleId = '${workspace.id}/providers/Microsoft.SecurityInsights/alertRules/${analyticRuleName}'

resource automationRule 'Microsoft.SecurityInsights/automationRules@2022-08-01' = {
  name: guid(workspace.id, 'AZ-GOV-001-policy-triage')
  scope: workspace
  properties: {
    displayName: 'AZ-GOV-001 - Triage blocked policy incidents'
    order: 110
    triggeringLogic: {
      isEnabled: enabled
      triggersOn: 'Incidents'
      triggersWhen: 'Created'
      conditions: [
        {
          conditionType: 'Property'
          conditionProperties: {
            propertyName: 'IncidentRelatedAnalyticRuleIds'
            operator: 'Contains'
            propertyValues: [
              analyticRuleId
            ]
          }
        }
      ]
    }
    actions: [
      {
        order: 1
        actionType: 'ModifyProperties'
        actionConfiguration: {
          status: 'Active'
          severity: 'Low'
          labels: [
            {
              labelName: 'Policy-Blocked'
            }
          ]
        }
      }
    ]
  }
}

output automationRuleName string = automationRule.name
output automationRuleEnabled bool = enabled
