# Living Spec Hooks Template

Use this template to set up automation hooks for Living Spec projects.

## Overview

Claude Code hooks enable automatic actions at specific workflow points. Configure hooks in `.claude/settings.local.json` or via the `/hooks` command.

This template provides hooks for:
- Automatic drift detection after file changes
- Spec update reminders after code modifications
- Pre-commit spec validation

## Setup Instructions

1. Add hooks to `.claude/settings.local.json` in your project
2. Or use the `/hooks add` command to add hooks interactively
3. Hooks execute shell commands that can output messages to the conversation

## Important Notes

Claude Code hooks support these event types:
- `PreToolCall` - Before a tool is executed
- `PostToolCall` - After a tool completes
- `Notification` - For async notifications
- `Stop` - Before session ends

Hooks run shell commands via the `"type": "command"` field. They can:
- Run shell commands
- Output text to the conversation
- Block tool execution (PreToolCall only, by returning non-zero exit code)

## Hooks Configuration

Add to `.claude/settings.local.json` in your project root:

```json
{
  "hooks": {
    "PostToolCall": [
      {
        "matcher": {
          "tool": "Write",
          "pathPattern": "src/**/*.{ts,tsx,js,jsx}"
        },
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f .specs/00-*.living.md ]; then echo 'DRIFT_CHECK: Source file modified. Consider running /spec drift'; fi"
          }
        ]
      },
      {
        "matcher": {
          "tool": "Edit",
          "pathPattern": "src/**/*.{ts,tsx,js,jsx}"
        },
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f .specs/00-*.living.md ]; then echo 'DRIFT_CHECK: Source file modified. Consider running /spec drift'; fi"
          }
        ]
      }
    ]
  }
}
```

### Alternative: Using /hooks Command

```bash
# Add drift detection hook interactively
/hooks add PostToolCall

# When prompted:
# - Matcher: tool=Write, pathPattern=src/**/*.{ts,tsx}
# - Command: echo 'DRIFT_CHECK: Consider /spec drift'
```

## Hook Descriptions

### PostToolCall: Drift Detection

**Trigger:** After any Write or Edit operation on source files
**Purpose:** Track changes to files in Component Map
**Action:** Returns drift indicator for potential spec update

```json
{
  "matcher": {
    "tool": "Write",
    "pathPattern": "src/**/*.{ts,tsx,js,jsx}"
  },
  "hooks": [
    {
      "type": "command",
      "command": "echo 'DRIFT_CHECK: Source file modified. Run /spec drift to check alignment.'"
    }
  ]
}
```

### Stop: Spec Update Reminder

**Trigger:** Before Claude Code stops/ends session
**Purpose:** Remind developer to sync spec if code changed
**Action:** Returns reminder if spec update needed

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": {},
        "hooks": [
          {
            "type": "command",
            "command": "if [ -f .specs/00-*.living.md ]; then SPEC=$(ls .specs/00-*.living.md 2>/dev/null | head -1); if [ -n \"$SPEC\" ]; then LAST=$(grep 'Last Updated' \"$SPEC\" | head -1); echo \"SPEC_REMINDER: Living Spec last updated: $LAST. Consider running /spec drift before ending.\"; fi; fi"
          }
        ]
      }
    ]
  }
}
```

### Notification: Context Loading at Session Start

**Trigger:** When Claude Code session begins
**Purpose:** Detect existing Living Spec for session continuity
**Action:** Returns spec path if exists

```json
{
  "hooks": {
    "Notification": [
      {
        "matcher": {},
        "hooks": [
          {
            "type": "command",
            "command": "if ls .specs/00-*.living.md 1>/dev/null 2>&1; then echo \"LIVING_SPEC_FOUND: $(ls .specs/00-*.living.md)\"; fi"
          }
        ]
      }
    ]
  }
}
```

## Advanced Hooks

### Pre-Commit Spec Validation

Use a PreToolCall hook to check drift before git commits:

```json
{
  "hooks": {
    "PreToolCall": [
      {
        "matcher": {
          "tool": "Bash"
        },
        "hooks": [
          {
            "type": "command",
            "command": "echo 'SPEC_CHECK: If committing, verify Living Spec drift is acceptable.'"
          }
        ]
      }
    ]
  }
}
```

### Test Requirement Enforcement

Remind about tests when session ends after code changes:

```json
{
  "hooks": {
    "Stop": [
      {
        "matcher": {},
        "hooks": [
          {
            "type": "command",
            "command": "if git diff --name-only HEAD 2>/dev/null | grep -q 'src/'; then echo 'TEST_REMINDER: Source files changed. Verify corresponding tests exist.'; fi"
          }
        ]
      }
    ]
  }
}
```

## Environment Variables

Available in command hooks:

| Variable | Description |
|----------|-------------|
| `$CLAUDE_PROJECT_DIR` | Project root directory |

## Best Practices

1. **Keep hooks fast** - Use simple shell commands with quick execution
2. **Use command hooks** - All hooks use `"type": "command"` with shell commands
3. **Output actionable messages** - Prefix with categories like `DRIFT_CHECK:`, `SPEC_REMINDER:`
4. **Test hooks thoroughly** - Validate commands work in your shell
5. **Don't block on non-critical checks** - Use PostToolCall for informational, PreToolCall only when blocking is needed

## Troubleshooting

### Hooks not loading
- Restart Claude Code session after changes
- Check JSON syntax with a validator
- Verify file path: `.claude/settings.local.json`

### Hook timing out
- Simplify command
- Check for infinite loops
- Avoid commands that require network access

### Hook returning wrong format
- Verify command output is plain text
- Test command separately in terminal
