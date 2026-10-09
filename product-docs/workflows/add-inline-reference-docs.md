---
page_type: tutorial
---

# Add Inline Reference Docs

Use this procedure when you need a reviewable documentation proposal for a
repository.

1. Record the repository URL or local path, revision, destination policy,
   exclusion rules, and authorization boundary.
2. Inventory source files and classify them by the
   [language detection rules](../references/extension-language-detection.md).
3. Exclude generated, vendor, lock, minified, and build-output files unless
   the request explicitly includes them.
4. Select representative files and show existing comments beside each proposal.
5. Generate proposals from signatures, implementations, tests, configuration,
   and accepted product rules. Record the evidence for every statement.
6. Run the [truth-audit checklist](../../contributor-docs/skills/inline-reference-docs/references/truth-audit-checklist.md).
7. Render the site, check its sidebar and links, and inspect the output.
8. Obtain explicit approval for one file, one type, or the full repository.
9. Write only to a fork or review branch, then retain the source revision,
   review branch, audit, and cleanup evidence.

Cancellation preserves the preview and audit record without writing. Retry
reuses the frozen revision and records a new attempt. Partial failure leaves
successful proposals reviewable and marks failed files for retry.

