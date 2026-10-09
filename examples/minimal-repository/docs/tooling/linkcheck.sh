#!/usr/bin/env sh
set -eu

root=$(CDPATH= cd -- "$(dirname "$0")/../.." && pwd)
tooling="$root/docs/tooling"
output="$root/docs/content"

python -m sphinx -W --keep-going -b linkcheck "$tooling" "$output/.linkcheck"
