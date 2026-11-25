# Environment Assessment

Assessment date: 4 November 2026

## Workstation

| Item | Observed state |
|---|---|
| Operating environment | Windows workstation |
| PowerShell | 7.6.5 |
| Git | 2.53.0 |
| Azure CLI | 2.92.0, authenticated to the lab subscription |
| Azure CLI Log Analytics extension | Preview extension installed for read-only KQL verification |
| Bicep CLI | 0.48.1 portable compiler |
| GitHub CLI | 2.103.3 portable client, authenticated |

## Azure subscription and cost boundary

- The subscription is enabled under the Azure Free Trial offer.
- The subscription spending limit is on. This is the primary hard cost boundary.
- The owner has the Owner role on the isolated lab subscription.
- The account began with no resource groups, workspaces, or other Azure resources.
- No paid Microsoft Entra license or paid Microsoft Defender plan was detected.
- A USD 5 monthly Cost Management budget was attempted but rejected by the budget API
  with `RBACAccessDenied`; therefore, no budget alert is claimed as deployed.
- The Azure portal advertised USD 200 credit for 30 days. The subscription's spending
  limit, rather than an estimated credit balance, is treated as the authoritative safety
  control.

## Live monitoring deployment

| Control | Verified state |
|---|---|
| Resource group | `p4-sentinel-monitoring-rg` |
| Region | Israel Central |
| Log Analytics workspace | `p4-sentinel-law` |
| Workspace state | Succeeded / Active |
| Workspace retention | 30 days |
| Workspace SKU | PerGB2018 (portal label: Pay-as-you-go) |
| Microsoft Sentinel onboarding | `default` onboarding state present |
| Local authentication | Disabled |
| Resource-only log access | Enabled |
| Azure Activity diagnostic setting | `sentinel-lab-azure-activity`, eight log categories enabled |
| Expiry tag | 29 November 2026 |

Public network ingestion and query remain enabled because this free lab does not deploy
private endpoints. The design contains no virtual machines or public IP addresses.

## Provider registration

The following providers were explicitly registered for the lab:

- `Microsoft.OperationalInsights`
- `Microsoft.SecurityInsights`
- `Microsoft.Insights`
- `Microsoft.OperationsManagement`

## Privacy boundary

Tenant IDs, subscription IDs, workspace IDs, user email addresses, IP addresses, access
tokens, and correlation IDs are excluded from committed evidence. Raw screenshots stay
under ignored private directories; only reviewed crops are committed.

## GitHub

- The repository is private under the project owner's GitHub account.
- Local and remote `main` branches are synchronized at each validated milestone.
- The repository must not be made public without explicit owner approval.
