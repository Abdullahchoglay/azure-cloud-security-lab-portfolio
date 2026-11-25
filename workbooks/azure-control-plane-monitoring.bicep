targetScope = 'resourceGroup'

@description('Existing Log Analytics workspace used by the workbook queries.')
param workspaceName string

@description('Workbook deployment region.')
param location string = resourceGroup().location

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' existing = {
  name: workspaceName
}

var workbookData = {
  version: 'Notebook/1.0'
  isLocked: false
  fallbackResourceIds: [
    workspace.id
  ]
  items: [
    {
      type: 1
      name: 'overview-text'
      content: {
        json: '# Azure Cloud Security — Prevention and Response\nThis workbook shows successful cloud operations, preventive-policy activity, and changes that can weaken monitoring during the last 24 hours.'
      }
    }
    {
      type: 3
      name: 'operation-summary'
      content: {
        version: 'KqlItem/1.0'
        title: 'Successful operations by type'
        query: 'AzureActivity\n| where TimeGenerated > ago(24h)\n| where ActivityStatusValue =~ "Success"\n| summarize Events=count() by OperationNameValue\n| top 10 by Events desc'
        size: 0
        queryType: 0
        resourceType: 'microsoft.operationalinsights/workspaces'
        crossComponentResources: [
          workspace.id
        ]
        visualization: 'bar'
      }
    }
    {
      type: 3
      name: 'diagnostic-settings-timeline'
      content: {
        version: 'KqlItem/1.0'
        title: 'Diagnostic settings changes'
        query: 'AzureActivity\n| where TimeGenerated > ago(24h)\n| where ActivityStatusValue =~ "Success"\n| where OperationNameValue in~ ("Microsoft.Insights/diagnosticSettings/write", "Microsoft.Insights/diagnosticSettings/delete")\n| extend Action=iff(OperationNameValue endswith "/delete", "Delete", "Write")\n| project TimeGenerated, Action, OperationNameValue, ResourceGroup\n| order by TimeGenerated desc'
        size: 0
        queryType: 0
        resourceType: 'microsoft.operationalinsights/workspaces'
        crossComponentResources: [
          workspace.id
        ]
        visualization: 'table'
      }
    }
    {
      type: 3
      name: 'secure-baseline-activity'
      content: {
        version: 'KqlItem/1.0'
        title: 'Secure baseline changes'
        query: 'AzureActivity\n| where TimeGenerated > ago(24h)\n| where ResourceGroup =~ "acslab-security-rg"\n| where ActivityStatusValue in~ ("Success", "Succeeded", "Failure", "Failed")\n| project TimeGenerated, OperationNameValue, ActivityStatusValue, ResourceGroup\n| order by TimeGenerated desc'
        size: 0
        queryType: 0
        resourceType: 'microsoft.operationalinsights/workspaces'
        crossComponentResources: [
          workspace.id
        ]
        visualization: 'table'
      }
    }
    {
      type: 3
      name: 'policy-activity'
      content: {
        version: 'KqlItem/1.0'
        title: 'Preventive policy activity'
        query: 'AzureActivity\n| where TimeGenerated > ago(24h)\n| where CategoryValue =~ "Policy" or OperationNameValue has "Microsoft.Authorization/policy"\n| project TimeGenerated, OperationNameValue, ActivityStatusValue, ResourceGroup\n| order by TimeGenerated desc'
        size: 0
        queryType: 0
        resourceType: 'microsoft.operationalinsights/workspaces'
        crossComponentResources: [
          workspace.id
        ]
        visualization: 'table'
      }
    }
  ]
}

resource workbook 'Microsoft.Insights/workbooks@2023-06-01' = {
  name: guid(resourceGroup().id, 'p4-azure-control-plane-monitoring')
  location: location
  kind: 'shared'
  tags: {
    project: 'azure-cloud-security-lab'
    environment: 'lab'
  }
  properties: {
    category: 'sentinel'
    displayName: 'Azure Cloud Security - Prevention and Response'
    description: 'Cloud operations, preventive controls, and monitoring-change review.'
    serializedData: string(workbookData)
    sourceId: workspace.id
    version: 'Notebook/1.0'
  }
}

output workbookName string = workbook.name
output workbookDisplayName string = workbook.properties.displayName
