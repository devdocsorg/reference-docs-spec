---
page_type: tutorial
---

# Qualcomm Preview To Approval

This workflow is the canonical product contract for the accepted Qualcomm
preview app. It accepts a source repository, revision, destination, and
authorization boundary; inventories files; applies exclusions; selects
representative files; and presents per-file proposals with existing-comment
context and truth evidence.

The preview must expose rendered docs and sidebar implications, an agent-chat
refinement path, durable preferences, and explicit approval for one file, one
type, or the full repository. It must support loading, empty, inaccessible
repository, invalid revision, unsupported language, generated/vendor, stale
source, cancellation, retry, partial failure, completion, and return-to-preview
states.

Writes preserve source-repository immutability. They use a fork or review
branch with isolated credentials, an auditable preservation ledger, cleanup
records, and production verification. The full accepted research, design, and
architecture inputs are retained in
[source artifacts](../../contributor-docs/references/source-artifacts/) and
summarized in the contributor architecture pages.

