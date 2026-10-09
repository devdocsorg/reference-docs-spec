---
page_type: reference
---

# Inline Reference Docs Skill

Use this skill when a repository needs reviewable inline reference
documentation.

## Inputs

- Repository path or URL and target revision.
- Language scope or `all-supported-languages`.
- Generated/vendor exclusions.
- Destination policy and fork, branch, or local-only write policy.

## Outputs

Produce a frozen source record, file inventory, representative-file set,
existing-comment preservation ledger, source-backed proposals, truth-audit
result, docs-site routing map, approval scope, and cleanup record.

## Contract

Freeze and inventory first. Parse structurally where possible. Preserve existing
comments, documenting every correction with evidence. Require explicit approval
for one file, one type, or the full repository. Write only to the authorized
fork or review branch. Stop on an unknown framework, missing source revision,
inaccessible repository, failed truth audit, or missing approval.

