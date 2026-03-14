# Review Pipeline Rules

> Path scope: `src/**` and `tests/**`

## Trigger

After any code changes for a stage are complete, a full review MUST occur before the stage can be marked as complete.

## Review Agents (3 Parallel)

Launch all 3 review agents in parallel using `feature-dev:code-reviewer` subagent type:

### 1. Code Quality Agent
- **Focus**: Readability, patterns, DRY, SOLID, naming conventions
- **Prompt context**: "Review for code quality: readability, design patterns, DRY principle, SOLID principles, consistent naming conventions, and overall maintainability."

### 2. Security Agent
- **Focus**: OWASP Top 10, secrets scanning, input validation, auth checks, injection vectors, XSS, insecure dependencies
- **Prompt context**: "Review for security: OWASP Top 10 vulnerabilities, hardcoded secrets, input validation gaps, authentication/authorization issues, SQL/command injection, XSS vectors, and insecure dependency usage."

### 3. Test Coverage Agent
- **Focus**: Unit test coverage, integration test coverage, edge cases, missing test scenarios
- **Prompt context**: "Review for test coverage: unit test completeness, integration test coverage, edge case handling, missing test scenarios, error path testing, and boundary conditions."

## REVIEW.md Format

Write findings to `.specs/stages/stage-N-<name>/REVIEW.md`:

```markdown
# Stage N Review — <name>

## Review Date: YYYY-MM-DD

## Code Quality Review
**Status**: PASS | FAIL
### Critical
- [file:line] Description
### Warning
- [file:line] Description
### Info
- [file:line] Description

## Security Review
**Status**: PASS | FAIL
### Critical
- [file:line] Description
### Warning
- [file:line] Description
### Info
- [file:line] Description

## Test Coverage Review
**Status**: PASS | FAIL
### Critical
- [file:line] Description
### Warning
- [file:line] Description
### Info
- [file:line] Description

## Overall Status: PASS | FAIL
```

## Remediation Loop

1. If any review section has **Critical** findings → status is FAIL
2. Spawn coding subagent to fix critical issues
3. Re-run the failed review(s)
4. **Maximum 3 review cycles** — if still failing after 3 cycles, escalate to user with:
   ```
   ⚠️ Stage N review has failed 3 cycles. Critical findings remain:
   - [list remaining critical issues]
   Please review and provide guidance.
   ```

## Blocking Behavior

- Stage CANNOT be marked "complete" without REVIEW.md showing PASS for all 3 areas
- No subsequent dependent stages can begin until review passes
