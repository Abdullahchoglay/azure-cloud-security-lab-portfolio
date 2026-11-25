# AZ-WB-001 — Azure Control-Plane Monitoring Workbook

## Objective

Provide a reusable analyst view of successful Azure control-plane operations and
diagnostic-setting changes without exposing identity or Azure identifiers.

## Deployment result

The shared workbook `Azure Cloud Security - Prevention and Response` deployed
successfully in Israel Central and appears as a saved custom workbook.

## Validation result

The first rendered revision exposed an undefined `TimeRange` parameter. The source was
corrected to a fixed 24-hour window and redeployed. The corrected revision was reopened
directly in Azure and both query tiles rendered without parameter or syntax errors.

After Azure Activity ingestion began, the workbook displayed diagnostic-setting
changes and general control-plane operations. It was later expanded with secure
baseline and preventive-policy activity views so prevention and response remain one
analyst workflow.

The earlier numbered-title workbook screenshots were retired during the unified-project
rename. Live query evidence remains preserved in the detection record, and the workbook
source is reproducible from Bicep.
