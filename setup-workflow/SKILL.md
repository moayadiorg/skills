---
name: setup-workflow
description: Scaffold a new project with the Spec-Driven Development workflow (Interview → Spec → Execute → Review → Track). Creates CLAUDE.md, rules, spec skill, hooks, and directory structure. Use this whenever the user wants to start a new project, set up a development workflow, create project scaffolding, initialize a spec-driven project, or mentions wanting a structured development process for a new codebase.
argument-hint: [project-name]
user-invocable: true
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion
---

# /setup-workflow — Spec-Driven Project Scaffolding

Sets up a new project with the full 5-phase spec-driven development workflow.

## Flow

### Step 1: Get Project Name

If `$ARGUMENTS` contains a project name, use it. Otherwise ask:

```json
{
  "questions": [{
    "header": "Project Name",
    "question": "What is the project name? (alphanumeric and hyphens only)",
    "options": []
  }]
}
```

### Step 2: Configuration

Ask the user these configuration questions using AskUserQuestion:

```json
{
  "questions": [
    {
      "header": "UI Components",
      "question": "Does this project have a UI/frontend?",
      "options": [
        {"label": "Yes", "description": "Include UI mock gate rule and mocks/ directory"},
        {"label": "No", "description": "Backend-only project, skip UI-related scaffolding"}
      ],
      "multiSelect": false
    }
  ]
}
```

### Step 3: Run Scaffold Script

Run the scaffold script with the collected parameters:

```bash
bash "${CLAUDE_SKILL_DIR}/scripts/scaffold.sh" "<project-name>" [--with-ui|--no-ui]
```

The script runs in the **current working directory** and creates all project files there.

### Step 4: Verify

After the script completes, list the created files to confirm:

```bash
find . -name ".git" -prune -o -type f -print | grep -E '(CLAUDE\.md|\.claude/|\.specs/|mocks/|src/|tests/)' | sort
```

Verify no placeholders remain:

```bash
grep -rE '\{\{PROJECT_NAME\}\}|\{\{PROJECT_ROOT\}\}' CLAUDE.md .claude/ .specs/ 2>/dev/null || echo "All placeholders replaced successfully."
```

### Step 5: Summary

Tell the user:

```
Project "<project-name>" scaffolded with the Spec-Driven Development workflow.

Created:
- CLAUDE.md — Master workflow orchestration
- .claude/rules/ — Phase enforcement rules
- .claude/spec-steering.md — Living spec maintenance
- .claude/settings.local.json — Hooks and permissions
- .claude/skills/spec/ — Local /spec skill for specifications
- .specs/ — Specification documents directory
- src/ — Source code directory
- tests/ — Test directory
[- mocks/ — UI mock directory (if --with-ui)]

To begin Phase 1, say "new project" or run /discovery-interview.
```
