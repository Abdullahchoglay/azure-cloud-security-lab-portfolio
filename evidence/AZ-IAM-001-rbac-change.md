# AZ-IAM-001 — Scoped Azure RBAC Change

## Result

Live Azure evidence verified that a temporary Reader assignment to an empty,
fictional security group generated the expected control-plane telemetry.

## Controlled action

- Group: `ACSLab-SOC-Readers`
- Membership: empty
- Role: Reader
- Scope: `acslab-security-rg` only
- Purpose: authorized portfolio detection test
- Production access: none

## Evidence chain

1. Microsoft Entra security group created with a lab-only description.
2. Reader assigned only at the dedicated security resource-group scope.
3. Azure Activity Log displayed Create role assignment with Started and Succeeded
   records.
4. Log Analytics returned two matching `AzureActivity` rows for
   `Microsoft.Authorization/roleAssignments/write`.
5. A narrow KQL hunt and disabled-by-default Sentinel scheduled-rule definition were
   preserved in source control.
6. The empty group was deleted and the resulting unknown-principal role assignment
   was removed. IAM then showed only the inherited Owner assignment.

## Verification state

- Identity structure: verified live
- Azure RBAC change: verified live
- Azure Activity event: verified live
- Log Analytics query: verified live
- Scheduled analytics rule: source prepared; disabled by default
- Incident claim: not made for this scenario
- Temporary group: deleted after evidence preservation
- Temporary role assignment: removed and absence verified

This distinction is deliberate. The live event and query were proven, while the
tenant's unified rule screen did not accept this Azure Activity query during the final
session. Existing project scenarios already demonstrate live Sentinel incidents and
automation.

## Reviewed screenshots

- [Test group created](../screenshots/17-entra-group-created-sanitized.jpg)
- [Reader role assigned](../screenshots/18-rbac-reader-assignment-created-sanitized.jpg)
- [Role assignment in the Azure Activity Log](../screenshots/19-activity-log-rbac-change-sanitized.jpg)
- [Matching Log Analytics results](../screenshots/20-rbac-kql-results-sanitized.jpg)
- [Test group deleted](../screenshots/21-entra-group-deleted-sanitized.jpg)

Personal identifiers and unrestricted event payloads are not reproduced here.
