---
name: spec
description: Living Specifications for Claude Code - consolidate development artifacts into AI-maintainable spec files with AI-DLC principles.
argument-hint: "[command] or [feature description]"
disable-model-invocation: false
user-invocable: true
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, Task, TaskCreate, TaskUpdate, TaskList, AskUserQuestion
---

# /spec - Living Specifications

Multi-agent orchestration for AI-maintainable specifications.

**Base directory for this skill:** The directory containing this SKILL.md file. All internal paths below are relative to this directory.

## Usage

```
/spec                    # Start new or continue existing
/spec <feature>          # Create spec for specific feature
/spec status             # View all specs and phases
/spec drift              # Check spec-code drift
/spec view <role>        # Role-based view (developer|manager|qa|architect)
```

## First-Time Activation

**MANDATORY:** Use AskUserQuestion on first trigger:

```json
{
  "questions": [{
    "header": "Approach",
    "question": "Which spec approach fits your project?",
    "options": [
      {"label": "A) Living Spec Only (Recommended)", "description": "MVPs, small teams, rapid iteration"},
      {"label": "B) Living Spec + Feature Specs", "description": "Multiple features, growing projects"},
      {"label": "C) Feature Specs Only", "description": "Clear feature boundaries, simple projects"}
    ],
    "multiSelect": false
  }]
}
```

Then ask Greenfield/Brownfield via AskUserQuestion.

## Core Files

**Always load:** `steering/workflow.md` (core logic)

| File | Load When |
|------|-----------|
| `steering/workflow.md` | Always |
| `steering/template.md` | Creating new spec |
| `steering/ears-reference.md` | Writing requirements |
| `steering/drift-detection.md` | `/spec drift` |
| `agents/INDEX.md` | Spawning agents |

## Multi-Agent Orchestration

See `agents/INDEX.md` for complete agent directory and spawning patterns.

**Planning Phase:** Spawn in parallel via Task tool:
- requirements-analyst, architecture-reviewer, risk-assessor

**Building Phase:** Spawn relevant specialists:
- database, api, frontend, security, test specialists

**Quality Gates:** spec-critic, comprehension-gate

## AI-DLC Phases

| Phase | Icon | Purpose |
|-------|------|---------|
| Planning | 🔵 | WHAT and WHY |
| Building | 🟢 | HOW |
| Operating | 🟡 | RUN and MEASURE |

## Tiered Approval

| Tier | Type | Examples |
|------|------|----------|
| 1 | Autonomous | Timestamps, status icons, drift |
| 2 | Notify | Component Map, tech debt, decisions |
| 3 | Blocking | Requirements, architecture, phase transitions |

## EARS Format

See `steering/ears-reference.md` for syntax. Key templates:

- **Ubiquitous:** THE system SHALL [response]
- **Event:** WHEN [trigger] THE system SHALL [response]
- **Unwanted:** IF [condition] THEN THE system SHALL [response]

## Directory Structure

```
project/
├── CLAUDE.md                   # Project instructions + spec context (auto-loaded)
├── .claude/
│   └── spec-steering.md        # Maintenance rules (auto-loaded via CLAUDE.md)
└── .specs/
    ├── 00-project.living.md    # Main spec
    └── feature-*/              # Feature specs (Option B)
        ├── requirements.md
        ├── design.md
        └── tasks.md
```

## Quick Reference

**Greenfield:** Questionnaire -> Architecture approval -> Building
**Brownfield:** Parallel analysis -> Auto-populate -> Verify -> Building

**Phase Transitions:** Always require comprehension gate verification

## Behavior Rules

1. Never skip approach selection on first activation
2. Always load workflow.md for core logic
3. Greenfield: Block on questionnaire until complete
4. Brownfield: Auto-populate, non-blocking verification
5. Approval gates mandatory at phase transitions
6. Comprehension gates verify understanding
7. Use parallel agents for analysis
8. Use EARS format for requirements
9. Sub-agents must return text output only - do NOT let them write files. The main orchestrator writes all spec files to `.specs/`

## CLAUDE.md Spec Section Template

When setting up specs, add this to the project's CLAUDE.md:

```markdown
## Living Spec Integration

This project uses Living Specifications. At every session:
1. Read `.claude/spec-steering.md` for maintenance rules
2. Check `.specs/00-[PROJECT].living.md` for current state
3. Calculate drift score if code changes detected
4. Offer spec updates after completing work

## Specification
- **Main Spec:** `.specs/00-project.living.md`
- **Approach:** [A/B/C]
- **Phase:** [🔵 Planning | 🟢 Building | 🟡 Operating]

## Key Paths
[List important file paths]

## Development Guidelines
1. Before coding: Check spec for requirements
2. New features: Create feature spec in `.specs/feature-<name>/`
3. After changes: Update spec if architecture changes

## Tiered Approval
| Change Type | Approval |
|-------------|----------|
| Bug fixes, typos | Autonomous |
| New components, endpoints | Notify (update spec) |
| Architecture changes | Blocking (discuss first) |
```

## Status Icons

| Icon | Meaning |
|------|---------|
| ⬚ | Not started |
| 🔄 | In progress |
| ✅ | Complete |
