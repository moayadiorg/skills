# EARS Feature Spec Template

Use this template to create feature specs in Option B (Living Spec + Feature Specs).

Feature specs are split into three files using EARS (Easy Approach to Requirements Syntax) format.

## Directory Structure

```
.specs/feature-[name]/
├── requirements.md     # EARS format requirements
├── design.md           # Architecture & technical decisions
└── tasks.md            # Implementation tasks & tracking
```

---

> See `steering/ears-reference.md` for EARS syntax reference and examples.

---

## File 1: requirements.md

```markdown
# Feature: [Feature Name]

> **Parent Spec**: `00-[project].living.md`
> **Phase**: 🔵 Planning | 🟢 Building | 🟡 Operating
> **Last Updated**: [YYYY-MM-DDTHH:MM:SS]

## Overview

[2-3 sentence description of the feature]

## Problem Statement

**Who:** [Who needs this feature?]
**What:** [What problem does it solve?]
**Why:** [Why is it important?]

---

## Functional Requirements

### Core Behavior (Ubiquitous)

| ID | Requirement | Priority | Status |
|----|-------------|----------|--------|
| FR-001 | THE system SHALL [behavior] | HIGH | ⬚ |
| FR-002 | THE system SHALL [behavior] | HIGH | ⬚ |
| FR-003 | THE system SHALL [behavior] | MEDIUM | ⬚ |

### Event-Driven Requirements

| ID | Trigger | Response | Priority | Status |
|----|---------|----------|----------|--------|
| FR-010 | WHEN [event] | THE system SHALL [response] | HIGH | ⬚ |
| FR-011 | WHEN [event] | THE system SHALL [response] | MEDIUM | ⬚ |

### State-Driven Requirements

| ID | State | Behavior | Priority | Status |
|----|-------|----------|----------|--------|
| FR-020 | WHILE [state] | THE system SHALL [behavior] | MEDIUM | ⬚ |

---

## Non-Functional Requirements

### Error Handling (Unwanted Behavior)

| ID | Condition | Response | Priority | Status |
|----|-----------|----------|----------|--------|
| NFR-001 | IF [error condition] | THEN THE system SHALL [response] | HIGH | ⬚ |
| NFR-002 | IF [error condition] | THEN THE system SHALL [response] | MEDIUM | ⬚ |

### Performance

| ID | Requirement | Target | Status |
|----|-------------|--------|--------|
| NFR-010 | THE system SHALL respond within | [X]ms p50 | ⬚ |
| NFR-011 | THE system SHALL handle | [Y] requests/sec | ⬚ |

### Optional Features

| ID | Feature Flag | Behavior | Status |
|----|--------------|----------|--------|
| NFR-020 | WHERE [feature] is enabled | THE system SHALL [behavior] | ⬚ |

---

## Acceptance Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Dependencies

| Dependency | Type | Status |
|------------|------|--------|
| [Other feature/service] | Required | ⬚ |

## Out of Scope

- [Explicitly excluded item 1]
- [Explicitly excluded item 2]
```

---

## File 2: design.md

```markdown
# Design: [Feature Name]

> **Parent Spec**: `00-[project].living.md`
> **Requirements**: `requirements.md`
> **Last Updated**: [YYYY-MM-DDTHH:MM:SS]

## Architecture Overview

[ASCII diagram or description of the feature's architecture]

```
[Component A] --> [Component B] --> [Component C]
```

## Key Decisions

### Decision 1: [Title]

| Aspect | Details |
|--------|---------|
| **Timestamp** | [YYYY-MM-DDTHH:MM:SS] |
| **Context** | [Why is this decision needed?] |
| **Options** | 1) [Option A] 2) [Option B] 3) [Option C] |
| **Choice** | [Selected option] |
| **Rationale** | [Why this choice?] |
| **Trade-offs** | [What we're giving up] |
| **Approval** | ⬚ Pending / ✅ Approved |

---

### Decision 2: [Title]

| Aspect | Details |
|--------|---------|
| **Timestamp** | [YYYY-MM-DDTHH:MM:SS] |
| **Context** | [Why needed?] |
| **Options** | 1) [A] 2) [B] |
| **Choice** | [Selected] |
| **Rationale** | [Why] |
| **Trade-offs** | [Cons] |
| **Approval** | ⬚ Pending |

---

## Data Model

### Entities

| Entity | Attributes | Notes |
|--------|------------|-------|
| [Entity Name] | id, field1, field2 | [Notes] |

### Schema

```
[Schema definition - SQL, DynamoDB, etc.]
```

## API Design

### Endpoints

| Method | Path | Description | Request | Response |
|--------|------|-------------|---------|----------|
| GET | /api/[resource] | [Description] | - | [Response] |
| POST | /api/[resource] | [Description] | [Body] | [Response] |

## Integration Points

| System | Interface | Protocol | Notes |
|--------|-----------|----------|-------|
| [System] | [Interface] | [HTTP/gRPC/etc] | [Notes] |

## Security Considerations

- [ ] [Security requirement 1]
- [ ] [Security requirement 2]
```

---

## File 3: tasks.md

```markdown
# Tasks: [Feature Name]

> **Parent Spec**: `00-[project].living.md`
> **Requirements**: `requirements.md`
> **Design**: `design.md`
> **Last Updated**: [YYYY-MM-DDTHH:MM:SS]

## Progress

| Total | Not Started | In Progress | Complete |
|-------|-------------|-------------|----------|
| [X] | [Y] | [Z] | [W] |

---

## Implementation Tasks

### Phase 1: [Phase Name]

| ID | Task | Req ID | Dependencies | Status |
|----|------|--------|--------------|--------|
| T-001 | [Task description] | FR-001 | - | ⬚ |
| T-002 | [Task description] | FR-002 | T-001 | ⬚ |
| T-003 | [Task description] | FR-003 | T-001 | ⬚ |

### Phase 2: [Phase Name]

| ID | Task | Req ID | Dependencies | Status |
|----|------|--------|--------------|--------|
| T-010 | [Task description] | FR-010 | T-003 | ⬚ |
| T-011 | [Task description] | FR-011 | T-010 | ⬚ |

---

## Files to Create/Modify

| Action | File | Purpose | Task ID |
|--------|------|---------|---------|
| CREATE | `src/path/file.ts` | [Purpose] | T-001 |
| MODIFY | `src/path/existing.ts` | [Purpose] | T-002 |
| DELETE | `src/path/old.ts` | [Purpose] | T-008 |

---

## Test Cases

| ID | Test | Type | Req ID | Status |
|----|------|------|--------|--------|
| TC-001 | [Test description] | Unit | FR-001 | ⬚ |
| TC-002 | [Test description] | Integration | FR-002 | ⬚ |
| TC-003 | [Test description] | E2E | FR-010 | ⬚ |

---

## Blockers

| Task ID | Blocker | Owner | Since | Status |
|---------|---------|-------|-------|--------|
| T-005 | [What's blocking] | @owner | [Date] | Open |

---

## Recently Completed

| Task ID | Completed | Notes |
|---------|-----------|-------|
| T-001 | [Date] | [Notes] |

---

## Change Log

| Date | Author | Change |
|------|--------|--------|
| [Date] | @author | Initial creation |
```

---

## Usage Notes

1. **Create all three files** when starting a new feature
2. **Link in Living Spec** under "Related Feature Specs"
3. **Update requirements.md** as understanding evolves
4. **Update design.md** when architectural decisions are made
5. **Track progress in tasks.md** - keep statuses current
6. **Use EARS format** for all requirements (no exceptions)
7. **Cross-reference** between files using IDs (FR-001, T-001, TC-001)
