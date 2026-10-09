---
page_type: reference
---

# Skill Execution Contract

Skills are deterministic, reviewable sources. Inputs include repository path or
URL, ref, language scope, exclusions, destination policy, and write mode.
Outputs include inventory, exact manifests, preservation ledger, proposals,
truth audit, route map, failures, and verification results.

Workers are idempotent by authorization ID and input-manifest hash. They
support queued, running, cancelling, cancelled, completed, partial, failed,
and stale states. Credentials stay in the provider boundary and never enter
prompts, artifacts, or logs.
