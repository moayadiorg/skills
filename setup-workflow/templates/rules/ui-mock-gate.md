# UI Mock Requirement Gate

> Path scope: `src/**` for UI-related files (`.tsx`, `.jsx`, `.vue`, `.svelte`, `.html`, `.css`, `.scss`, `.sass`, `.less`)

## Rule

Before writing any UI component code, verify:

1. **Mocks exist**: Check `mocks/stage-N-<name>/` for mock files
2. **Selection documented**: Check `.specs/stages/stage-N-<name>/design.md` for a "UI Design Decision" section with an approved selection

If either condition fails → **BLOCK** with:
```
⛔ UI mocks must be created and approved before UI code can be written.

To proceed:
1. Use /playground skill to generate 5+ mock variations in mocks/stage-N-<name>/
2. Reference .specs/branding.md for brand guidelines
3. Present all mocks to user for review
4. Record selection in .specs/stages/stage-N-<name>/design.md under "UI Design Decision"
```

## Mock Generation Process

1. Use `/playground` skill to create interactive HTML mocks in `mocks/stage-N-<name>/`
2. Generate **minimum 5 mock variations** with different visual styles/layouts
3. All mocks MUST reference `.specs/branding.md` for brand colors, fonts, and guidelines
4. Each mock should be a self-contained `.html` file (`mock-1.html` through `mock-5.html` minimum)
5. Present all mocks to the user for review and selection

## After Selection

1. Record the user's choice in `.specs/stages/stage-N-<name>/design.md` under:
   ```markdown
   ## UI Design Decision
   **Selected Mock**: mock-X.html
   **Date**: YYYY-MM-DD
   **Rationale**: [user's reasoning]
   **Key Design Elements to Preserve**: [list from selected mock]
   ```
2. All UI implementation must validate against `/frontend-design` skill for design quality
3. Implementation must stay consistent with the selected mock's visual language

## Parallel Work

If a stage has both UI and non-UI features:
- Non-UI tasks CAN proceed while mocks are being reviewed
- NO UI code until mock selection is confirmed and documented
