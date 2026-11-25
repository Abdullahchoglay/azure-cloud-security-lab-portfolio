# AZ-GOV-001 — Azure Policy Deny

## Purpose

Surface blocked Azure resource requests so an analyst can distinguish a successful
preventive control from repeated misconfiguration or an attempted policy bypass.

## Data and rule

- Table: `AzureActivity`
- Category: `Policy`
- Result: `Failed`
- Scope: dedicated security lab resource group
- Query window: 2 hours
- Frequency: 5 minutes during validation
- Severity: Low
- Incident grouping: one alert for the query results
- ATT&CK context: T1562, Defense Evasion, only when intent supports that conclusion

## Expected noise

Approved infrastructure tests and developers learning the required configuration can
produce benign denies. Investigate repeated attempts, unexpected identities, unusual
targets, or activity outside a planned change window.

## Safety state

The rule source defaults to disabled. It is enabled only for the controlled live test
and disabled immediately after the incident is verified.

## Live result

Verified on 5 November 2026. One fresh policy deny reached `AzureActivity`, the rule
created one Low-severity alert and incident, and automation added `Policy-Blocked`.
The incident was closed as benign positive / suspicious but expected. Both rules are
disabled.
