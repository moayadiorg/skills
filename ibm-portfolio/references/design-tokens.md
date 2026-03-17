# IBM Design Language Token Reference

Complete design token specification for the portfolio project. Authoritative source: `portfolio/css/style.css` `:root` block.

## Color Tokens

All colors must be referenced as `var(--ibm-*)` CSS custom properties. Never use raw hex values outside `:root`.

| Token | Hex | Usage | Contrast Notes |
|-------|-----|-------|----------------|
| `--ibm-blue-60` | `#0f62fe` | Primary actions, links, accents, section labels, badges | 4.62:1 on white (AA large), use on light bg only |
| `--ibm-blue-70` | `#0043ce` | Hover/active state for blue-60 elements | 7.08:1 on white (AAA) |
| `--ibm-gray-100` | `#161616` | Dark section backgrounds, body text on light bg | 16.75:1 on white |
| `--ibm-gray-90` | `#262626` | Terminal bar, code block backgrounds | 14.18:1 on white |
| `--ibm-gray-80` | `#393939` | Inline code background on dark sections | 10.24:1 on white |
| `--ibm-gray-70` | `#525252` | Muted/secondary text, icons, card descriptions | 7.08:1 on white (AAA) |
| `--ibm-gray-30` | `#c6c6c6` | Body text on dark backgrounds, flow arrows | 8.57:1 on gray-100 |
| `--ibm-gray-20` | `#e0e0e0` | Borders, card dividers, TOC link borders | Light border only |
| `--ibm-gray-10` | `#f4f4f4` | Light section background, inline code background | 1.10:1 on white (bg only) |
| `--ibm-red-60` | `#da1e28` | Danger callouts, warning icons, error states | 4.64:1 on white (AA large) |
| `--ibm-yellow-30` | `#f1c21b` | Caution icons | 1.55:1 on white (icon only, not text) |
| `--ibm-green-50` | `#24a148` | Success checks, positive indicators, badges | 3.52:1 on white (icon only) |
| `--ibm-white` | `#ffffff` | Page background, text on dark backgrounds | — |

### Color Pairing Rules

- **Dark sections** (`section--dark`): Background `gray-100`, text `white`, muted text `gray-30`, inline code bg `gray-80`
- **Light sections** (`section--light`): Background `gray-10`, text `gray-100`, muted text `gray-70`, inline code bg `gray-10`
- **White sections** (default): Background `white`, text `gray-100`, muted text `gray-70`, inline code bg `gray-10`
- **Links** always use `blue-60`, hover `blue-70`
- **Section labels** always use `blue-60` regardless of section variant
- **Callout borders** use `red-60` with `rgba(218, 30, 40, 0.05)` background (light) or `rgba(218, 30, 40, 0.15)` (dark)

## Spacing Scale

Based on IBM's 8px mini-unit grid. All spacing must use `var(--space-*)` tokens.

| Token | rem | px | Common Use |
|-------|-----|----|------------|
| `--space-1` | 0.25rem | 4px | Tight inner padding, list item vertical padding |
| `--space-2` | 0.5rem | 8px | Tag gaps, small margins, terminal dot gaps, badge padding |
| `--space-3` | 0.75rem | 12px | Label margin-bottom, card inner spacing, table cell padding |
| `--space-4` | 1rem | 16px | Standard gap, button group gaps, TOC gaps, paragraph spacing |
| `--space-5` | 1.5rem | 24px | Section title margin-bottom, card padding, container side padding, callout padding |
| `--space-6` | 2rem | 32px | Grid gap, hero button group margin-top, project card padding, footer padding |
| `--space-7` | 2.5rem | 40px | Large element spacing |
| `--space-8` | 3rem | 48px | Section padding (compact) |
| `--space-9` | 4rem | 64px | Standard section vertical padding |
| `--space-10` | 5rem | 80px | Large section vertical padding |

### Spacing Usage Rules

- **Section padding:** Always `var(--space-9) 0` (standard) or override with `--space-10` for hero
- **Grid gaps:** Always `var(--space-6)` (2rem)
- **Container side padding:** Always `var(--space-5)` (1.5rem)
- **Button padding:** `var(--space-3) var(--space-5)` (0.75rem 1.5rem)
- **Never use** raw `rem`, `px`, or `em` values for margin, padding, or gap

## Type Scale

| Element | Size | Weight | Line Height | Letter Spacing | Notes |
|---------|------|--------|-------------|----------------|-------|
| h1 | 2.625rem (42px) | 300 (Light) | 1.2 | 0 | IBM Expressive heading |
| h2 | 2rem (32px) | 300 (Light) | 1.25 | 0 | Section titles |
| h3 | 1.25rem (20px) | 600 (Semi-Bold) | 1.4 | — | Card titles, subsections |
| h4 | 0.875rem (14px) | 600 (Semi-Bold) | 1.4 | 0.16px | Uppercase labels |
| body | 1rem (16px) | 400 (Regular) | 1.5 | — | Default paragraph |
| small/muted | 0.875rem (14px) | 400 (Regular) | 1.6 | — | Card descriptions, table text |
| label | 0.75rem (12px) | 400 (Regular) | — | 0.32px | Uppercase, section labels |
| code | 0.875em | 400 (Regular) | — | — | IBM Plex Mono |

### Font Families

| Token | Value | Use |
|-------|-------|-----|
| `--font-body` | `'IBM Plex Sans', sans-serif` | All body text, headings |
| `--font-mono` | `'IBM Plex Mono', monospace` | Code, terminal blocks |

### Google Fonts Import

Every page must include this in `<head>`:
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;600&family=IBM+Plex+Mono:wght@400&display=swap" rel="stylesheet">
```

## Grid System

### Container
- Max-width: `82rem` (1312px)
- Side padding: `var(--space-5)` (1.5rem)
- Centered with `margin: 0 auto`

### Grid Classes
| Class | Mobile | Tablet (42rem+) | Desktop (66rem+) |
|-------|--------|-----------------|-------------------|
| `.grid-2` | 1 column | 2 columns | 2 columns |
| `.grid-3` | 1 column | 2 columns | 3 columns |

### Breakpoints
| Name | Value | IBM Equivalent |
|------|-------|----------------|
| Tablet | `42rem` (672px) | sm/md boundary |
| Desktop | `66rem` (1056px) | md/lg boundary |

No other breakpoints should be used.

## Animation & Motion

IBM productive motion standard:

| Property | Value | Use |
|----------|-------|-----|
| Standard transition | `0.15s ease` | All hover/focus transitions |
| Entrance | `cubic-bezier(0, 0, 0.38, 0.9)` | Elements entering view |
| Exit | `cubic-bezier(0.2, 0, 1, 0.9)` | Elements leaving view |
| Standard | `cubic-bezier(0.2, 0, 0.38, 0.9)` | State changes |

### Usage Rules
- Card hover: `transition: box-shadow 0.15s ease`
- Button hover: `transition: background 0.15s ease`
- Link hover: `transition: background 0.15s ease, border-color 0.15s ease`
- Arrow reveal: `transition: opacity 0.15s ease`
