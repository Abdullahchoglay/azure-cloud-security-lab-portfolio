# AZ-GOV-001 — Policy-Deny Detection and Incident

## Acceptance results

| Stage | Result |
|---|---|
| Azure Policy blocked the request | Verified |
| Forbidden resource absent | Verified |
| Policy event in Azure Activity Log | Verified |
| Event in `AzureActivity` | Verified |
| Hunting query | Verified |
| Scheduled analytics rule | Verified |
| Alert and incident | Verified, one Low-severity alert |
| Safe automation | Verified, Active/Low plus `Policy-Blocked` |
| Investigation and closure | Benign positive / suspicious but expected |
| Post-test state | Analytics and automation rules disabled |

## Timeline

- 04:33:46 UTC — Azure Policy denied the untagged test resource.
- The event reached `AzureActivity` as
  `MICROSOFT.AUTHORIZATION/POLICIES/DENY/ACTION` with `Failure` status.
- 04:42:50 UTC — Sentinel created the incident with one alert.
- Automation set Active/Low and added `Policy-Blocked`.
- The analyst confirmed that no forbidden resource existed and closed the incident.

No caller, subscription, tenant, workspace, incident, alert, correlation, or full
resource identifier is committed.

See [`investigations/AZ-GOV-001-investigation.md`](../investigations/AZ-GOV-001-investigation.md).
