# One Security Lifecycle

The lab follows the order a real cloud security programme should follow.

## 1. Build safely

Small Azure resources are defined in Bicep with secure settings, expiry tags, no
virtual machines, and no public management ports.

## 2. Prevent weak configurations

Narrow Azure rules require project tags and block anonymous storage. Harmless denied
tests show whether those rules work.

## 3. Observe activity

The Azure Activity Log flows to one Log Analytics workspace. The same route records
normal deployments, denied actions, and important configuration changes.

## 4. Detect meaningful changes

Sentinel queries and rules focus on changes that can weaken visibility, beginning with
diagnostic settings. New secure-resource and policy tests naturally create the next
set of useful events.

## 5. Triage and investigate

Safe automation labels and prioritizes the incident. The analyst then checks the
event, expected baseline, surrounding activity, and impact before closing the case.

This is one connected project: prevention creates the guardrails, monitoring proves
what happened, and investigation shows whether the controls and response worked.
