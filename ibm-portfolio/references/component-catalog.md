# Component Catalog

Every component used in the portfolio, with HTML structure and required CSS classes. Reference implementation: `ev/index.html` + `ev/css/style.css`.

## Sections

### Standard Section (white background)
```html
<section class="section">
  <div class="container">
    <p class="section-label">Label Text</p>
    <h2 class="section-title">Section Heading</h2>
    <!-- content -->
  </div>
</section>
```

### Dark Section
```html
<section class="section section--dark">
  <div class="container">
    <p class="section-label">Label Text</p>
    <h2 class="section-title">Section Heading</h2>
    <!-- content -->
  </div>
</section>
```
- Background: `var(--ibm-gray-100)`, text: `var(--ibm-white)`
- `code` elements get `background: var(--ibm-gray-80)` automatically

### Light Section
```html
<section class="section section--light">
  <div class="container">
    <p class="section-label">Label Text</p>
    <h2 class="section-title">Section Heading</h2>
    <!-- content -->
  </div>
</section>
```
- Background: `var(--ibm-gray-10)`

### Hero Section
Same as dark section but typically with custom padding:
```html
<section class="section section--dark hero">
  <div class="container">
    <p class="section-label">Category Label</p>
    <h1>Main Heading</h1>
    <p class="hero-subtitle">Subtitle text</p>
    <!-- terminal block or CTA buttons -->
  </div>
</section>
```
Note: The `ev/index.html` hero uses inline `style="padding: 6rem 0 5rem;"` — ideally this should be a `.hero` class in CSS.

## Cards

### Feature Card
```html
<div class="card">
  <h3>Card Title</h3>
  <p>Card description text goes here.</p>
</div>
```
- Background: `var(--ibm-white)`, border: `1px solid var(--ibm-gray-20)`
- Padding: `var(--space-5)`
- Hover: `box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1)`

### Card with Icon
```html
<div class="card">
  <div class="card-icon">&#9888;</div>
  <h3>Card Title</h3>
  <p>Description text.</p>
</div>
```
- Icon size: `1.5rem`, margin-bottom: `var(--space-3)`
- Icon color: use token like `var(--ibm-red-60)` or `var(--ibm-yellow-30)`

### Project Card (root index only)
```html
<a href="project/index.html" class="project-card" id="project-id">
  <span class="project-card__arrow">&rarr;</span>
  <p class="project-card__label">Category &middot; Language</p>
  <h3 class="project-card__title">Project Name</h3>
  <p class="project-card__desc">Short description.</p>
  <div class="project-card__tags">
    <span class="tag">Tag 1</span>
    <span class="tag">Tag 2</span>
  </div>
  <div class="project-card__links">
    <span class="project-card__link">Landing Page &rarr;</span>
  </div>
</a>
```
- Entire card is a link (`<a>`)
- Arrow appears on hover (opacity transition)
- Border hover: `var(--ibm-blue-60)`

## Terminal Block

```html
<div class="terminal">
  <div class="terminal-bar">
    <span class="terminal-dot terminal-dot--red"></span>
    <span class="terminal-dot terminal-dot--yellow"></span>
    <span class="terminal-dot terminal-dot--green"></span>
  </div>
  <pre><code>$ command here
output here</code></pre>
</div>
```
- Background: `var(--ibm-gray-100)`, bar: `var(--ibm-gray-90)`
- Dots: red `#ff5f57`, yellow `#febc2e`, green `#28c840`
- Code color: `#33b1ff` (IBM cyan, used in `pre` default)
- Prompt symbol: `$` in `var(--ibm-gray-30)`
- Comments: `var(--ibm-gray-70)`
- Success checks: `var(--ibm-green-50)` with `&#10003;`

## Flow / Steps

```html
<div class="flow">
  <div class="flow-step">
    <div class="flow-number">1</div>
    <h3><code>command</code></h3>
    <p class="text-muted">Description of this step.</p>
  </div>
  <div class="flow-arrow">&rarr;</div>
  <div class="flow-step">
    <div class="flow-number">2</div>
    <h3><code>command</code></h3>
    <p class="text-muted">Description of this step.</p>
  </div>
  <!-- repeat -->
</div>
```
- Mobile: vertical stack with `gap: var(--space-5)`
- Desktop (66rem+): horizontal with arrows visible
- Number circle: `var(--ibm-blue-60)` bg, `var(--ibm-white)` text, 2rem diameter

## Callout Box

```html
<div class="callout">
  <p class="section-label">Callout Label</p>
  <h3>Callout Heading</h3>
  <p>Callout body text.</p>
</div>
```
- Border-left: `4px solid var(--ibm-red-60)`
- Background: `rgba(218, 30, 40, 0.05)` (light) or `rgba(218, 30, 40, 0.15)` (dark section)
- Padding: `var(--space-5)`

## Table

```html
<div class="table-wrap">
  <table>
    <thead>
      <tr>
        <th>Column 1</th>
        <th>Column 2</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><code>value</code></td>
        <td>Description</td>
      </tr>
    </tbody>
  </table>
</div>
```
- `table-wrap` provides horizontal scroll on mobile
- Header: weight 600, uppercase, letter-spacing 0.32px, bottom border 2px `gray-100`
- Rows: bottom border 1px `gray-20`, hover bg `gray-10`
- Cell padding: `var(--space-3) var(--space-4)`

## Buttons

### Primary Button
```html
<a href="#target" class="btn btn--primary">Button Text</a>
```
- Background: `var(--ibm-blue-60)`, hover: `var(--ibm-blue-70)`
- Text: `var(--ibm-white)`

### Ghost Button
```html
<a href="#target" class="btn btn--ghost">Button Text</a>
```
- Background: transparent, border: `1px solid var(--ibm-blue-60)`
- Text: `var(--ibm-blue-60)`, hover bg: `rgba(15, 98, 254, 0.08)`

### Ghost Button on Dark Background
When placing a ghost button on a dark section, override colors:
```html
<a href="#" class="btn btn--ghost" style="color: var(--ibm-white); border-color: var(--ibm-gray-70);">Text</a>
```
Note: Ideally create a `.btn--ghost-dark` variant class instead of inline styles.

## Badges

```html
<span class="badge">Default Badge</span>
<span class="badge badge--green">Success</span>
<span class="badge badge--red">Danger</span>
```
- Default: `var(--ibm-blue-60)` background
- Pill shape: `border-radius: 0.75rem`
- Font: 0.75rem, weight 600

## Tags

```html
<span class="tag">Tag Text</span>
```
- Background: `var(--ibm-gray-10)`, color: `var(--ibm-gray-70)`
- Font: 0.75rem, padding: `0.125rem 0.5rem`

## Table of Contents (root index)

```html
<ul class="toc">
  <li class="toc__item">
    <a href="#project-id" class="toc__link">name &mdash; tagline</a>
  </li>
</ul>
```
- Horizontal flex layout with `gap: var(--space-4)`
- Border: `1px solid var(--ibm-gray-20)`, hover border: `var(--ibm-blue-60)`
- Hover bg: `rgba(15, 98, 254, 0.08)`

## Footer

```html
<footer class="footer">
  <div class="container" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: var(--space-4);">
    <div>
      <strong style="color: var(--ibm-white);">Name</strong>&ensp;&middot;&ensp;Tagline
    </div>
    <div>
      <a href="url">Link</a>&ensp;&middot;&ensp;
      <a href="url">Link</a>&ensp;&middot;&ensp;
      License
    </div>
  </div>
</footer>
```
- Background: `var(--ibm-gray-100)`, text: `var(--ibm-gray-30)`
- Links: `var(--ibm-blue-60)`, hover: underline
- Padding: `var(--space-6) 0`

## Utility Classes

| Class | CSS | Use |
|-------|-----|-----|
| `.text-center` | `text-align: center` | Center content |
| `.text-muted` | `color: var(--ibm-gray-70)` | Secondary text |
| `.mt-4` | `margin-top: var(--space-4)` | Top margin 1rem |
| `.mt-6` | `margin-top: var(--space-6)` | Top margin 2rem |
| `.mb-4` | `margin-bottom: var(--space-4)` | Bottom margin 1rem |
| `.mb-6` | `margin-bottom: var(--space-6)` | Bottom margin 2rem |
