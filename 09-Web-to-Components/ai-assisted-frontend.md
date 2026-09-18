---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [web, frontend, ai, llm, browser]
---

# AI-assisted frontend

> Use LLMs to scaffold, refactor, and even run models in the browser — but keep a human architect in the loop.

## Wide picture

LLMs accelerate frontend work in three ways: scaffolding UI from screenshots/mockups (see [[design-to-code-tools]]), refactoring/generating component logic in your editor (Copilot/Cursor/Claude Code), and running small models directly in the browser via WebGPU for privacy/offline features. The common caveat: AI generates plausible code that skips accessibility, performance, and architectural fit — review is mandatory.

## Essentials

- **Editor AI** — GitHub Copilot, Cursor, Claude Code, Continue; generate/refactor components, tests, styles.
- **Screenshot → code** — v0/screenshot-to-code for first drafts (see [[design-to-code-tools]]).
- **Browser LLMs (WebGPU)** — WebLLM/MLC runs small open models in-browser; private, offline, no server cost; great for niche features, not for heavy reasoning.
- **AI for a11y/tests** — generate test cases, alt text, axe-style checks.
- **The review discipline** — AI output needs the same review as any PR: boundaries, tokens, a11y, performance, security (especially XSS from generated DOM).
- **Prompting for components** — specify the stack, tokens, prop API, and a11y requirements up front for much better output.

## Mental model (architectural mindset)

AI is a frontend accelerator, not an architect. Use it to compress boilerplate and explore; impose [[component-abstraction]] and review for the NFRs it tends to ignore. Bet on AI for generation, on humans for boundaries.

## Links
- [WebLLM (MLC)](https://webllm.mlc.ai/) — LLMs in the browser via WebGPU.
- [Cursor](https://cursor.sh/) · [Claude Code](https://www.anthropic.com/) — editor AI.
- [axe DevTools](https://www.deque.com/axe/) — a11y checking for generated UI.

## Related
- [[design-to-code-tools]], [[component-abstraction]], [[04-LLM-Tooling/langchain-tools-and-agents]]
