# Threat Model

## Assets

- Azure subscription integrity and free-account credit
- Microsoft Entra identities and role assignments
- Log Analytics and Sentinel configuration
- Detection source, incidents, and investigation evidence
- GitHub repository history and CI workflow

## Threats and mitigations

| Threat | Planned mitigation |
|---|---|
| Cost overrun | Spending protection, daily review, no compute, expiry tags, cleanup ledger |
| Accidental production impact | Dedicated resource groups and no unrelated connectors |
| Excessive privilege | Least privilege, no autonomous privileged role changes |
| Public exposure | No VM or public IP; deny anonymous storage access |
| Evidence leakage | Sanitized text-first evidence and complete-history scanning |
| Detection overclaim | Separate verification states and marker-based scenarios |
| Alert flooding | Low-volume scenarios, tuned thresholds, and bounded scheduling |
| Unsafe automation | Classification and analyst-task actions only; no containment |
| IaC drift | Bicep source, deployment inventory, and GitHub validation |

## Out of scope

- Production security architecture
- Malware, exploitation, password spraying, or MFA bypass
- Automatic account disabling or session revocation
- Public honeypots or intentionally exposed cloud services
- Premium Entra capabilities unless they are already licensed at no added cost
