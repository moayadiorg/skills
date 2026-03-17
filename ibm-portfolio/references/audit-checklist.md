# Audit Checklist

Structured compliance rules for portfolio pages and Reveal.js slides. Each rule has a unique ID, category, severity, and fix guidance.

## Severity Levels

- **FAIL** — Must fix. Violates core design system.
- **WARN** — Should fix. Degrades consistency but not broken.
- **INFO** — Consider fixing. Minor improvement.

## Landing Page Rules

### Color (CLR)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| CLR-01 | FAIL | No raw hex values outside `:root` | Search for `#[0-9a-fA-F]{3,8}` in HTML `style` attrs and CSS rules (excluding `:root` block and `rgba()`) | Replace with `var(--ibm-*)` token |
| CLR-02 | FAIL | No raw `rgb()`/`hsl()` color values outside `:root` | Search for `rgb\(` or `hsl\(` in properties that accept color (excluding `rgba()` for overlays) | Replace with token or approved `rgba()` overlay |
| CLR-03 | WARN | All `rgba()` values should use approved patterns | Check `rgba()` calls match: `rgba(0, 0, 0, *)` for shadows, `rgba(15, 98, 254, 0.08)` for blue hover, `rgba(218, 30, 40, *)` for callout bg | Use approved rgba patterns |
| CLR-04 | FAIL | Links must use `var(--ibm-blue-60)` | Check all `<a>` color declarations | Set `color: var(--ibm-blue-60)` |
| CLR-05 | WARN | Section labels must be `var(--ibm-blue-60)` | Check `.section-label` color | Use `.section-label` class which sets this |

### Typography (TYP)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| TYP-01 | FAIL | Only IBM Plex Sans and IBM Plex Mono fonts | Search for `font-family` declarations — must be `var(--font-body)`, `var(--font-mono)`, or `'IBM Plex Sans'`/`'IBM Plex Mono'` | Replace with `var(--font-body)` or `var(--font-mono)` |
| TYP-02 | FAIL | Font weights restricted to 300, 400, 600 (Plex Sans) and 400 (Plex Mono) | Search for `font-weight` values outside {300, 400, 600} | Use allowed weight |
| TYP-03 | FAIL | Google Fonts link must include IBM Plex Sans (300;400;600) + Plex Mono (400) | Check `<head>` for correct Google Fonts `<link>` | Add/fix Google Fonts link |
| TYP-04 | WARN | Headings should follow type scale (h1: 2.625rem, h2: 2rem, h3: 1.25rem, h4: 0.875rem) | Check for `font-size` overrides on heading elements | Remove overrides, let CSS handle |
| TYP-05 | INFO | Prefer `var(--font-body)` and `var(--font-mono)` tokens over raw font names | Search for raw `'IBM Plex Sans'` or `'IBM Plex Mono'` in inline styles | Use token variable |

### Spacing (SPC)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| SPC-01 | FAIL | Padding, margin, and gap must use `var(--space-*)` tokens | Search for raw `rem`, `px`, `em` values in padding/margin/gap properties (excluding reset `0`, line-height, font-size, border-width, border-radius) | Replace with nearest `var(--space-*)` token |
| SPC-02 | WARN | Section padding should be `var(--space-9) 0` | Check `.section` padding declarations | Use standard section padding |
| SPC-03 | WARN | Container side padding should be `var(--space-5)` | Check `.container` padding | Use `var(--space-5)` |
| SPC-04 | INFO | Grid gap should be `var(--space-6)` | Check `.grid` gap declarations | Use `var(--space-6)` |

### Grid (GRD)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| GRD-01 | FAIL | Content must be wrapped in `.container` | Every `<section>` should contain a `<div class="container">` as direct child | Add `.container` wrapper |
| GRD-02 | WARN | Use `.grid-2` or `.grid-3` for multi-column layouts | Check for custom `grid-template-columns` in inline styles | Use `.grid` + `.grid-2`/`.grid-3` classes |
| GRD-03 | FAIL | Breakpoints must be 42rem and/or 66rem only | Check `@media` queries for non-standard breakpoints | Use 42rem or 66rem |
| GRD-04 | WARN | Max-width on `.container` should be 82rem | Check `.container` max-width | Set `max-width: 82rem` |

### Components (CMP)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| CMP-01 | WARN | Cards should use `.card` class | Check for card-like `<div>` with inline border/padding styles | Apply `.card` class |
| CMP-02 | WARN | Terminal blocks should use `.terminal` + `.terminal-bar` + `.terminal-dot` structure | Check terminal-like elements for correct class structure | Use standard terminal component |
| CMP-03 | WARN | Buttons should use `.btn` + `.btn--primary`/`.btn--ghost` | Check for button-like `<a>` with inline button styles | Use `.btn` classes |
| CMP-04 | WARN | Tables should be wrapped in `.table-wrap` | Check `<table>` elements for wrapper | Add `.table-wrap` wrapper |
| CMP-05 | INFO | Flow steps should use `.flow` + `.flow-step` + `.flow-number` + `.flow-arrow` | Check step-like layouts | Use standard flow component |

### Structure (STR)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| STR-01 | FAIL | Every section must have `section-label` + `section-title` pattern | Check each `<section>` for `.section-label` `<p>` and `.section-title` heading | Add label and title |
| STR-02 | FAIL | Page must have OG meta tags | Check `<head>` for `og:title`, `og:description`, `og:type` | Add OG meta tags |
| STR-03 | FAIL | Page must have `<meta name="viewport">` | Check `<head>` | Add viewport meta |
| STR-04 | WARN | Page should have `<meta name="description">` | Check `<head>` | Add description meta |
| STR-05 | WARN | Page should have a footer using `.footer` class | Check for `<footer class="footer">` | Add standard footer |
| STR-06 | INFO | HTML lang attribute should be set | Check `<html lang="en">` | Add lang attribute |

### Animation (ANI)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| ANI-01 | WARN | Transitions should use `0.15s ease` | Check `transition` values for non-standard durations or timing | Use `0.15s ease` |
| ANI-02 | INFO | No CSS animations/keyframes (keep it simple) | Search for `@keyframes` or `animation:` | Remove or simplify |

### Inline Styles (INL)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| INL-01 | WARN | Minimize `style=""` attributes | Count `style=` occurrences in HTML | Extract to CSS classes |
| INL-02 | FAIL | Inline styles must not use raw hex colors | Check `style=""` for `#` color values | Use `var(--ibm-*)` |
| INL-03 | WARN | Inline styles should use spacing tokens for padding/margin/gap | Check `style=""` for raw rem/px spacing | Use `var(--space-*)` |

## Slide-Specific Rules

These apply to Reveal.js slide decks (`slides.html`).

### Slide Structure (SLD)

| ID | Severity | Rule | How to Check | Fix |
|----|----------|------|-------------|-----|
| SLD-01 | FAIL | Must use IBM Plex Sans/Mono via `slides.css` or inline `@import` | Check for font import | Add font import to slides CSS |
| SLD-02 | FAIL | Viewport background must be `var(--ibm-gray-100)` | Check `.reveal-viewport` background | Set correct background |
| SLD-03 | WARN | Slide labels should use `.slide-label` class | Check slide label elements | Apply `.slide-label` class |
| SLD-04 | WARN | Accent text should use `.accent` class (blue) or `.danger` class (red) | Check for inline color on emphasized text | Use `.accent` or `.danger` |
| SLD-05 | WARN | Two-column layouts should use `.columns` or `.compare` classes | Check for inline flex/grid column layouts | Use standard layout class |
| SLD-06 | WARN | Feature grids should use `.feature-grid` + `.feature-card` | Check grid-like slide layouts | Use standard feature grid |
| SLD-07 | INFO | Code blocks should use Monokai highlight theme | Check for highlight plugin and monokai.css | Include highlight plugin |
| SLD-08 | WARN | Inline code should have `background: var(--ibm-gray-80)` on dark slides | Check `:not(pre) > code` styling | Use standard slide code styling |
| SLD-09 | INFO | Each slide should have `<aside class="notes">` for speaker notes | Check slides for notes | Add speaker notes |

## Audit Output Format

When reporting audit results, use this format:

```
## Audit Report: [filename]

### Summary
- PASS: X rules
- WARN: Y rules
- FAIL: Z rules

### Failures (must fix)
| Rule | Line | Issue | Fix |
|------|------|-------|-----|
| CLR-01 | 47 | Raw hex `#33b1ff` in inline style | Replace with `var(--ibm-*)` token or add to `:root` |

### Warnings (should fix)
| Rule | Line | Issue | Fix |
|------|------|-------|-----|
| INL-01 | 24, 28, 31 | Inline `style=""` attributes | Extract to CSS classes |

### Passed
CLR-04, CLR-05, TYP-01, TYP-02, TYP-03, GRD-01, GRD-03, STR-01, STR-02, STR-03 ...
```
