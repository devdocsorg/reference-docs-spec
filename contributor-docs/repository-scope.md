---
page_type: reference
---

# Repository Scope

`devdocsorg/docs-first` remains the source repository and authority for shared
page types, ontology, contribution rules, review rules, and documentation
architecture. `reference-docs-spec` is a separate target repository under
Jackson's account. It records the exact source revision used and must not
rewrite source history or accept source-repository writes.

Product behavior belongs in `product-docs`; implementation boundaries and
verification contracts belong in `contributor-docs`.
