# Stage Execution Rules

> Path scope: `.specs/stages/**`

## Dependency Verification

Before executing any stage:

1. Read `.specs/stages/stage-N-<name>/dependencies.md`
2. For each listed dependency stage:
   - Read that stage's `tasks.md`
   - Verify ALL tasks are marked ✅ complete
   - Verify stage status is "complete"
3. If any dependency is incomplete → BLOCK execution with:
   ```
   ⛔ Cannot execute stage N. Blocked by incomplete dependencies:
   - Stage X (<name>): Y/Z tasks complete
   ```

## Agent Selection Matrix

When executing a stage, select the approach based on task structure:

| Scenario | Skill/Approach |
|----------|---------------|
| 1 stage, sequential tasks | `executing-plans` skill |
| 1 stage, independent internal tasks | `subagent-driven-development` skill |
| 2+ independent stages ready | `dispatching-parallel-agents` with worktree isolation |
| Stage with TDD requirement | `test-driven-development` skill first |

## Model Guidance

| Role | Recommended Model | Reason |
|------|-------------------|--------|
| Orchestrator | opus | Complex coordination decisions |
| Coder agents | sonnet | Balanced quality/speed |
| Review agents | sonnet | Needs reasoning quality |
| Tracking updates | haiku | Simple status writes |

## Code Location Enforcement

- All source code → `{{PROJECT_ROOT}}/src/`
- All tests → `{{PROJECT_ROOT}}/tests/`
- **NEVER** place code files inside `.specs/stages/` directories
- Each stage's `tasks.md` MUST reference which files in `src/` and `tests/` belong to that stage

## Stage Completion Requirements

A stage is "complete" when ALL of the following are true:
- [ ] All tasks in `tasks.md` are marked ✅
- [ ] All tests for the stage pass
- [ ] `REVIEW.md` exists with PASS status from all 3 review areas
- [ ] `tasks.md` status is updated to "complete"
- [ ] `project.living.md` is updated with stage completion
