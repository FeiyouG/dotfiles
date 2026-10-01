#!/usr/bin/env bash
# Install opencode's global agent skills, commands and tools:
#   1. skills listed in skills-lock.json  -> ~/.agents/skills/
#   2. OpenSpec skills + /opsx:* commands -> ~/.config/opencode/{skills,commands}/
#   3. Plannotator binary + /plannotator-* commands and skills
# Safe to re-run; re-run after `brew upgrade openspec` to refresh OpenSpec files.
set -euo pipefail

config_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
lock="$config_dir/skills-lock.json"

require() { command -v "$1" >/dev/null || { echo "$1 is required ($2)" >&2; exit 1; }; }
require jq       "brew install jq"
require npx      "brew install node"
require openspec "brew install openspec"
require curl     "preinstalled on macOS"

# 1) Skills from skills-lock.json
jq -r '.skills | to_entries[] | "\(.value.source)\t\(.key)"' "$lock" |
while IFS=$'\t' read -r source skill; do
  echo "==> skill: $skill  ($source)"
  # --copy: plain files, no symlinks back into a canonical store
  npx -y skills add "$source" --skill "$skill" -g -a opencode --copy -y </dev/null
done

# 2) OpenSpec: `openspec init` only writes per-project files, so generate them
#    in a temp dir and install them into the global opencode config.
echo "==> openspec $(openspec --version)"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
OPENSPEC_TELEMETRY=0 openspec init --tools opencode "$tmp" >/dev/null
mkdir -p "$config_dir/skills" "$config_dir/commands"
rm -rf "$config_dir"/skills/openspec-* "$config_dir"/commands/opsx-*.md
cp -R "$tmp"/.opencode/skills/openspec-* "$config_dir/skills/"
cp "$tmp"/.opencode/commands/opsx-*.md "$config_dir/commands/"

# 3) Plannotator: the plan-review plugin is set in opencode.json; this installs
#    the binary (~/.local/bin) and the /plannotator-* commands and skills.
echo "==> plannotator"
curl -fsSL https://plannotator.ai/install.sh | bash -s -- --non-interactive --no-extras
