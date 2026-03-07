# Architect View

Load when user says:
- "as architect", "architect view", "architecture view"
- "design decisions", "technical decisions", "system design"
- "architecture review", "design review"

## Focus Sections

As an architect, you primarily care about:

| Section | What You Need |
|---------|---------------|
| §3 Architecture | System design and decisions |
| §1 Project Context | Current state (brownfield) |
| §4 Component Map | System structure |
| §4 Tech Debt Register | Technical health |
| §6 Decision Log | Decision history |

## Quick Answers

| Question | Where to Look | How to Answer |
|----------|---------------|---------------|
| "What's the architecture?" | §3 System Overview | Show diagram and description |
| "Why did we choose X?" | §3 Key Decisions + §6 | Find decision and rationale |
| "What's our tech stack?" | §3 Technology Stack | List with rationale |
| "What tech debt do we have?" | §4 Tech Debt Register | List with severity |
| "What decisions need review?" | §3 Key Decisions | Show pending approvals |
| "How do components interact?" | §3 + §4 Component Map | Show relationships |

## Architect Dashboard

When showing architect view:

```
Architect View - [Project Name]

Phase: [🔵/🟢/🟡] [Phase Name]
Architecture Status: [✅ Approved / ⚠️ Pending Review / 🔄 Evolving]

SYSTEM OVERVIEW

[ASCII/Mermaid diagram from §3]

Key characteristics:
- Pattern: [Architecture pattern]
- Style: [Monolith/Microservices/Serverless/etc.]
- Primary language: [Language]
- Key frameworks: [Frameworks]

TECHNOLOGY STACK

| Layer | Technology | Status |
|-------|------------|--------|
| Frontend | [Tech] | [Stable/Evaluating/Deprecated] |
| Backend | [Tech] | [Status] |
| Database | [Tech] | [Status] |
| Infrastructure | [Tech] | [Status] |

KEY DECISIONS

Recent/Pending:
| Decision | Status | Impact |
|----------|--------|--------|
| [Decision 1] | ⬚ Pending | HIGH |
| [Decision 2] | ✅ Approved | MEDIUM |

Total decisions: [X] ([Y] pending approval)

TECHNICAL DEBT

| Severity | Count |
|----------|-------|
| 🔴 High | [X] |
| ⚠️ Medium | [Y] |
| Low | [Z] |

Top items:
1. [High severity debt item]
2. [Next priority item]

COMPONENT HEALTH

| Component | Files | Complexity | Debt |
|-----------|-------|------------|------|
| [Component] | [X] | [Low/Med/High] | [Items] |

What would you like to do?
A) Review pending decisions
B) Deep dive on tech debt
C) Explore component relationships
D) Add new architecture decision
E) Generate architecture documentation
```

## Decision Review

When architect reviews decisions:

```
ARCHITECTURE DECISION REVIEW

DECISION: [Title]
ID: D-[XXX]
Status: ⬚ Pending Approval

CONTEXT
[Why is this decision needed? What problem does it solve?]

OPTIONS CONSIDERED

Option A: [Name]
- Description: [What this option entails]
- Pros: [Pro 1], [Pro 2]
- Cons: [Con 1], [Con 2]
- Effort: [Low/Medium/High]
- Risk: [Low/Medium/High]

Option B: [Name]
- Description: [What this option entails]
- Pros: [Pro 1]
- Cons: [Con 1]
- Effort: [Level]
- Risk: [Level]

RECOMMENDATION
Choice: [Option X]
Rationale: [Why this is recommended]

IMPACT ANALYSIS

Affected components:
- [Component 1]: [How it's affected]
- [Component 2]: [How it's affected]

Requirements addressed:
- PR-001, PR-003

New tech debt introduced:
- [Potential debt item]

Your decision: (approve/reject/request changes/need more info)
```

## Adding New Decision

When architect wants to document a new decision:

```
NEW ARCHITECTURE DECISION

I'll help you document this decision. Please provide:

1. TITLE
   What is this decision about?
   > [User input]

2. CONTEXT
   Why is this decision needed? What problem does it solve?
   > [User input]

3. OPTIONS
   What alternatives were considered?

   Option A: [Name]
   - Description:
   - Pros:
   - Cons:

   Option B: [Name]
   - Description:
   - Pros:
   - Cons:

   [Add more options?]

4. DECISION
   Which option was chosen?
   > [User input]

5. RATIONALE
   Why was this option selected?
   > [User input]

6. CONSEQUENCES
   What are the implications of this decision?
   > [User input]

Decision recorded. Add to:
- §3 Key Decisions ✅
- §6 Decision Log ✅

Link to requirements? (PR-XXX, PR-YYY, or skip)
```

## Tech Debt Analysis

When architect reviews tech debt:

```
TECHNICAL DEBT ANALYSIS

DEBT SUMMARY

| Severity | Count | Trend |
|----------|-------|-------|
| 🔴 High | [X] | [up/down/flat] |
| ⚠️ Medium | [Y] | [up/down/flat] |
| Low | [Z] | [up/down/flat] |

Total: [X+Y+Z] items

HIGH SEVERITY ITEMS

TD-001: [Title]
- Description: [What the debt is]
- Location: [Component/files]
- Impact: [What problems it causes]
- Trigger: [When to address]
- Effort to fix: [Estimate]
- Created: [Date]

TD-002: [Title]
- Description: [What the debt is]
- ...

DEBT BY COMPONENT

| Component | High | Medium | Low |
|-----------|------|--------|-----|
| [Component] | [X] | [Y] | [Z] |

RECOMMENDATIONS

1. Address TD-001 before [milestone/phase]
2. Consider TD-003 during next refactor
3. TD-005 can be deferred to post-launch

Would you like to:
A) Update debt item status
B) Add new debt item
C) Create debt reduction plan
```

## Component Relationship View

When architect explores component relationships:

```
COMPONENT RELATIONSHIPS

[Component A]
    |
    +---> [Component B] (dependency)
    |         |
    |         +---> [Component C]
    |
    +---> [Component D] (shared)
              |
              +---> [External Service]

DEPENDENCY MATRIX

| Component | Depends On | Depended By |
|-----------|------------|-------------|
| A | - | B, D |
| B | A | C |
| C | B | - |
| D | A | External |

COUPLING ANALYSIS

| Relationship | Coupling | Notes |
|--------------|----------|-------|
| A -> B | Tight | Consider interface |
| B -> C | Loose | Good |
| D -> External | API | Has fallback |

POTENTIAL IMPROVEMENTS

1. [Suggestion based on analysis]
2. [Another suggestion]
```

## Red Flags for Architects

| Flag | Condition | Action |
|------|-----------|--------|
| 🔴 Unapproved decisions | Decisions pending >5 days | Review and approve |
| ⚠️ High tech debt | >5 high severity items | Plan debt reduction |
| 🔴 Missing decisions | Implementation without decision | Document retroactively |
| ⚠️ Circular deps | Components have circular dependencies | Refactor |
| 🔴 No rationale | Decision without documented rationale | Add rationale |
