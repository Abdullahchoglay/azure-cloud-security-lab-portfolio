# CLEANUP-001 — Azure subscription cancellation

## Result

The Azure Free Trial subscription was canceled on 5 November 2026 after all portfolio
evidence had been exported. Immediately before cancellation, the subscription overview
showed a current cost of 0.00 and a forecast of 0.00.

Azure confirmed:

- subscription status: Canceled;
- all resources were turned off;
- the resources no longer incur charges;
- the subscription and retained data are scheduled for automatic deletion after
  30 days;
- manual deletion becomes available after three days.

The resource groups were not individually deleted. This distinction is preserved so
the repository does not claim immediate removal when Azure is retaining the stopped
resources during its cancellation period.

## Evidence

- [Cropped Azure cancellation confirmation](../screenshots/23-subscription-cancelled-sanitized.jpg)
- [`../docs/cleanup-verification-report.md`](../docs/cleanup-verification-report.md)
