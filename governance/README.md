# Prevention and Secure Configuration

This folder is the preventive half of the Azure Cloud Security Lab. It adds secure
resource templates and Azure rules to the monitoring and response system already
validated in Sentinel.

The intended flow is:

1. Deploy a small secure baseline.
2. Apply narrow rules to the dedicated lab resource group.
3. Run harmless allowed and denied tests.
4. Observe the activity in the existing Log Analytics workspace.
5. Detect, triage, and investigate meaningful changes in Sentinel.

The baseline and both deny controls were tested live on 5 November 2026. Results are
indexed in [`../evidence/README.md`](../evidence/README.md).
