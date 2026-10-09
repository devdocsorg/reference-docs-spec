#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
required=(
  README.md
  product-docs/index.md
  contributor-docs/index.md
  contributor-docs/skills/inline-reference-docs/SKILL.md
  contributor-docs/skills/sphinx-markdown-site/SKILL.md
  contributor-docs/references/accepted-source-summary.md
  examples/minimal-repository/docs/tooling
  examples/minimal-repository/docs/content
  examples/minimal-repository/docs/tooling/conf.py
  examples/minimal-repository/docs/tooling/requirements.txt
  examples/minimal-repository/docs/tooling/index.md
  examples/minimal-repository/docs/tooling/route-manifest.txt
  examples/minimal-repository/docs/tooling/build.sh
  examples/minimal-repository/docs/tooling/linkcheck.sh
)
for path in "${required[@]}"; do
  test -e "$root/$path" || { echo "missing: $path" >&2; exit 1; }
done

test "$(rg -l '^page_type: (overview|tutorial|concept|reference)$' "$root" --glob '*.md' | wc -l | tr -d ' ')" -ge 40
rg -q 'devdocsorg/docs-first' "$root/README.md"
rg -q '637a5bc400f7abb104f98d07b92e737dc098157' "$root/contributor-docs/references/accepted-source-summary.md"
rg -q '\[.*docs/content/index\.html.*\]\(.*docs/content/index\.html\)' "$root/README.md"
rg -q '\[.*docs/content/index\.html.*\]\(.*docs/content/index\.html\)' "$root/examples/minimal-repository/README.md"

bad_links=0
while IFS= read -r link; do
  target="${link#*\(}"
  target="${target%%\)*}"
  [[ "$target" =~ ^https?:// ]] && continue
  [[ "$target" =~ ^# ]] && continue
  source="${link%%:*}"
  path="${target%%#*}"
  [[ -z "$path" ]] && continue
  if [[ ! -e "$root/$source/$(dirname "$path")" && ! -e "$root/$source/$path" ]]; then
    echo "unresolved relative link: $source -> $target" >&2
    bad_links=1
  fi
done < <(rg -n -o '[^:]+:\[[^]]+\]\([^)]*\)' "$root" --glob '*.md' | sed 's/:/\n/' | sed 's/\(.*\):\[\(.*\)/\1:[\2/')
test "$bad_links" -eq 0

example="$root/examples/minimal-repository"
(
  cd "$example"
  test -x docs/tooling/build.sh
  test -x docs/tooling/linkcheck.sh
  test -f docs/content/.gitkeep
  test -f docs/content/.gitignore
  docs/tooling/build.sh
  test -f docs/content/index.html
  while IFS= read -r route; do
    test -n "$route"
    test -f "docs/content/${route}.html"
    rg -q "$route" docs/content/index.html
  done < docs/tooling/route-manifest.txt
  docs/tooling/linkcheck.sh
)
echo "reference-docs-spec verification passed"
