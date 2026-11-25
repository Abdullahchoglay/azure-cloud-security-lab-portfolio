# Azure Cloud Security Lab Readiness Report

Preparation snapshot from 4 November 2026. See the [evidence index](../evidence/README.md)
for the later live results and shutdown record.

## Outcome

The lab began with a validated repository baseline. No Azure
subscription, Sentinel workspace, connector, analytics rule, incident, or billable
resource was created during preparation.

## Prepared content

- Professional work-in-progress README and repository structure
- Cost-control and cleanup plans
- Cloud-readiness and evidence checklists
- Initial Azure Activity correlation and Entra query candidates
- Detection and analytics-rule backlogs
- Safe automation design
- Subscription-scoped Bicep for the resource group, Log Analytics workspace, Sentinel
  onboarding, and Azure Activity diagnostic setting
- PowerShell preflight and repository-validation scripts
- GitHub Actions validation workflow
- Investigation and screenshot-review templates

## Local validation

- Bicep CLI 0.48.1 compiled every Bicep source file.
- Azure CLI 2.92.0 was installed before the lab subscription was activated.
- PowerShell parsing, JSON parsing, and repository secret-pattern checks passed.

## Gates before live testing

- Azure Free Account creation, card/phone verification, and owner authentication
- Offer, credit, expiry, region, role, and licensing verification
- Azure CLI subscription authentication after the free account exists
- All live deployment, query, rule, incident, workbook, and automation evidence
