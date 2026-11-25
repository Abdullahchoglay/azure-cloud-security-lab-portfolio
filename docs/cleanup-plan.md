# Cleanup Plan

## Preserve first

- Export sanitized query results and incident metadata.
- Record source tables, timestamps, operation names, correlation identifiers, and
  verification states.
- Export workbook, analytics-rule, automation-rule, and playbook source.
- Record the current cost and resource inventory.

## Final preservation state

Evidence was exported and sanitized before cancellation. The analytics and automation
rules were disabled, and no VM, public IP, or Logic App existed. On 5 November 2026,
the Azure subscription was canceled instead of manually deleting each resource group.
Azure confirmed that all resources were turned off and no longer incur charges.

At cancellation, the secure baseline resource group contained one empty storage
account, one empty Key Vault, one network security group, and two scoped policy
assignments. These are retained temporarily by Azure but are turned off.

The temporary `ACSLab-SOC-Readers` group and its Reader assignment were removed on
5 November 2026 after the RBAC evidence was preserved. Azure IAM was checked afterward
and no Reader assignment remained.

## Completed shutdown

1. ~~Remove the temporary `ACSLab-SOC-Readers` role assignment and verify it is absent.~~ Completed 5 November 2026.
2. ~~Delete the empty `ACSLab-SOC-Readers` group after evidence is preserved.~~ Completed 5 November 2026.
3. ~~Disable analytics rules and automation rules.~~ Completed before cancellation.
4. Disable or remove optional data connectors.
5. Remove the optional Logic App and its connections.
6. Cancel the Azure subscription and acknowledge that all resources will be turned off.
7. Verify the portal reports the subscription as canceled.
8. Record the final observed current cost and forecast.

The authenticated inventory is recorded in `evidence/COST-001-cost-and-inventory.md`.
The portal reported a current cost of 0.00 and forecast of 0.00 immediately before
cancellation. Azure then confirmed that all resources were turned off, no longer incur
charges, and will be automatically deleted with the subscription data after 30 days.

The completed shutdown record is in
[`cleanup-verification-report.md`](cleanup-verification-report.md).
