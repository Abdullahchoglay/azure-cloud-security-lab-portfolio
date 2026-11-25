# Screenshot evidence

This folder contains privacy-reviewed evidence captured from the live lab. Screenshots exclude tenant IDs, subscription IDs, workspace IDs, email addresses, IP addresses, and authentication details.

Raw captures belong in the ignored `screenshots/private/` directory.

## Evidence index

| File | Evidence | Privacy review |
|---|---|---|
| `01-workspace-overview-sanitized.jpg` | Active Log Analytics workspace in Israel Central, with the fictional lab resource-group and workspace names visible | Cropped to exclude the Azure account banner and identifier fields |
| `02-sentinel-solution-sanitized.jpg` | SecurityInsights solution connected to the fictional workspace in Israel Central | Cropped to exclude the Azure account banner and identifier fields |
| `03-sentinel-overview-sanitized.jpg` | Live Microsoft Sentinel workspace overview in the Azure portal | Cropped to exclude the account, tenant, subscription, and resource-list panels |
| `04-automation-rule-sanitized.jpg` | Enabled, scoped incident-triage automation rule in Microsoft Defender | Cropped to exclude the directory header and creator/identity columns |
| `08-analytics-rule-sanitized.jpg` | Enabled Medium-severity AZ-CP-001 scheduled analytics rule | Cropped to exclude the Defender directory/account header |
| `09-kql-live-results-sanitized.jpg` | Live `AzureActivity` Start and Success rows for the controlled diagnostic-settings write | Cropped to exclude the Azure account banner and workspace navigation |
| `11-unified-resource-groups-sanitized.jpg` | Dedicated monitoring and security resource groups in Israel Central | Cropped to exclude account, directory, and subscription identifiers |
| `13-policy-assignments-sanitized.jpg` | Two scoped Azure Policy assignments | Cropped to exclude account, directory, assignment IDs, and subscription identifiers |
| `14-policy-incident-sanitized.jpg` | Closed AZ-GOV-001 incident with Low severity, benign classification, and the `Policy-Blocked` label | Cropped to exclude browser chrome, account, directory, and identifier fields |
| `15-policy-deny-kql-sanitized.jpg` | Live `AzureActivity` query and three policy-deny Failure records, including the final controlled test | Cropped to exclude browser chrome, account banner, workspace navigation, and identifiers |
| `16-disabled-analytics-rules-sanitized.jpg` | Final Sentinel analytics state showing both project rules disabled after validation | Cropped to exclude browser chrome, account header, and navigation |
| `17-entra-group-created-sanitized.jpg` | Lab group creation | Cropped to exclude account details and visible identity identifiers |
| `18-rbac-reader-assignment-created-sanitized.jpg` | Scoped Reader role assignment | Cropped to exclude account details and visible identity identifiers |
| `19-activity-log-rbac-change-sanitized.jpg` | Role change in the Azure Activity Log | Cropped to exclude account details and visible identity identifiers |
| `20-rbac-kql-results-sanitized.jpg` | Log Analytics query results for the role change | Cropped to exclude account details and visible identity identifiers |
| `21-entra-group-deleted-sanitized.jpg` | Lab group deletion | Cropped to exclude account details and visible identity identifiers |
| `23-subscription-cancelled-sanitized.jpg` | Azure subscription cancellation confirmation | Only the confirmation message is visible |
