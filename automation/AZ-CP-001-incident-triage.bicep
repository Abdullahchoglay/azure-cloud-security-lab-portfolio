targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace onboarded to Microsoft Sentinel.')
param workspaceName string

@description('Enable only for the controlled incident test.')
param enabled bool = false

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

var analyticRuleName = guid(workspace.id, 'AZ-CP-001-diagnostic-settings-change')
var analyticRuleId = '${workspace.id}/providers/Microsoft.SecurityInsights/alertRules/${analyticRuleName}'

resource automationRule 'Microsoft.SecurityInsights/automationRules@2022-08-01' = {
  name: guid(workspace.id, 'AZ-CP-001-incident-triage')
  scope: workspace
  properties: {
    displayName: 'AZ-CP-001 - Triage diagnostic settings incidents'
    order: 100
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
          severity: 'Medium'
          labels: [
            {
              labelName: 'SOAR-Triaged'
            }
          ]
        }
      }
    ]
  }
}

output automationRuleName string = automationRule.name
output automationRuleEnabled bool = enabled
