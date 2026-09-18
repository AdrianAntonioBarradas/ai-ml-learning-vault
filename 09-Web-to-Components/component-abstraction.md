---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [web, frontend, react, components, design-system]
---

# Component abstraction

> A design becomes maintainable when you abstract it into composable, tokenised components with clear boundaries.

## Wide picture

Turning a design into code is easy; turning it into *reusable components* is the skill. The work: identify repeated patterns, factor them into components with clear props, extract design tokens (color, spacing, typography) so styling is consistent and themeable, and verify components in isolation with Storybook.

## Essentials

- **Atomic design** — atoms → molecules → organisms → templates → pages; a granularity ladder.
- **Component boundaries** — a component should do one thing; props are its API. Resist mega-components.
- **Design tokens** — centralized color/spacing/type/radius as variables (CSS variables, Tailwind config, a tokens file); enables theming + consistency.
- **Composition over configuration** — build big UIs from small pieces, not from one giant prop-driven component.
- **State + data at the right level** — keep presentational components dumb; lift state to containers/hooks.
- **Storybook** — develop + document + test components in isolation; visual regression.
- **Accessibility from the start** — semantic HTML, ARIA, keyboard nav; cheaper to build in than retrofit.
- **Headless UI + styled primitives** — Radix, shadcn/ui, Headless UI: behaviour + a11y handled, you own styling.

## Mental model (SWE angle)

Component abstraction is just good modularity applied to UI: small, composable, well-interfaced units over a shared vocabulary (tokens). The design system is the "standard library" of your product UI.

## Links
- [Atomic Design (Brad Frost)](https://atomicdesign.bradfrost.com/) — the methodology.
- [Storybook](https://storybook.js.org/) — isolated component dev.
- [shadcn/ui](https://ui.shadcn.com/) · [Radix UI](https://www.radix-ui.com/) — headless primitives.
- [Design Tokens W3C spec](https://www.w3.org/community/design-tokens/) — token standard.

## Related
- [[design-to-code-tools]], [[ai-assisted-frontend]]
