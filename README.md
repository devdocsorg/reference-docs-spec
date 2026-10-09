# Reference Docs Spec

`reference-docs-spec` defines a docs-first workflow for adding truthful inline
reference documentation to an existing repository and reviewing the rendered
result before approval.

Start with the [product documentation](product-docs/index.md) to understand
the user workflow. Contributors should then read the
[contributor documentation](contributor-docs/index.md), especially the
[inline-reference-docs skill](contributor-docs/skills/inline-reference-docs/SKILL.md)
and [verification commands](contributor-docs/references/verification-commands.md).

The accepted Qualcomm preview contract is canonical in
[product-docs/workflows/qualcomm-preview-to-approval.md](product-docs/workflows/qualcomm-preview-to-approval.md)
and its source artifacts are preserved in
[contributor-docs/references/source-artifacts](contributor-docs/references/source-artifacts/).

## Local verification

Run:

```sh
python3 contributor-docs/scripts/verify_repository.py
```

An applied target repository builds its generated site into
`docs/content/index.html`; the README of that target must link to that file
path.

