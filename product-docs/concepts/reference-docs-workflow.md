---
page_type: concept
---

# Reference Docs Workflow

The workflow separates read authorization, source freezing, representative
preview, broad staging, truth auditing, output acceptance, and destination
writing. A Qualcomm source repository can never be its own destination, and no
source branch is used as a write target.

The preview is evidence for the frozen snapshot, not a promise about unseen
files. Existing comments remain unless a separately evidenced correction is
accepted.
