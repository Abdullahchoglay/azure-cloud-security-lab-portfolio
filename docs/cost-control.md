# Cost-Control Design

Cost control is a security control and a completion requirement.

## Limits and final result

| Control | Limit |
|---|---|
| Virtual machines | 0 |
| Public IP addresses | 0 |
| Log Analytics workspaces | 1 |
| Sentinel workspaces | 1 |
| Target ingestion | Less than 50 MB total |
| Logic Apps / executions | 0 / 0 |
| Retention | Lowest practical supported setting |
| New testing cutoff | Day 21 |
| Cleanup target | Day 27 |

## Predeployment checks

- Verify the free-account credit and exact expiry in Cost Management.
- Verify that spending protection remains active.
- Verify the Sentinel free-trial banner and dates.
- Obtain the regional price for every metered resource.
- Confirm that no paid Defender for Cloud plan is enabled.
- Record the projected maximum and obtain approval if it can exceed USD 5 equivalent.

## Important limitation

An Azure budget sends alerts; it does not stop resource usage. The cleanup ledger and
manual daily cost review are the primary controls.

## Final verification — 4 November 2026

- Azure Free Trial spending limit: enabled.
- Azure portal month-to-date cost display: 0.
- Cost Management query API: unavailable for this Free Trial offer, so no API-derived
  billing claim is made.
- Budget creation: not claimed; the subscription rejected the budget request because
  the account lacked the required Cost Management permission.
- Lab inventory: one workspace, one Sentinel solution, one workbook, one diagnostic
  setting, one empty storage account, one empty Key Vault, one network security group,
  two policy assignments, and two analytics/automation rule pairs.
- Cost-bearing compute/network inventory: zero virtual machines, zero public IPs, zero
  Logic Apps.
- Final safety state: analytics and automation rules disabled.
