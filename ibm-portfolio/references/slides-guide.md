# Reveal.js Slide Conventions — IBM Theme

Guidelines for building Reveal.js slide decks with the IBM Design Language theme. Reference implementation: `ev/slides.html` + `ev/css/slides.css`.

## Required Setup

### HTML Structure
```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project — Slide Deck Title</title>
  <link rel="stylesheet" href="reveal/dist/reveal.css">
  <link rel="stylesheet" href="reveal/plugin/highlight/monokai.css">
  <link rel="stylesheet" href="css/slides.css">
</head>
<body>
  <div class="reveal">
    <div class="slides">
      <!-- slides go here -->
    </div>
  </div>
  <script type="module">
    import Reveal from './reveal/dist/reveal.esm.js';
    import Highlight from './reveal/plugin/highlight/highlight.esm.js';
    Reveal.initialize({
      hash: true,
      slideNumber: true,
      controls: true,
      progress: true,
      center: true,
      transition: 'slide',
      plugins: [Highlight]
    });
  </script>
</body>
</html>
```

### CSS Requirements
The `slides.css` file must:
1. Import IBM Plex Sans (300/400/600) + IBM Plex Mono (400) via `@import url()` or `<link>`
2. Define all `--ibm-*` color tokens in `:root`
3. Set `.reveal-viewport` background to `var(--ibm-gray-100)`
4. Set `.reveal` font-family to `'IBM Plex Sans', sans-serif`

## Slide Patterns

### Title Slide
```html
<section>
  <p class="slide-label">Category Label</p>
  <h1><span class="accent">keyword</span>: Main Title<br>Second Line</h1>
  <p>One-line summary sentence.</p>
  <aside class="notes">Speaker notes for this slide.</aside>
</section>
```

### Content Slide (standard)
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2>Slide Title with <span class="accent">Accent</span></h2>
  <ul>
    <li><strong>Bold term</strong> &mdash; explanation text</li>
    <li><strong>Bold term</strong> &mdash; explanation text</li>
  </ul>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Code Slide
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2><code>command</code> &mdash; Description</h2>
  <pre><code class="language-bash">$ command output here</code></pre>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Comparison Slide (before/after)
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2>Title with <span class="danger">Problem</span></h2>
  <div class="compare">
    <div>
      <p class="compare-label compare-label--bad">Before Label</p>
      <pre><code class="language-bash">bad example</code></pre>
    </div>
    <div>
      <p class="compare-label compare-label--good">After Label</p>
      <pre><code class="language-bash">good example</code></pre>
    </div>
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Two-Column Slide
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2>Slide Title</h2>
  <div class="columns">
    <div>
      <h3>Left Column</h3>
      <pre><code>left content</code></pre>
    </div>
    <div>
      <h3>Right Column</h3>
      <pre><code>right content</code></pre>
    </div>
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Feature Grid Slide
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2>Grid Title</h2>
  <div class="feature-grid">
    <div class="feature-card">
      <h4>Feature Name</h4>
      <p>Short description.</p>
    </div>
    <!-- repeat for 3 or 6 cards -->
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```
- Default: 3 columns. Override with `style="grid-template-columns: repeat(2, 1fr);"` for 2 columns.
- Cards have left border `3px solid var(--ibm-blue-60)` by default. Override border-color for accent (e.g., `var(--ibm-red-60)` for danger cards).

### Architecture/Flow Slide
```html
<section>
  <p class="slide-label">Section Label</p>
  <h2>Flow Title</h2>
  <div class="arch-flow">
    <div class="arch-box">Step 1</div>
    <div class="arch-arrow">&rarr;</div>
    <div class="arch-box arch-box--highlight">Step 2</div>
    <div class="arch-arrow">&rarr;</div>
    <div class="arch-box">Step 3</div>
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Command Grid Slide
```html
<section>
  <p class="slide-label">Complete CLI</p>
  <h2>N Commands</h2>
  <div class="cmd-grid">
    <div class="cmd-item"><code>cmd name</code><span>Description</span></div>
    <!-- repeat -->
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```
- 4-column grid layout
- Code in `#33b1ff` (IBM cyan)

### Pillars/Summary Slide
```html
<section>
  <p class="slide-label">Summary Label</p>
  <h2>Three Pillars</h2>
  <div class="pillars">
    <div class="pillar">
      <div class="pillar-icon" style="color: var(--ibm-blue-60);">&#9655;</div>
      <h3>Pillar Name</h3>
      <p class="muted">Description.</p>
    </div>
    <!-- repeat for 3 -->
  </div>
  <aside class="notes">Speaker notes.</aside>
</section>
```

### Call to Action Slide (final)
```html
<section>
  <h2><span class="accent">Get Started</span> Today</h2>
  <pre><code class="language-bash">install command here</code></pre>
  <p style="margin-top: 1em;">
    <a href="url" style="color: var(--ibm-blue-60); font-size: 0.8em;">link text</a>
  </p>
  <p class="muted" style="font-size: 0.6em; margin-top: 2em;">
    License &middot; Tech &middot; Details
  </p>
  <aside class="notes">Speaker notes.</aside>
</section>
```

## CSS Classes Reference

| Class | Purpose |
|-------|---------|
| `.slide-label` | Uppercase blue label above slide title (0.5em, letter-spacing 0.32px) |
| `.accent` | Blue text (`var(--ibm-blue-60)`) |
| `.danger` | Red text (`var(--ibm-red-60)`) |
| `.warn` | Yellow text (`var(--ibm-yellow-30)`) |
| `.muted` | Gray text (`var(--ibm-gray-30)`) |
| `.columns` | Flexbox 2-column layout |
| `.compare` | CSS Grid 2-column comparison with labels |
| `.compare-label--bad` | Red label for "before" side |
| `.compare-label--good` | Green label for "after" side |
| `.feature-grid` | 3-column CSS Grid for feature cards |
| `.feature-card` | Card with left blue border on gray-90 background |
| `.callout-box` | Red left border callout on dark background |
| `.arch-flow` | Horizontal flow diagram with boxes and arrows |
| `.arch-box` | Flow diagram box (gray-90 bg) |
| `.arch-box--highlight` | Highlighted flow box (blue border, blue tint) |
| `.cmd-grid` | 4-column command reference grid |
| `.pillars` | 3-column centered summary layout |

## Slide Typography

Slides use lighter weights than landing pages for readability on dark backgrounds:

| Element | Size | Weight | Color |
|---------|------|--------|-------|
| h1 | 2.625em | 300 | `--ibm-white` |
| h2 | 2em | 300 | `--ibm-white` |
| h3 | 1.25em | 600 | `--ibm-white` |
| Body | 2rem base | 400 | `--ibm-gray-30` |
| List items | 0.85em | 400 | `--ibm-gray-30` |
| Code (pre) | 0.5em | 400 | Monokai theme |
| Inline code | 0.85em | 400 | `#33b1ff` on `--ibm-gray-80` |

## Recommended Slide Count

- **Short talk (5-10 min):** 8-12 slides
- **Standard talk (15-20 min):** 14-18 slides
- **Deep dive (30+ min):** 20-25 slides

## Slide Deck Structure Pattern

1. **Title slide** — Project name, one-line summary
2. **Problem slides** (1-2) — Why this matters
3. **Overview slide** — Architecture/approach
4. **Core concept slides** (2-3) — Key innovation
5. **Workflow slides** (3-4) — Step-by-step usage
6. **Feature/security slides** (1-2) — Capabilities grid
7. **Differentiator slide** (1) — Unique value / comparison
8. **Summary slide** — Pillars or key takeaways
9. **CTA slide** — Install command + links
