# Workbook

`azure-control-plane-monitoring.bicep` deploys a shared Azure Monitor workbook backed by
the lab's Log Analytics workspace. It contains:

- a bar chart of successful control-plane operations by operation type; and
- a privacy-conscious table of diagnostic-setting write/delete events.

The committed queries omit caller identity, IP address, subscription ID, tenant ID,
resource ID, workspace ID, and correlation ID from the visible workbook output.
