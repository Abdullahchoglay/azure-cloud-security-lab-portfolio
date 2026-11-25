# Detection Backlog

| ID | Candidate | Required table | Initial ATT&CK mapping | State |
|---|---|---|---|---|
| AZ-CP-001 | Diagnostic settings changed or deleted | AzureActivity | T1562 (intent dependent) | Verified live; IaC disabled after test |
| AZ-GOV-001 | Azure Policy blocked a lab resource | AzureActivity | T1562 (intent dependent) | Verified live; incident closed; IaC disabled after test |
| AZ-CP-002 | Resource write followed by delete | AzureActivity | T1070.004 analytical analogy; confirm before publication | Prepared |
| AZ-NET-001 | Network security rule modification | AzureActivity | T1562.007 | Prepared |
| AZ-POL-001 | Security policy assignment change | AzureActivity | T1562.001 | Prepared |
| ENTRA-ID-001 | User or group lifecycle change | AuditLogs | T1136.003 or T1098 | Optional |
| ENTRA-AUTH-001 | Repeated failure followed by success | SigninLogs | T1110 and T1078 | Optional |

Mappings are hypotheses until the exact observed operation and intent are documented.
