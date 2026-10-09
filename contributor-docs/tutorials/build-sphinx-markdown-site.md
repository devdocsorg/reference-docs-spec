---
page_type: tutorial
---

# Build a Sphinx and Markdown Site

Populate `docs/tooling` with the Sphinx/MyST source tree and write generated
HTML to `docs/content`. A minimal repository can use the pinned dependencies
and commands below:

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r docs/tooling/requirements.txt
docs/tooling/build.sh
docs/tooling/linkcheck.sh
```

Add every generated route from `route-manifest.txt` to the landing page
toctree. The build and link-check outputs, generated files, route inventory,
and README file-path link are the review evidence.
