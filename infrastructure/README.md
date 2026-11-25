# Infrastructure Source

The prepared subscription-scoped Bicep creates a dedicated monitoring resource group,
one Log Analytics workspace with 30-day retention, and the Sentinel onboarding state.
A separate template prepares the Azure Activity diagnostic setting.

Both templates compile locally and have been validated through Azure Resource Manager.
The foundation and Azure Activity diagnostic setting were deployed successfully on
4 November 2026 after all cloud-readiness and cost gates passed.

Required provider namespaces are `Microsoft.OperationalInsights`,
`Microsoft.SecurityInsights`, `Microsoft.Insights`, and
`Microsoft.OperationsManagement`.

Local parameter files containing real identifiers or deployment values must use the
ignored local suffixes. Tenant and subscription identifiers must never be committed.
