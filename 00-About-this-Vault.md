---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [meta, charter]
---

# About this vault

> An open, community-maintained lab to build AI/ML/Engineering **intuition** on top of an applied-mathematics and software-engineering foundation.

## Why this exists

Most AI/ML material is free, but not everyone develops the **intuition** for solving business tasks with it: knowing *when* a problem needs heavy AI, *when* it is better handled deterministically, and *how* the pieces fit into a reliable system. This vault is built to grow that intuition deliberately, then layer real daily practice on top.

It is not a textbook. It is a **wide-picture map with curated links**: each note gives you the essentials and the mental model, then points to the best resources to go deep. The depth lives in the links; the vault holds the structure and the connections.

## Who it is for

- People with a background in **mathematics** and/or **software engineering** moving into AI/ML.
- Anyone following the **Hugging Face courses** who wants a map around them.
- Engineers building **chatbots/LLM apps** or consulting on business problems.
- Anyone who wants an **architectural mindset**: tradeoffs, cost/latency/reliability, build-vs-buy, heavy-AI-vs-simple.

## Learning philosophy

1. **Wide picture first, depth on demand.** Every note opens with the mental model, then links out.
2. **Tie concepts to working code.** The [[02-PoC-Techniques/MOC-PoC-Techniques|PoC techniques]] section is grounded in a real chatbot PoC codebase so abstractions stay anchored.
3. **Architectural mindset over memorisation.** Favour decision guides (when to use X vs Y) over recipes.
4. **Build on daily practice.** Use [[07-Learning-Path/fundamentals-starter-pack|the starter pack]] to get foundations, then return to sections as real work demands them.
5. **Track staleness.** AI tooling shifts fast — see [[Review-Log]] and the staleness workflow below.

## How to use it

- **Reading / graph view:** open this folder as an Obsidian vault (File → Open vault → choose the cloned folder).
- **Fast editing / navigation:** use **Helix** from the vault root. With the `marksman` LSP installed you get wikilink go-to-definition (`gd` on a wikilink), completion, hover, and a document-symbol outline (`space+s` to jump between headings).
- **Convenience commands:** see the `Justfile` (`just home`, `just new`, `just search`, `just stale`, `just toc`). Details in `README.md`.

## Conventions

- **Links:** wikilinks (Obsidian-style double-bracket links, not markdown links) so Obsidian and marksman agree.
- **Frontmatter:** every note carries `created`, `updated`, `last_reviewed`, `status` (`seed`/`draft`/`stable`/`needs-review`), and `tags`.
- **Link curation standard:** every external link has a one-line "why" so you know what to expect before clicking.
- **MOCs:** each section has a `MOC-*.md` Map of Content as its index.

## Staleness workflow (things change fast)

1. When you touch a note, update its `updated` and `last_reviewed` dates.
2. Add a dated entry to [[Review-Log]] describing what changed.
3. Find aging notes from the terminal: `just stale` (lists notes with `last_reviewed` older than 90 days or missing).
4. In Obsidian, the [[00-Home]] dashboard has a Dataview query that surfaces `needs-review` and stale notes automatically.

## Contributing

This vault is open to contributions — see `CONTRIBUTING.md` (ES/EN).

## Map

- [[00-Home]] — dashboard
- [[01-Foundations/MOC-Foundations|Foundations]] — applied maths → ML
- [[02-PoC-Techniques/MOC-PoC-Techniques|PoC techniques]] — from a real chatbot PoC
- [[03-Inference-Deployment/MOC-Inference-Deployment|Inference & deployment]]
- [[04-LLM-Tooling/MOC-LLM-Tooling|LLM tooling & LangChain]]
- [[05-Chatbot-Engineering/MOC-Chatbot-Engineering|Chatbot engineering]]
- [[06-MLOps-Caveats/MOC-MLOps-Caveats|MLOps caveats & pitfalls]]
- [[07-Learning-Path/MOC-Learning-Path|Learning path & resources]]
- [[08-Consulting-and-Architecture/MOC-Consulting-Architecture|Consulting & architecture]]
- [[09-Web-to-Components/MOC-Web-to-Components|Web design → components]]
- [[11-Platforms/MOC-Platforms|Platforms]] — Railway, Supabase, Vercel (admin-level)
