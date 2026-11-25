# Security Control Catalog

These controls extend the live monitoring lab with preventive Azure safeguards.

| ID | Control | Scope | Method | State |
|---|---|---|---|---|
| GOV-TAG-001 | Require a project tag | Security lab resource group | Deny | Verified live |
| GOV-STG-001 | Block anonymous blob access | Security lab resource group | Deny | Verified live |
| CFG-STG-001 | Require HTTPS and TLS 1.2 | Storage deployment | Secure configuration | Verified live |
| CFG-STG-002 | Default-deny storage network access | Storage deployment | Secure configuration | Verified live |
| CFG-KV-001 | Use Azure role-based access for Key Vault | Key Vault deployment | Secure configuration | Verified live |
| CFG-KV-002 | Default-deny Key Vault network access | Key Vault deployment | Secure configuration | Verified live |

The existing Sentinel pipeline can observe the deployments, denied tests, and later
changes. This connects prevention directly to detection and investigation.
