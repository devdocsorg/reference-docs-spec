---
page_type: reference
---

# Source Analysis Model

The analyzer resolves a repository URL and ref, records the immutable source
SHA, inventories paths, detects language profiles, and applies generated,
vendor, lock, minified, and build-output exclusions. It emits an exact input
manifest and a preservation ledger before generation.

Detection prefers explicit repository configuration, then extensions, then a
shebang. Unknown languages preserve existing comments and produce a framework
gap; the analyzer never invents comment syntax.

Each proposal records repository ID, source SHA, path, symbol, signature,
framework, statement, parameter/error/return evidence, rendered route, and
truth disposition.
