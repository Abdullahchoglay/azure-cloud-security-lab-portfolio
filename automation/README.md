# Safe SOAR Automation

`AZ-CP-001-incident-triage.bicep` deploys a Microsoft Sentinel automation rule scoped
only to incidents created by the AZ-CP-001 analytics rule. It performs cost-free,
reversible incident-management actions:

- changes the incident status to Active;
- sets severity to Medium; and
- adds the `SOAR-Triaged` label.

It does not disable accounts, delete resources, change firewall rules, invoke an
external service, or deploy a billable Logic App. Live execution is verified separately
from successful deployment.
