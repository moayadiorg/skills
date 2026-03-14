#!/usr/bin/env bash
set -euo pipefail

# ── Attention Bell Hook Installer ──
# Merges terminal bell hooks into Claude Code settings.
#
# Usage: install-hooks.sh [--global|--project]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCOPE="global"

for arg in "$@"; do
  case "$arg" in
    --global)   SCOPE="global" ;;
    --project)  SCOPE="project" ;;
    -*)         echo "Unknown flag: $arg" >&2; exit 1 ;;
  esac
done

# ── Determine target file ──

if [[ "$SCOPE" == "global" ]]; then
  SETTINGS_FILE="${HOME}/.claude/settings.local.json"
  mkdir -p "${HOME}/.claude"
else
  SETTINGS_FILE=".claude/settings.local.json"
  mkdir -p ".claude"
fi

# ── Hook template ──

HOOKS_FILE="${SCRIPT_DIR}/hooks.json"

# ── Install ──

if [[ -f "$SETTINGS_FILE" ]]; then
  # Merge hooks into existing settings
  if command -v jq &>/dev/null; then
    MERGED=$(jq -s '
      .[0] as $existing | .[1] as $new |
      $existing * {
        hooks: (
          ($existing.hooks // {}) as $eh |
          ($new.hooks // {}) as $nh |
          ($eh | keys) as $ek |
          ($nh | keys) as $nk |
          ([$ek[], $nk[]] | unique) as $allkeys |
          reduce $allkeys[] as $k ({}; . + {
            ($k): (
              if ($nh[$k] // null) != null then
                $nh[$k]
              else
                $eh[$k]
              end
            )
          })
        )
      }
    ' "$SETTINGS_FILE" "$HOOKS_FILE")
    echo "$MERGED" > "$SETTINGS_FILE"
    echo "MERGE: $SETTINGS_FILE (bell hooks added, existing settings preserved)"
  else
    echo "Error: jq is required to merge hooks into existing settings." >&2
    echo "Install jq (e.g., 'brew install jq' or 'sudo dnf install jq') and retry." >&2
    exit 1
  fi
else
  # Create new settings file with just the hooks
  cp "$HOOKS_FILE" "$SETTINGS_FILE"
  echo "CREATE: $SETTINGS_FILE"
fi

echo ""
echo "Bell hooks installed (${SCOPE})."
echo "Restart Claude Code for hooks to take effect."
