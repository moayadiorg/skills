# No Code During Planning Phases

> Path scope: global (all files)

## Rule

Before executing any `Write` or `Edit` tool call that targets a code file, check the current project phase in `.specs/project.living.md` (look for the `Current Phase` field in the header).

**If the phase is 🔵 Planning or 📋 Interview → REFUSE code generation.**

### Allowed during planning phases
- `.md` files in `.specs/` and `.specs/stages/*/`
- `.md` files in `.claude/` and project root
- `mocks/` HTML files (Phase 3a mock design only, after spec phase completes)

### Blocked file extensions during planning
`.ts`, `.tsx`, `.js`, `.jsx`, `.py`, `.go`, `.rs`, `.java`, `.html`, `.css`, `.scss`, `.sass`, `.less`, `.vue`, `.svelte`, `.json` (except config), `.yaml`, `.yml`, `.toml`, `.sql`, `.sh`, `.bash`, `.rb`, `.php`, `.swift`, `.kt`, `.dart`, `.c`, `.cpp`, `.h`

### Response when blocked
```
⛔ Code generation is blocked during the {{current_phase}} phase.

Current phase: {{current_phase}}
Allowed actions: Creating and editing specification documents in .specs/

To proceed to the Execution phase:
1. Complete the Interview phase (PRD.md must exist with all checklist items checked)
2. Complete the Specification phase (all stages created, dependencies mapped)
3. Update project.living.md phase to 🟢 Building
```

### How to check
1. Read `.specs/project.living.md` → find `**Current Phase:**` line
2. If value contains "Planning" or "Interview" → block
3. If value contains "Building" or "Operating" → allow code generation
4. If file doesn't exist → assume Planning phase → block
