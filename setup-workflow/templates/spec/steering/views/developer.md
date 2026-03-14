# Developer View

Load when user says:
- "as a developer", "developer view"
- "what should I work on", "my tasks", "next task"
- "where does X live", "what's my next task"

## Focus Sections

As a developer, you primarily care about:

| Section | What You Need |
|---------|---------------|
| §4 Implementation | Your tasks, stages, and their status |
| §7 Next Actions | What's prioritized right now |
| §4 Component Map | Where code lives |
| §3 Key Decisions | Why things are built this way |

## Quick Answers

| Question | Where to Look | How to Answer |
|----------|---------------|---------------|
| "What's my next task?" | §7 Current Focus | Show top priority item |
| "Where does X live?" | §4 Component Map | Search and show path |
| "Is this requirement valid?" | §2 Requirements + drift | Check status and drift |
| "What's the architecture?" | §3 System Overview | Show diagram/description |
| "Why did we decide X?" | §6 Decision Log | Find relevant entry |
| "What's blocked?" | §7 Blocked | List blockers |
| "What did I finish?" | §7 Recently Completed | Show recent items |

## Developer Dashboard

When showing developer view:

```
Developer View - [Project Name]

Current Phase: [🔵/🟢/🟡] [Phase Name]
Drift Score: [X]% [status]

YOUR NEXT TASK
[Task from §7 Current Focus]

Context:
- Related requirement: [PR-XXX]
- Related decision: [Decision X]
- Files likely affected: [from Component Map]

CURRENT STAGE: [Stage Name]
Status: [⬚/🔄/✅]
Goal: [Stage goal]

Tasks:
- [ ] [Task 1]
- [ ] [Task 2]
- [x] [Completed task]

RELEVANT CODE
| Component | Path |
|-----------|------|
| [Component] | `src/path` |
| [Component] | `src/path` |

BLOCKERS
[List from §7 Blocked, or "None"]

What would you like to do?
A) Start working on next task
B) See full stage details
C) Check a specific component
D) Review relevant decisions
```

## Red Flags for Developers

Alert on these conditions:

| Flag | Condition | Action |
|------|-----------|--------|
| ⬚ Unclear task | Task without acceptance criteria | Ask for clarification |
| 🔴 High drift | Drift score >50% | Sync spec first |
| 🔒 Blocked by arch | Task needs unapproved decision | Escalate for approval |
| ⚠️ Missing context | No related requirement found | Verify task is valid |

## Starting Work on a Task

When developer says "start task" or begins working:

1. **Mark stage as in-progress** (🔄) in spec
2. **Create TodoWrite entry** for the task
3. **Show relevant context:**
   ```
   Starting: [Task name]

   Context:
   - Requirement: [PR-XXX] - [brief description]
   - Decision: [Decision X] - [brief description]
   - Acceptance criteria:
     - [ ] [Criterion 1]
     - [ ] [Criterion 2]

   Files to modify:
   - `src/path/file.ts`

   Ready to begin? (yes/show more context)
   ```

## Completing Work

When developer finishes a task:

1. **Mark task complete** in TodoWrite
2. **Update spec:**
   - Stage status -> ✅ if all tasks done
   - Component Map if new files created
   - Decision Log if decisions made
3. **Calculate drift** and report
4. **Show next task**

```
✅ Task Complete: [Task name]

Updates made:
- §4 Stage X marked complete
- §4 Component Map updated (+2 files)
- §6 Decision Log entry added

Drift Score: [X]% [status]

Next task: [Next task from §7]
Start now? (yes/no)
```

## Code Location Queries

When developer asks "where is X":

```
Searching Component Map...

Results for "[search term]":

| Component | Path | Description |
|-----------|------|-------------|
| [Match 1] | `src/path` | [Description] |
| [Match 2] | `src/path` | [Description] |

Related decisions:
- [Decision X]: [Why it's built this way]

Not finding what you need?
- Check if file exists but isn't mapped
- Search codebase directly
```

## Architecture Context

When developer needs architectural context:

```
Architecture Context for [Area]

System Overview:
[Relevant portion of §3 diagram]

Key Decisions Affecting This Area:
1. [Decision]: [Choice] - [Rationale summary]
2. [Decision]: [Choice] - [Rationale summary]

Tech Stack:
| Layer | Technology |
|-------|------------|
| [Layer] | [Tech] |

Patterns to Follow:
- [Pattern from existing code]
- [Convention from decisions]
```
