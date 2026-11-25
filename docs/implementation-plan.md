# Implementation Plan and Completion Record

All required gates were completed on 4 November 2026. Optional Entra telemetry and a
Logic App were excluded to keep the project cost-controlled and focused.

## Gate 0 — account verification

Before deployment, record privately and summarize safely:

- Azure Free Account status, remaining credit, and expiry.
- Spending protection state and confirmation that pay as you go is not enabled.
- Subscription state, tenant ownership, default region, and permitted roles.
- Sentinel new-workspace trial eligibility.
- Entra edition and diagnostic-export availability.
- Existing resources that are explicitly outside the lab scope.

## Gate 1 — cost controls

- Create the dedicated monitoring resource group.
- Attempt a small budget when the offer and account permissions permit it.
- Create a resource inventory and cleanup ledger before any workload resource.
- Set the Log Analytics workspace to the lowest practical retention.

## Gate 2 — telemetry

- Deploy one Log Analytics workspace and onboard Sentinel.
- Export low-volume Azure Activity categories to the workspace.
- Validate the AzureActivity schema and ingestion delay.
- Add Entra AuditLogs or SigninLogs only when licensing and diagnostic export permit.

## Gate 3 — detection engineering

- Execute uniquely marked, harmless control-plane scenarios.
- Confirm source telemetry before writing live-result claims.
- Tune hunting queries against the observed schema.
- Promote only stable queries to scheduled analytics rules.
- Record false positives, thresholds, entities, ATT&CK mapping, and limitations.

## Gate 4 — analyst experience

- Generate at least one evidence-backed incident from the primary detection scenario.
- Create a concise investigation for the validated incident.
- Build a decision-oriented workbook from populated tables.
- Add a safe automation rule and, only if approved, one low-volume playbook.

## Gate 5 — closure

- Export and sanitize evidence.
- Disable rules after testing and preserve the live workspace temporarily for review.
- Verify the final inventory, cost controls, Git history, screenshots, links, and claims.
- Keep the remote repository private until publication is explicitly approved.
