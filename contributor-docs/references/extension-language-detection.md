---
page_type: reference
---

# Extension and Language Detection

Use explicit repository configuration first, then extension, then shebang.
Exclude generated, vendor, lock, minified, and build-output paths by default.
Unknown languages are read-only in the workflow: preserve comments and record
the missing framework instead of inventing syntax.
