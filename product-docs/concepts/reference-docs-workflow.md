---
page_type: concept
---

# Reference Docs Workflow

The workflow turns source evidence into reviewable reference documentation
without mutating the source repository. A run freezes a source revision,
inventories files, selects representative files, proposes comments, records
existing-comment decisions, audits truth, renders documentation, and waits for
explicit approval.

Approval is scoped: a reviewer may approve one file, one language/type, or the
full repository. A preview is not an authorization to write. Approved writes
target a fork or review branch, and every output links back to its source
inventory item and evidence.

