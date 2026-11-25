# AZ-ACTIVITY-001 — Azure Activity Ingestion

## Objective

Export subscription Activity Log categories to the Sentinel workspace and verify the
pipeline with a harmless, attributable resource-group tag update.

## Current state

Azure Activity ingestion is verified live; final detection execution is tracked
separately.

- Diagnostic setting `sentinel-lab-azure-activity` deployed successfully.
- Eight Azure Activity log categories are enabled.
- The workspace initially returned zero rows while the new diagnostic setting was
  propagating. Microsoft documents that a new diagnostic route can take about 30 minutes
  to begin and up to 90 minutes for initial delivery.
- The first live workspace row was a successful
  `Microsoft.Insights/workbooks/write` operation in the fictional lab resource group.
- A later idempotent diagnostic-setting deployment produced matching Start and
  Succeeded source events. Both reached `AzureActivity`, proving that this exact
  operation family flows to the rule's source table.
- The final 24-hour validation returned 20 `AzureActivity` rows, with timestamps
  spanning 17:36:44 through 21:51:38 UTC on 4 November 2026.

## Sanitized verification query

```kusto
AzureActivity
| where TimeGenerated > ago(6h)
| where ResourceGroup =~ "p4-sentinel-monitoring-rg"
| project TimeGenerated, OperationNameValue, ActivityStatusValue, ResourceGroup
| order by TimeGenerated desc
```

Caller, IP address, tenant, subscription, workspace, authorization, and correlation
fields are deliberately excluded from public evidence.
