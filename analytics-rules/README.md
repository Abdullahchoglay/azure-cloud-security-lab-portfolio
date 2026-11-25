# Analytics Rules

Do not create a scheduled rule from an unvalidated query. Each promoted rule must
record its query period, frequency, threshold, entity mappings, incident behavior,
ATT&CK mapping, false positives, and observed test result.

`AZ-CP-001-diagnostic-settings-change.bicep` is deployable but disabled by default. It
must remain disabled until its KQL is proven against live `AzureActivity` data. Alert
and incident behavior require separate evidence before the rule is described as
verified.
