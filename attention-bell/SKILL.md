---
name: attention-bell
description: Install terminal bell hooks that play a sound when Claude needs your attention — on stop (waiting for input) and on permission prompts. Use this whenever the user wants audio notifications, sound alerts, bell notifications, wants to know when Claude is done, or mentions not noticing when Claude finishes responding.
argument-hint: [--global|--project]
user-invocable: true
allowed-tools: Read, Write, Edit, Bash, AskUserQuestion
---

# /attention-bell — Terminal Bell Notification Hooks

Installs Claude Code hooks that ring the terminal bell (`\a`) when Claude needs your attention. Works over SSH and in any terminal that supports the bell character (iTerm2, VS Code with `terminal.integrated.enableBell` enabled, kitty, WezTerm, etc.).

## What it installs

Two hooks:

- **Stop** — Rings when Claude finishes responding and is waiting for input
- **Notification (permission_prompt)** — Rings when a tool needs your approval

## How the bell reaches your terminal

Claude Code subprocesses don't have a controlling TTY, so `echo '\a'` alone won't work. The hook finds the `claude` process's TTY and writes the bell character directly to it:

```bash
TTY=$(ps -eo tty,comm | grep claude | grep -v grep | awk '{print $1}' | head -1) && [ -n "$TTY" ] && printf '\a' > /dev/$TTY
```

## Flow

### Step 1: Determine scope

If `$ARGUMENTS` contains `--global` or `--project`, use that. Otherwise ask:

```json
{
  "questions": [{
    "header": "Scope",
    "question": "Where should the bell hooks be installed?",
    "options": [
      {"label": "Global (recommended)", "description": "~/.claude/settings.local.json — works in all projects"},
      {"label": "This project only", "description": ".claude/settings.local.json — only this project"}
    ],
    "multiSelect": false
  }]
}
```

### Step 2: Install hooks

Run the install script:

```bash
bash "${CLAUDE_SKILL_DIR}/scripts/install-hooks.sh" [--global|--project]
```

### Step 3: Verify and inform

Tell the user:

```
Terminal bell hooks installed.

You'll hear a bell when:
  - Claude finishes responding (Stop)
  - A tool needs your approval (permission prompt)

Requirements:
  - Your terminal must support the bell character
  - VS Code: set "terminal.integrated.enableBell": true in settings
  - macOS: check System Settings > Sound > Alert volume is turned up

The hooks take effect on the next Claude Code session.
```
