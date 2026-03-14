# {{PROJECT_NAME}} — Spec-Driven Development Workflow

## Current State

- **Phase tracking**: `.specs/project.living.md` (created during Phase 2)
- **Spec steering**: `.claude/spec-steering.md`

---

## Workflow Overview

This project follows a 5-phase pipeline. Each phase has explicit triggers, processes, and exit gates.

```
Phase 1: Interview → Phase 2: Specification → Phase 3: Execution → Phase 4: Review → Phase 5: Tracking
     (no code)            (no code)             (code)            (automatic)       (continuous)
```

**Rules enforcement**: `.claude/rules/` contains guard rules that are automatically loaded:
- `no-code-in-planning.md` — Blocks code generation during Phases 1-2
- `stage-execution.md` — Dependency checks and agent selection for Phase 3
- `review-pipeline.md` — 3-agent review pipeline for Phase 4
- `ui-mock-gate.md` — Blocks UI code without approved mocks

---

## Phase 1 — Interview (No Code)

**Triggers**: User says "new project", "interview", "let's start", or runs `/discovery-interview`

**Process**:
1. Run the `/discovery-interview` skill
2. Output is saved to `.specs/PRD.md` (override the skill's default location)
3. The interview MUST include questions about **branding and visual identity**:
   - Brand colors (primary, secondary, accent)
   - Typography / fonts
   - Logos and visual assets the user can provide
   - Existing design systems or brand guidelines
   - Visual tone (modern, playful, corporate, minimal, etc.)
4. Capture branding answers in a dedicated **"Branding & Visual Identity"** section of the PRD

**Exit gate**: `.specs/PRD.md` exists with all completeness checklist items checked (including branding section if project has any UI)

---

## Phase 2 — Specification (No Code)

**Triggers**: PRD.md exists, user says "create spec", "break into stages", or runs `/spec`

**Process**:
1. Run `/spec` skill with **Approach B** (Living Spec + Feature Specs)
2. Creates `.specs/00-{{PROJECT_NAME}}.living.md` and stage folders
3. **Branding**: Ask user about branding requirements if not already captured. Create `.specs/branding.md` with:
   - Color palette (hex values, usage guidelines)
   - Typography (font families, sizes, weights)
   - Logo assets and usage rules
   - Design language and component style guidelines
   - Reference from any UI-related stage's `design.md`
4. Break work into stages. Each stage groups related features by domain/dependency.
5. For each stage, create `.specs/stages/stage-N-<name>/` containing:
   - `requirements.md` — EARS-format requirements for all features in this stage
   - `design.md` — Architecture decisions, data flows, component design
   - `tasks.md` — Implementation tasks with dependencies and status tracking
   - `dependencies.md` — List of prerequisite stages that must complete first
6. Update `.specs/project.living.md` with stage overview table

**Important**: Stage folders contain ONLY planning documents (`.md` files). No `src/` or `tests/` inside stages.

**Exit gate**: All stages created, dependencies mapped, `project.living.md` populated with stage overview

---

## Phase 3 — Execution (Code Allowed)

**Triggers**: User says "build stage N", "execute stage N", or "execute stages"

**Pre-flight**:
1. Read `.specs/stages/stage-N-<name>/dependencies.md`
2. Verify all dependency stages have status "complete" in their `tasks.md`
3. If dependencies not met → block and report which stages are incomplete

**Agent Selection Matrix**:

| Scenario | Skill/Approach |
|----------|---------------|
| 1 stage, sequential tasks | `/executing-plans` skill |
| 1 stage, independent internal tasks | `/subagent-driven-development` skill |
| 2+ independent stages ready | `/dispatching-parallel-agents` with worktree isolation |
| Stage with TDD requirement | `/test-driven-development` skill first |

**Model Guidance**:

| Role | Model | Reason |
|------|-------|--------|
| Orchestrator | opus | Complex coordination decisions |
| Coder agents | sonnet | Balanced quality/speed for implementation |
| Review agents | sonnet | Needs reasoning quality |
| Tracking updates | haiku | Simple status writes |

**Code Location**:
- All source code → `src/` at project root
- All tests → `tests/` at project root
- Each stage's `tasks.md` references which files in `src/` and `tests/` belong to that stage

**After each stage completes** → automatically triggers Phase 4 review

---

## Phase 3a — UI Mock Design (Before Any UI Code)

**Triggers**: A stage contains UI-related features (detected from `design.md` or `tasks.md`)

**This MUST happen before any UI implementation code is written.**

**Process**:
1. Use `/playground` skill to create interactive HTML mocks in `mocks/stage-N-<name>/`
2. Generate **minimum 5 mock variations** with different visual styles/layouts
3. All mocks MUST reference `.specs/branding.md` for brand guidelines
4. Each mock is a self-contained `.html` file (`mock-1.html` through `mock-5.html`)
5. Present all 5+ mocks to user for review and selection
6. User selects preferred mock → record selection in `.specs/stages/stage-N-<name>/design.md` under **"UI Design Decision"**:
   ```markdown
   ## UI Design Decision
   **Selected Mock**: mock-X.html
   **Date**: YYYY-MM-DD
   **Rationale**: [user's reasoning]
   **Key Design Elements to Preserve**: [list]
   ```
7. Only AFTER selection is confirmed can UI implementation proceed
8. All UI implementation must also be validated against `/frontend-design` skill

**Parallel work**: If a stage has both UI and non-UI features, non-UI tasks CAN proceed while mocks are reviewed — but NO UI code until mock selection is made.

**Exit gate**: User has reviewed mocks, made selection, and selection is documented in `design.md`

---

## Phase 4 — Review (Mandatory, Full Scope)

**Triggers**: Automatically after any stage's code is written

**Process** — Launch 3 parallel review agents (`feature-dev:code-reviewer`):

1. **Code Quality Agent**: Readability, patterns, DRY, SOLID, naming conventions
2. **Security Agent**: OWASP Top 10, secrets scan, input validation, auth checks, injection vectors, XSS, insecure deps
3. **Test Coverage Agent**: Unit test coverage, integration tests, edge cases, missing scenarios

All 3 agents run in parallel and write findings to `.specs/stages/stage-N-<name>/REVIEW.md`

**Remediation**:
- If critical findings → block stage completion
- Spawn coding subagent to fix critical issues
- Re-run failed review(s)
- **Max 3 review cycles** before escalating to user

**Exit gate**: `REVIEW.md` exists with status **PASS** from all 3 review areas

---

## Phase 5 — Tracking (Continuous)

After every significant action:
1. Update `.specs/stages/stage-N-<name>/tasks.md` with task completion status
2. Update `.specs/project.living.md` with overall progress (stage statuses, current phase, metrics)
3. Use `/spec`'s `spec-updater` agent for living spec updates

---

## Living Spec Integration

This project uses Living Specifications. At every session:
1. Read `.claude/spec-steering.md` for maintenance rules
2. Check `.specs/00-{{PROJECT_NAME}}.living.md` for current state
3. Calculate drift score if code changes detected
4. Offer spec updates after completing work

---

## Folder Structure

```
{{PROJECT_NAME}}/
├── CLAUDE.md                          # This file — master workflow orchestration
├── .claude/
│   ├── settings.local.json            # Hooks + permissions
│   ├── spec-steering.md               # Living spec maintenance rules
│   └── rules/
│       ├── no-code-in-planning.md     # Block code during phases 1-2
│       ├── stage-execution.md         # Dependency + agent selection rules
│       ├── review-pipeline.md         # Full review pipeline spec
│       └── ui-mock-gate.md            # Block UI code without approved mocks
├── .specs/
│   ├── PRD.md                         # Phase 1 output (from interview)
│   ├── branding.md                    # Branding requirements & visual identity
│   ├── 00-{{PROJECT_NAME}}.living.md  # Phase 2+ living document
│   ├── project.living.md             # → symlink or alias to 00-{{PROJECT_NAME}}.living.md
│   └── stages/                        # Planning docs ONLY (no code here)
│       └── stage-N-<name>/
│           ├── requirements.md        # EARS-format requirements
│           ├── design.md              # Architecture + UI design decisions
│           ├── tasks.md               # Task checklist with status
│           ├── dependencies.md        # Prerequisite stages
│           └── REVIEW.md             # Review findings (Phase 4)
├── mocks/                             # UI mocks (Phase 3a)
│   └── stage-N-<name>/
│       ├── mock-1.html
│       ├── mock-2.html
│       └── ...                        # Minimum 5 variations
├── src/                               # All implementation code (Phase 3)
└── tests/                             # All tests (Phase 3)
```
