# Safe Reproduction Guide

This guide recreates the lab without repeating the original live test blindly. Use a
new Azure subscription or an isolated lab subscription, review every deployment, and
keep the analytics and automation rules disabled until the test window begins.

## Before deployment

1. Confirm the active subscription is the lab subscription. Check current pricing
   and the applicable spending limit. A budget alert does not cap charges.
2. Use a dedicated resource group and a unique project tag.
3. Review the Bicep files in `infrastructure/` and `governance/`.
4. Keep storage, Key Vault, and the workspace empty of real data.
5. Do not deploy virtual machines, public IP addresses, Logic Apps, secrets, or keys.

## Build the lab

1. Deploy the monitoring foundation from `infrastructure/`.
2. Confirm that the Log Analytics workspace and Sentinel solution exist.
3. Route Azure Activity Logs to the workspace.
4. Deploy the secure baseline from `governance/`.
5. Confirm that storage blocks anonymous access, Key Vault uses RBAC, and the network
   security group has no inbound rules.
6. Apply the two scoped Azure rules: require the project tag and deny anonymous blob
   access.

The two `main.bicep` entry points and `infrastructure/activity-diagnostic.bicep`
are subscription-scoped. For the Activity Log export, pass the
`workspaceResourceId` output from the monitoring deployment. The templates under
`analytics-rules/`, `automation/`, and `workbooks/` target the monitoring resource
group. Pass the same workspace name to each. Deploy the analytics rule before its
matching automation rule. Review an Azure deployment what-if before applying each
template.

Subscription-level Activity Log export can include events outside a single resource
group. Use a dedicated subscription with synthetic activity and check existing
diagnostic settings before adding the lab destination.

## Validate safely

1. Run the harmless diagnostic-settings write described in the evidence records.
2. Confirm its Start and Success records in `AzureActivity`.
3. During a short test window, enable `AZ-CP-001` and its paired automation, generate
   one event, verify the incident and label, then disable both rules.
4. Wait for the policy assignments to take effect. Enable `AZ-GOV-001` and its paired
   automation before running the [policy tests](../evidence/GOV-DENY-001-policy-enforcement.md).
   Use only the empty lab resources in `governance/tests/` and upload no data.
5. Confirm Azure returns `RequestDisallowedByPolicy` and neither test resource exists.
   If either deployment succeeds, stop the test, remove that test resource, and check
   the assignment and scope before retrying.
6. Verify the policy incident and label, close the investigation, and disable both
   rules. For the optional access-change scenario, follow the
   [RBAC investigation](../investigations/AZ-IAM-001-investigation.md).

## Finish

1. Export only sanitized screenshots and evidence records.
2. Confirm both incidents are closed and all test analytics and automation rules are disabled.
3. Check the current cost and inventory.
4. Follow `docs/cleanup-plan.md` when the demonstration period ends.

Never use production identities, customer data, secrets, destructive workloads, or a
broad subscription-wide delete command in this lab.
