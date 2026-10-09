"""Run structural checks for the reference-docs-spec repository."""

from pathlib import Path
import re
import sys
from urllib.parse import unquote, urlparse

ROOT = Path(__file__).resolve().parents[2]
REQUIRED = [
    "README.md",
    "product-docs/index.md",
    "product-docs/workflows/qualcomm-preview-to-approval.md",
    "contributor-docs/skills/inline-reference-docs/SKILL.md",
    "contributor-docs/skills/inline-reference-docs/references/language-framework-matrix.md",
    "contributor-docs/skills/inline-reference-docs/references/truth-audit-checklist.md",
    "contributor-docs/skills/sphinx-markdown-site/SKILL.md",
    "contributor-docs/references/source-artifacts/reference-docs-spec-implementation-plan.md",
    "contributor-docs/references/source-artifacts/qualcomm-reference-docs-preview-design.md",
]

errors = [f"missing required path: {p}" for p in REQUIRED if not (ROOT / p).exists()]
for path in ROOT.rglob("*.md"):
    if path.name == "README.md" or path.parts[0] in {".git", "docs"} or "content" in path.parts:
        continue
    text = path.read_text(encoding="utf-8")
    if not re.match(r"\A---\npage_type: (overview|tutorial|concept|reference)\n---\n", text):
        errors.append(f"missing or invalid page_type frontmatter: {path.relative_to(ROOT)}")
    for match in re.finditer(r"\[[^\]]+\]\(([^)#]+)(?:#[^)]+)?\)", text):
        target = unquote(match.group(1))
        parsed = urlparse(target)
        if parsed.scheme or target.startswith("/"):
            continue
        target_path = (path.parent / target).resolve()
        if not target_path.exists():
            errors.append(f"broken local link: {path.relative_to(ROOT)} -> {target}")

readme = (ROOT / "README.md").read_text(encoding="utf-8")
for target in ("product-docs/index.md", "contributor-docs/index.md"):
    if target not in readme:
        errors.append(f"README does not link to {target}")

if errors:
    print("\n".join(errors))
    sys.exit(1)

print(f"verified {len(list(ROOT.rglob('*.md')))} Markdown pages and required scaffold paths")
