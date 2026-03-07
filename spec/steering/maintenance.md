# Spec Steering Template

Create this file at `.claude/spec-steering.md` when setting up a project with Living Specs.

## Tiered Approval System

Not all spec changes require the same oversight level. Use this tiered system:

### Tier 1: Autonomous (No Gate Required)

The spec-updater agent MAY automatically update:
- `Last Updated` timestamp in header
- `Drift Score` in Current Status
- Task/stage status icons (⬚ -> 🔄 -> ✅)
- `Recently Completed` section
- `Last Completed` in Current Status

### Tier 2: Async Notification (Update + Notify User)

The spec-updater agent SHALL update AND notify about:
- Component Map additions (new files)
- Technical Debt Register (new items found)
- Next Actions priority changes
- Decision Log entries (non-transition)

### Tier 3: Synchronous Approval (Block Until Approved)

The system SHALL request approval before:
- New requirements (FR-xxx, NFR-xxx)
- Architecture decision changes (§3)
- Phase transitions (requires comprehension gate)
- Scope changes (In/Out of Scope)
- Removing items (mark superseded instead)
- Security-related modifications

---

**IMPORTANT:** After creating this file, add the following to the project's `CLAUDE.md`:

```markdown
## Living Spec Integration

This project uses Living Specifications. At every session:
1. Read `.claude/spec-steering.md` for maintenance rules
2. Check `.specs/00-[PROJECT].living.md` for current state
3. Calculate drift score if code changes detected
4. Offer spec updates after completing work
```

---

```markdown
# Living Spec Steering

> This file is auto-loaded via CLAUDE.md to guide AI assistants in maintaining the Living Spec.

## Source of Truth

The Living Spec at `.specs/00-[PROJECT_NAME].living.md` is the **single source of truth** for this project.

**Approach:** [A) Living Spec Only | B) Living Spec + Feature Specs]

## Session Start Protocol

WHEN starting a new session in this project:
1. THE system SHALL read the Living Spec at `.specs/00-[PROJECT_NAME].living.md`
2. THE system SHALL check Current Status section for next action
3. THE system SHALL calculate drift score if code changes detected
4. THE system SHALL present welcome back message with options

## When to Update the Living Spec

| Trigger | Sections to Update |
|---------|-------------------|
| Task/stage complete | §4 Execution Plan, §7 Next Actions |
| New feature spec created | §2 Related Feature Specs |
| Architecture decision | §3 Key Decisions, §6 Decision Log |
| Scope change | §1 Intent (Scope), §6 Decision Log |
| Phase complete | Current Status header, §6 Decision Log |
| Technical debt found | §4 Tech Debt Register |
| Metric measured | §5 Metrics |
| Priority change | §7 Next Actions |
| Blocker identified | Current Status, §7 Blocked |
| Blocker resolved | Current Status, §7 Next Actions |

## Update Format Rules

### Timestamps
- Always use ISO format: `YYYY-MM-DDTHH:MM:SS`
- Update `Last Updated` in header on every modification

### Status Icons
| Icon | Meaning |
|------|---------|
| ⬚ | Not started / Unanswered / Unlinked |
| 🔄 | In progress |
| ✅ | Complete |

### Phase Icons
| Icon | Phase |
|------|-------|
| 🔵 | Planning |
| 🟢 | Building |
| 🟡 | Operating |

### History Preservation
- **Never delete** entries from Decision Log
- Mark superseded decisions as `[SUPERSEDED by Decision X]`
- Keep completed items in "Recently Completed" for context

## After Completing Work

WHEN any code change is completed THE system SHALL ask:
```
Work completed. Should I update the Living Spec?

Updates needed:
- [ ] §4 Execution Plan: Mark [stage/task] complete
- [ ] §4 Component Map: Add/update [files]
- [ ] §6 Decision Log: Record [decision made]
- [ ] §7 Next Actions: Update priorities
- [ ] Current Status: Update Last Completed
```

## Drift Detection

WHEN any code changes occur to files in Component Map THE system SHALL:

1. Calculate drift score:
   ```
   drift_score = (files_changed_since_last_update / total_mapped_files) x 100
   ```

2. Take action based on score:
   | Score | Status | Action |
   |-------|--------|--------|
   | 0-20% | ✅ Healthy | Continue working |
   | 21-50% | ⚠️ Review | Suggest spec update |
   | 51%+ | 🔴 Sync Required | Prompt before continuing |

3. Update drift score in Current Status

## Phase Transitions

**Never auto-transition phases.** THE system SHALL always:

1. Verify all exit criteria met
2. Present summary to user
3. Ask for explicit approval
4. Log transition in Decision Log
5. Update phase in header

## Spec Hierarchy (Option B)

```
Living Spec (orchestrates at phase level)
+-- 00-[PROJECT_NAME].living.md (🔵 Planning)
    +-- feature-auth/ (🟢 Building)
    +-- feature-export/ (🔵 Planning)
    +-- feature-dashboard/ (🟡 Operating)
```

WHEN feature spec status changes THE system SHALL update the Living Spec hierarchy.

## Current Project State

**Project:** [PROJECT_NAME]
**Current Phase:** 🔵 Planning
**Current Focus:** [Initial focus]
**Last Session:** [Date or "New project"]

## Quick Commands

| User Says | Action |
|-----------|--------|
| "spec status" | Show Current Status + drift score |
| "spec drift" | Calculate and report drift |
| "spec update" | Offer to sync spec with current state |
| "what's next" | Show §7 Current Focus |
| "view as [role]" | Load role-specific view |

## Agent Orchestration

### When to Use Agents

| Situation | Agents to Spawn |
|-----------|-----------------|
| Entering Planning phase | requirements-analyst, architecture-reviewer, risk-assessor (parallel) |
| Entering Building phase | domain specialists based on scope (parallel) |
| After implementation | spec-critic, test-specialist |
| Phase transition | comprehension-gate (blocking) |
| After code changes | spec-updater |
| High drift detected | spec-updater |

### Comprehension Gate Triggers

SPAWN comprehension-gate WHEN:
- Phase transition requested (Planning -> Building -> Operating)
- Significant code merged without review
- Developer approves AI-generated code
- Spec-critic score < 70%

Gate BLOCKS until:
- All questions answered
- Responses demonstrate understanding (not copied)
- Responses logged in §6 Decision Log
```

---

## Customization Notes

Replace these placeholders when creating:
- `[PROJECT_NAME]` - Actual project name
- `[A) Living Spec Only | B) Living Spec + Feature Specs]` - Chosen approach
- `[Initial focus]` - First action after setup

Keep this file in sync with the Living Spec's Current Status section.
