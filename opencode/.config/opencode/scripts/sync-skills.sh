#!/usr/bin/env bash
# Install every skill listed in skills-lock.json globally for opencode.
# The skills CLI puts them in ~/.agents/skills/, which opencode loads globally.
set -euo pipefail

config_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
lock="$config_dir/skills-lock.json"

command -v jq  >/dev/null || { echo "jq is required (brew install jq)" >&2; exit 1; }
command -v npx >/dev/null || { echo "npx is required (brew install node)" >&2; exit 1; }

jq -r '.skills | to_entries[] | "\(.value.source)\t\(.key)"' "$lock" |
while IFS=$'\t' read -r source skill; do
  echo "==> $skill  ($source)"
  # --copy: plain files, no symlinks back into a canonical store
  npx -y skills add "$source" --skill "$skill" -g -a opencode --copy -y </dev/null
done
