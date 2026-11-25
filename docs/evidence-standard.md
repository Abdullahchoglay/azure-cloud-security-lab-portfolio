# Evidence Standard

## Verification states

1. Prepared — source or query exists but has not been run against live lab data.
2. Source telemetry verified — the originating Azure or Entra event was observed.
3. Hunting-query verified — the saved KQL returned the marked source event.
4. Analytics-rule verified — the scheduled rule executed against the observed schema.
5. Live incident verified — a Sentinel alert and incident were observed.
6. Automated response verified — the configured automation action completed.

## Required scenario fields

- Scenario and marker
- UTC timestamp plus local timezone
- Fictional initiating identity
- Affected resource or directory object
- Source table and operation
- Result and correlation or operation identifier when safe
- Query and analytics-rule name
- Alert severity and incident number when observed
- ATT&CK mapping with analytical justification
- Analyst assessment, false positives, limitations, and cleanup result

## Sanitization

Tenant IDs, subscription IDs, object IDs, personal names, email addresses, tokens,
billing information, full IP addresses, and unrelated browser content stay outside
Git. Sanitization may replace identifiers but must not alter the event meaning.
