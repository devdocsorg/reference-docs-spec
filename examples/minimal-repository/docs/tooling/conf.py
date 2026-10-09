"""Sphinx configuration for the generated reference site example."""

from pathlib import Path

project = "Reference Documentation"
copyright = "DevDocs"
author = "DevDocs"

extensions = ["myst_parser"]
templates_path = ["_templates"]
exclude_patterns = ["_build", "README.md"]
source_suffix = {".md": "markdown", ".rst": "restructuredtext"}
master_doc = "index"
html_theme = "alabaster"
html_title = "Reference Documentation"
html_copy_source = False

root = Path(__file__).parent
html_extra_path = [str(root / "route-manifest.txt")]
