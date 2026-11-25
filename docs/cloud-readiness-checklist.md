# Cloud Readiness Checklist

Completed in the authenticated Azure portal before deployment. Items marked N/A were
deliberately excluded from the final project scope.

## Free-account offer

- [x] Account identifies itself as an Azure Free Trial subscription.
- [x] Spending protection is active.
- [x] USD 200 equivalent introductory credit was advertised.
- [x] Resource cleanup date is recorded as 29 November 2026.
- [x] Subscription is active and has not been converted to pay as you go.

## Sentinel

- [x] Sentinel was onboarded to a new dedicated workspace.
- [x] Cleanup date and spending controls are recorded.
- [x] Israel Central supports every deployed resource.
- [x] Logic App pricing is N/A because no Logic App was deployed.
- [x] Required Azure role was available; Entra scenarios were excluded.

## Data and identity

- [x] Azure Activity export is permitted and verified live.
- [x] Entra telemetry is N/A for the final project scope.
- [x] AuditLogs export is N/A for the final project scope.
- [x] SigninLogs export is N/A for the final project scope.
- [x] No personal-service or production identity telemetry was connected.

## Stop conditions

Stop before deployment if spending protection is absent, the Sentinel trial cannot be
confirmed, a paid plan is preselected, an unrelated subscription is active, or the
projected maximum exceeds USD 5 equivalent without explicit approval.
