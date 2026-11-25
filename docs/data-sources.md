# Data-Source Plan

## Azure Activity — required

- Destination table: AzureActivity
- Purpose: resource writes, deletes, policy activity, diagnostic changes, network
  security configuration, and other control-plane operations
- Cost control: subscription diagnostic setting to one workspace; minimal generated
  activity; no resource diagnostic logs by default
- Verification: marker, timestamp, caller, operation, resource, result, and correlation
  ID when safe

## Microsoft Entra audit logs — optional

- Destination table: AuditLogs
- Purpose: fictional user and group lifecycle changes
- Gate: tenant licensing and diagnostic-export capability
- Limitation: the repository will omit these detections if live export is unavailable

## Microsoft Entra sign-in logs — optional

- Destination table: SigninLogs
- Purpose: failure aggregation and success-after-failures correlation
- Gate: tenant licensing, fictional test identity, and safe bounded generation
- Limitation: no real account targeting and no password-spraying behavior

## Sentinel platform tables

- SecurityAlert and SecurityIncident for alert and incident metrics
- SentinelAudit or equivalent platform audit data only if available in the deployed
  experience

Tables and fields must be queried live before scheduled analytics or workbook source is
treated as deployable.
