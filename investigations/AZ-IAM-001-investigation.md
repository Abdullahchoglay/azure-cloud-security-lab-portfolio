# AZ-IAM-001 Access-Change Investigation

## Executive summary

Azure recorded a successful Reader role assignment to an empty fictional group at the
dedicated security lab resource group. The change was authorized, least-privileged,
time-limited, and made solely to validate access-change monitoring. No production user
received access and the assignment did not apply at subscription scope.

## Analyst questions

| Question | Finding |
|---|---|
| What changed? | A Reader role assignment was created. |
| Which principal received access? | `ACSLab-SOC-Readers`, an empty fictional security group. |
| What was the scope? | Only `acslab-security-rg`. |
| Was the operation successful? | Yes; Started and Success records were observed. |
| Was the change authorized? | Yes; it was the documented portfolio test. |
| Did it grant write access? | No; Reader is read-only. |
| Did a production user receive access? | No; the group had no members. |
| What should happen next? | Remove the temporary assignment and group after evidence preservation. |

## Disposition

- Classification: benign positive / authorized test
- Risk: low
- Response: evidence preserved; temporary access and group removed; cleanup verified
- Escalation: not required

In a real environment, an unexpected result would be escalated to the resource owner,
the caller and approval trail would be verified, the role and scope would be assessed,
and unauthorized access would be removed immediately.

## Cleanup verification

The fictional group was deleted. Azure initially displayed its former assignment as an
unknown principal, demonstrating why identity deletion alone is not sufficient RBAC
cleanup. The orphaned Reader assignment was then removed separately. The final IAM
view contained one inherited Owner assignment and no Reader assignment.
