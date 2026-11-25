# Troubleshooting Record

## 4 November 2026 — Azure CLI path not visible immediately

Azure CLI 2.92.0 installed successfully, but the already-running PowerShell process did
not inherit the updated PATH. The installation was verified using the standard 64-bit
Azure CLI path. New terminal processes or a refreshed environment should resolve az
normally.

## 4 November 2026 — Azure portal token warning

The portal displayed an interaction-required warning for a silent access-token request.
No warning was bypassed and no resource operation was attempted. The authenticated home
page independently showed that no subscription exists and offered Azure Free Account
signup.

## 4 November 2026 — Subscription activation propagation

The portal initially reported no subscription. After the owner completed Azure Free
Account verification, the subscription became enabled and Azure CLI authentication,
offer inspection, role inspection, and resource deployment succeeded.

## 4 November 2026 — Budget API denied

Creating a USD 5 monthly Cost Management budget with owner notifications returned
`RBACAccessDenied`, despite the account's Owner role. The request created no budget.
The Free Trial spending limit stayed enabled throughout the live test.

## 4 November 2026 — Missing Operations Management provider

The first Sentinel deployment created the workspace but failed to create the onboarding
state because `Microsoft.OperationsManagement` was not registered. The provider was
registered explicitly and deployment `p4-sentinel-deploy-20261104-r2` then succeeded.

## 4 November 2026 — Diagnostic deployment argument expansion

The first Azure Activity diagnostic deployment passed a PowerShell object plus a literal
`.id` suffix instead of the workspace resource-ID string. Extracting the ID into a scalar
variable corrected the invocation; the Bicep template itself did not require a change.

## 4 November 2026 — Sentinel portal 401 during propagation

The classic Sentinel overview blade briefly returned HTTP 401 after onboarding. ARM API
checks independently confirmed the workspace and `default` Sentinel onboarding state.
The condition is recorded as portal/permission propagation and must be rechecked before
portal evidence is claimed.

## 4 November 2026 — Log Analytics CLI extension

`az monitor log-analytics query` requires the official `log-analytics` Azure CLI
extension. Azure CLI installed the available preview version. Query results, not the
extension installation alone, remain the acceptance criterion for ingestion.
