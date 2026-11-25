# AZ-GOV-001 Incident Investigation

## Summary

Azure Policy blocked an authorized test that attempted to create an untagged, empty
network security group. The deny event reached Log Analytics, Sentinel created one
Low-severity alert and incident, and scoped automation added the `Policy-Blocked`
label. No forbidden resource was created.

## Findings

| Question | Finding |
|---|---|
| What happened? | Azure Policy denied a resource request missing the required project tag |
| Did prevention work? | Yes; `RequestDisallowedByPolicy` was returned |
| Was a resource created? | No |
| Was the event monitored? | Yes; Policy-category `DENY/ACTION` appeared in `AzureActivity` |
| Did Sentinel alert? | Yes; one Low-severity alert and incident |
| Did automation run? | Yes; Active/Low and `Policy-Blocked` |
| Was the action authorized? | Yes; it was the documented final validation test |

## Disposition

- Status: Closed
- Classification: Benign positive
- Reason: Suspicious but expected
- Severity: Low
- Alert count: 1
- Residual resource: None

The analytics and automation rules were disabled after verification.
