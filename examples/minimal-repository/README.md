# Minimal Repository

This example shows the expected generated documentation locations:
[`docs/tooling`](docs/tooling) and [`docs/content/index.html`](docs/content/index.html).

Build and check the site from this directory:

```sh
python3 -m venv .venv
. .venv/bin/activate
python -m pip install -r docs/tooling/requirements.txt
docs/tooling/build.sh
docs/tooling/linkcheck.sh
```
