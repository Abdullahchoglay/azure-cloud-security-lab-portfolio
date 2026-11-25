# COST-001 — Cost Controls and Resource Inventory

## Verification result

Final live verification on 4 November 2026 confirmed:

| Control | Result |
|---|---|
| Azure Free Trial spending limit | Enabled |
| Portal month-to-date cost display | 0 |
| Log Analytics workspaces | 1 |
| Sentinel solutions | 1 |
| Custom workbooks | 1 |
| Subscription diagnostic settings | 1, with 8 categories enabled |
| Virtual machines | 0 |
| Public IP addresses | 0 |
| Logic Apps / playbooks | 0 |
| Secure baseline storage accounts | 1, empty |
| Secure baseline Key Vaults | 1, no secrets or keys |
| Network security groups | 1, no inbound rules |
| Enforced Azure Policy assignments | 2, limited to the security lab resource group |
| Analytics rule after test | Disabled |
| Automation rule after test | Disabled |

The Free Trial offer returned an unsupported-offer error from the Cost Management query
API. Therefore, the repository records the portal's zero display as an observation and
does not claim an independently reconciled billing total. A budget is also not claimed:
the subscription rejected budget creation because the account lacked the required Cost
Management permission.

The Azure Retail Prices API check on 5 November 2026 returned USD 0.04 per 10,000
standard Key Vault operations and roughly USD 0.02 per GB-month for standard block-blob
storage in Israel Central. This lab stores no objects, secrets, keys, or certificates,
so only a few control-plane operations were generated. These are price-meter checks,
not a substitute for settled billing data.

The workspace and diagnostic route remain temporarily deployed for review. The cleanup
target is 29 November 2026, and the sequence is documented in
[`docs/cleanup-plan.md`](../docs/cleanup-plan.md).
