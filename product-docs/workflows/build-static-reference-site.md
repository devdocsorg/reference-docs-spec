---
page_type: tutorial
---

# Build A Static Reference Site

Applied repositories keep source and generated output separate:
`docs/tooling` owns configuration and scripts, while `docs/content` owns the
rendered site.

Run the repository's documented build command, then verify that
`docs/content/index.html` exists, the sidebar exposes Overview, Reference,
Configuration, and every generated API group, and internal links resolve.
The repository README must link to `docs/content/index.html` and name the
refresh command.

