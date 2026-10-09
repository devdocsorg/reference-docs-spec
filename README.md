# reference-docs-spec

`reference-docs-spec` is the target specification repository for reusable
inline reference-documentation and static-site workflows. It is distinct from
the source repository `devdocsorg/docs-first`.

Authority record:

- Source repository: `https://github.com/devdocsorg/docs-first`
- Source revision: `637a5bc400f7abb104f98d07b92e737dc098157`
- Target repository: `https://github.com/justinr1234/reference-docs-spec`
- Target revision: recorded by each release or pull request

The source repository owns page types, ontology, contribution rules, review
rules, and documentation architecture. This repository owns only the accepted
reference-docs product workflow, skills, tutorials, audits, and product
architecture derived from that source contract.

Start with [product workflows](product-docs/workflows/index.md), then use the
[inline documentation skill](contributor-docs/skills/inline-reference-docs/SKILL.md)
and [static-site skill](contributor-docs/skills/sphinx-markdown-site/SKILL.md).
[Product documentation](product-docs/index.md) defines the user workflow, and
[contributor documentation](contributor-docs/index.md) defines the reusable
skills, tutorials, architecture, and audits.
The generated documentation path is [`docs/content`](examples/minimal-repository/docs/content).

## Verification

Run `./scripts/verify.sh` from the repository root. It checks page frontmatter,
required directories, source identity, links, and the README path reference.
