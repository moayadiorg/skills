# Claude Code Skills

A collection of custom skills for [Claude Code](https://claude.com/claude-code).

## Available Skills

| Skill | Description |
|-------|-------------|
| [spec](./spec/) | Living Specifications — multi-agent orchestration for creating and maintaining structured project specifications |

## Installation

### Symlink (recommended)

Symlink individual skills into your Claude Code skills directory. This way you get updates by pulling the repo.

```bash
# Clone the repo
git clone https://github.com/moayadiorg/skills.git ~/skills

# Symlink a skill
ln -s ~/skills/spec ~/.claude/skills/spec
```

### Copy

Alternatively, copy the skill directory directly:

```bash
cp -r spec/ ~/.claude/skills/spec/
```

## Spec Skill

The `/spec` skill generates and maintains **Living Specifications** — structured, AI-maintainable spec files that consolidate requirements, architecture, API design, data models, security considerations, and test strategies into a single source of truth.

### Features

- Multi-agent orchestration with specialized agents (architecture, security, database, frontend, API, testing, risk)
- EARS syntax for unambiguous requirements
- Drift detection between spec and implementation
- Role-based views (developer, architect, manager, QA)
- Traceability from requirements through to test cases

### Usage

```
/spec                  # Create or update a specification
/spec status           # Check spec coverage and health
/spec drift            # Detect divergence between spec and code
/spec view <role>      # View spec from a specific role's perspective
```

### Structure

```
spec/
├── SKILL.md                    # Entry point and skill definition
├── steering/                   # Workflow orchestration and templates
│   ├── workflow.md             # Main workflow steps
│   ├── template.md             # Spec file template
│   ├── ears-reference.md       # EARS requirement syntax reference
│   ├── ears-template.md        # EARS requirement templates
│   ├── drift-detection.md      # Spec-to-code drift detection
│   ├── maintenance.md          # Spec maintenance guidelines
│   ├── traceability.md         # Requirements traceability
│   ├── approach-selection.md   # Approach selection guidance
│   ├── hooks-template.md       # Git hooks for spec maintenance
│   └── views/                  # Role-based spec views
│       ├── developer.md
│       ├── manager.md
│       ├── architect.md
│       └── qa.md
└── agents/                     # Specialist agents
    ├── INDEX.md                # Agent registry
    ├── requirements-analyst.md
    ├── architecture-reviewer.md
    ├── comprehension-gate.md
    ├── database-specialist.md
    ├── frontend-specialist.md
    ├── api-specialist.md
    ├── risk-assessor.md
    ├── security-specialist.md
    ├── spec-critic.md
    ├── spec-updater.md
    └── test-specialist.md
```

See [SKILL.md](./spec/SKILL.md) for full documentation.

## Adding New Skills

To add a new skill to this repo:

1. Create a directory with the skill name (e.g., `my-skill/`)
2. Add a `SKILL.md` as the entry point
3. Add the skill to the table in this README
4. Commit and push

## License

MIT
