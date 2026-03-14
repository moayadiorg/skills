#!/usr/bin/env bash
set -euo pipefail

# ── Setup Workflow Scaffold Script ──
# Creates the full spec-driven development workflow in the current directory.
#
# Usage: scaffold.sh <project-name> [--with-ui|--no-ui] [--force]

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="${SKILL_DIR}/templates"

# ── Parse arguments ──

PROJECT_NAME=""
WITH_UI=true
FORCE=false

for arg in "$@"; do
  case "$arg" in
    --with-ui)  WITH_UI=true ;;
    --no-ui)    WITH_UI=false ;;
    --force)    FORCE=true ;;
    -*)         echo "Unknown flag: $arg" >&2; exit 1 ;;
    *)          PROJECT_NAME="$arg" ;;
  esac
done

if [[ -z "$PROJECT_NAME" ]]; then
  echo "Error: Project name is required." >&2
  echo "Usage: scaffold.sh <project-name> [--with-ui|--no-ui] [--force]" >&2
  exit 1
fi

# Validate project name (alphanumeric + hyphens)
if [[ ! "$PROJECT_NAME" =~ ^[a-zA-Z][a-zA-Z0-9-]*$ ]]; then
  echo "Error: Project name must start with a letter and contain only letters, numbers, and hyphens." >&2
  exit 1
fi

# ── Check for existing CLAUDE.md ──

if [[ -f "CLAUDE.md" && "$FORCE" != true ]]; then
  echo "Warning: CLAUDE.md already exists in this directory." >&2
  echo "Use --force to overwrite existing files." >&2
  exit 1
fi

echo "Scaffolding project: ${PROJECT_NAME}"
echo "UI support: ${WITH_UI}"
echo ""

# ── Create directories ──

mkdir -p .claude/rules
mkdir -p .claude/skills/spec
mkdir -p .specs/stages
mkdir -p src
mkdir -p tests

if [[ "$WITH_UI" == true ]]; then
  mkdir -p mocks
fi

# ── Helper: copy template with placeholder replacement ──

copy_template() {
  local src="$1"
  local dst="$2"

  if [[ -f "$dst" && "$FORCE" != true ]]; then
    echo "  SKIP (exists): $dst"
    return
  fi

  # Ensure parent directory exists
  mkdir -p "$(dirname "$dst")"

  sed -e "s/{{PROJECT_NAME}}/${PROJECT_NAME}/g" \
      -e "s/{{PROJECT_ROOT}}/${PROJECT_NAME}/g" \
      "$src" > "$dst"
  echo "  CREATE: $dst"
}

# ── Copy core templates ──

echo "Creating core files..."
copy_template "${TEMPLATE_DIR}/CLAUDE.md" "CLAUDE.md"

# Strip UI-related sections from CLAUDE.md when --no-ui
if [[ "$WITH_UI" == false && -f "CLAUDE.md" ]]; then
  # Remove the ui-mock-gate.md rule reference lines (both list and tree formats)
  sed -i '/ui-mock-gate/d' "CLAUDE.md"
  # Remove Phase 3a section (from "## Phase 3a" to the next "---")
  sed -i '/^## Phase 3a/,/^---$/d' "CLAUDE.md"
  # Remove mocks/ from folder structure
  sed -i '/mocks\//d' "CLAUDE.md"
  # Remove branding interview questions and branding references in Phase 1
  # (keep Phase 1 but remove branding-specific items)
fi

copy_template "${TEMPLATE_DIR}/spec-steering.md" ".claude/spec-steering.md"

# ── Copy rules ──

echo "Creating rules..."
copy_template "${TEMPLATE_DIR}/rules/no-code-in-planning.md" ".claude/rules/no-code-in-planning.md"
copy_template "${TEMPLATE_DIR}/rules/stage-execution.md" ".claude/rules/stage-execution.md"
copy_template "${TEMPLATE_DIR}/rules/review-pipeline.md" ".claude/rules/review-pipeline.md"

if [[ "$WITH_UI" == true ]]; then
  copy_template "${TEMPLATE_DIR}/rules/ui-mock-gate.md" ".claude/rules/ui-mock-gate.md"
fi

# ── Handle settings.local.json (merge or create) ──

echo "Configuring settings..."
SETTINGS_DST=".claude/settings.local.json"

if [[ -f "$SETTINGS_DST" && "$FORCE" != true ]]; then
  # Merge hooks from template into existing settings using jq
  if command -v jq &>/dev/null; then
    TEMPLATE_SETTINGS="${TEMPLATE_DIR}/settings.local.json"
    MERGED=$(jq -s '
      .[0] as $existing | .[1] as $template |
      $existing * {
        hooks: (
          ($existing.hooks // {}) as $eh |
          ($template.hooks // {}) as $th |
          ($eh | keys) as $ek |
          ($th | keys) as $tk |
          ([$ek[], $tk[]] | unique) as $allkeys |
          reduce $allkeys[] as $k ({}; . + {
            ($k): (($eh[$k] // []) + ($th[$k] // []) | unique)
          })
        )
      }
    ' "$SETTINGS_DST" "$TEMPLATE_SETTINGS")
    echo "$MERGED" > "$SETTINGS_DST"
    echo "  MERGE: $SETTINGS_DST (hooks merged into existing settings)"
  else
    echo "  SKIP (exists): $SETTINGS_DST — install jq for automatic hook merging, or merge manually"
  fi
else
  # Copy and replace placeholders
  sed -e "s/{{PROJECT_NAME}}/${PROJECT_NAME}/g" \
      -e "s/{{PROJECT_ROOT}}/${PROJECT_NAME}/g" \
      "${TEMPLATE_DIR}/settings.local.json" > "$SETTINGS_DST"
  echo "  CREATE: $SETTINGS_DST"
fi

# ── Install spec skill locally ──

echo "Installing /spec skill..."

if [[ -f ".claude/skills/spec/SKILL.md" ]] && [[ "$FORCE" != true ]]; then
  echo "  SKIP (exists): .claude/skills/spec/"
else
  # Copy the entire spec skill tree
  cp -r "${TEMPLATE_DIR}/spec/"* ".claude/skills/spec/"
  echo "  CREATE: .claude/skills/spec/ (full spec skill)"
fi

# ── Add .gitkeep to empty directories ──

echo "Adding .gitkeep to empty directories..."

for dir in src tests .specs/stages; do
  if [[ -d "$dir" && -z "$(ls -A "$dir" 2>/dev/null)" ]]; then
    touch "$dir/.gitkeep"
    echo "  CREATE: $dir/.gitkeep"
  fi
done

if [[ "$WITH_UI" == true && -d "mocks" && -z "$(ls -A mocks 2>/dev/null)" ]]; then
  touch "mocks/.gitkeep"
  echo "  CREATE: mocks/.gitkeep"
fi

# ── Summary ──

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Project '${PROJECT_NAME}' scaffolded successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  Created:"
echo "    CLAUDE.md                     — Workflow orchestration"
echo "    .claude/rules/                — Phase enforcement rules"
echo "    .claude/spec-steering.md      — Living spec maintenance"
echo "    .claude/settings.local.json   — Hooks and permissions"
echo "    .claude/skills/spec/          — Local /spec skill"
echo "    .specs/stages/                — Specification stages"
echo "    src/                          — Source code"
echo "    tests/                        — Tests"
if [[ "$WITH_UI" == true ]]; then
  echo "    mocks/                        — UI mock designs"
fi
echo ""
echo "  Next: Say 'new project' or run /discovery-interview to begin Phase 1."
echo ""
