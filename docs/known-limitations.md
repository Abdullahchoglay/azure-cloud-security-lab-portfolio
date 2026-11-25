# Known Limitations

- This is a small control-plane lab, not a production security operations centre.
- The activity is controlled and authorized. It does not prove detection of a real
  attacker or compromised identity.
- Azure Activity data was used for control-plane and Azure RBAC monitoring. Entra
  sign-in logs, endpoint, email, firewall, and application telemetry remain outside
  the project scope.
- The three detections are deliberately narrow. Two generated live Sentinel incidents;
  the RBAC scenario verified the live event and hunt while preserving its scheduled
  rule as disabled-by-default source. Production
  rules would need longer testing, tuning, ownership, and response procedures.
- The MITRE ATT&CK mapping provides context. A policy denial or configuration change
  is not automatically malicious; intent must be established during investigation.
- Native Sentinel automation was used instead of a Logic App to avoid unnecessary
  cost and permissions. The project therefore demonstrates triage, not full
  remediation orchestration.
- The storage account, Key Vault, and network security group are empty demonstration
  resources. Their settings were verified, but no production workload depends on
  them.
- The Azure Free Trial did not expose the Cost Management query API. Cost evidence is
  therefore based on the authenticated portal view, which showed zero month-to-date
  cost during final review.
- At cancellation on 5 November 2026, Azure confirmed that resources had been
  turned off and that the subscription and retained data were scheduled for deletion.
