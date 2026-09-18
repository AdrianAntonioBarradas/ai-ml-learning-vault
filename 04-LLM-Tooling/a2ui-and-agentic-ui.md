---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: seed
tags: [llm, protocol, a2ui, ag-ui, generative-ui, frontend, agents]
aliases: [A2UI, AG-UI, generative UI, agent-driven interfaces]
---

# A2UI & AG-UI — agents that render interfaces

> Instead of answering in prose, the agent describes a form, a chart or a picker and the client renders it — from a validated catalog, never as code.

## Wide picture

Chat is a poor interface for structured work. Picking a date, filtering a table,
confirming a booking — all are worse as prose than as widgets. **Generative UI** is the
idea that the agent emits an *interface description* and the client renders it.

The safety problem is obvious: an agent emitting HTML or JS is remote code execution
with extra steps. A2UI's answer is that the agent may only reference components from a
**catalog the renderer already trusts**, by name. No code crosses the wire.

Two related projects, often confused:

- **A2UI** (Google, open) — the *declarative UI format*: what the interface is.
- **AG-UI** — the *event-streaming transport* between agent and front end, and the
  usual binding A2UI rides on.

A2UI is transport-agnostic; AG-UI and A2A are two of its bindings.

## Essentials

- **JSON-lines stream**, six envelope message types, each with exactly one key:
  `createSurface`, `updateComponents`, `updateDataModel`, `deleteSurface`,
  `callRendererFunction`, `agentFunctionResponse`. Every message carries `"version"`.
- **Structure and data are strictly separate.** Components are a *flat* list with
  parent/child by ID reference; data arrives separately via `updateDataModel` at JSON
  Pointer paths (`/user/email`). Components bind to data with
  `{"path": "/some/path"}` rather than inline values.
- **Why that split matters:** the shape can be sent before the data exists, and data
  can update without resending the tree. That is what makes progressive rendering work.
- **`root`** is the special component mounted into the implicit surface container.
- **Two-way binding** on inputs: read on render, write on interaction. State goes back
  to the agent only when a user action triggers it.
- **The security model is the interesting part:**
  - Functions declare `allowedCallers` — `rendererOnly`, `agentOnly`, `rendererOrAgent`
    — enforced by the renderer at runtime.
  - Components and functions are validated against a **catalog schema**; unknown or
    malformed references are rejected.
  - Agents transmit *names*, never executable code.
  - Data-model state goes only to the agent that created the surface — no cross-agent
    leakage.
- **AG-UI vs A2UI in one line:** AG-UI is event streaming, A2UI is state
  synchronisation. They compose.

## Mental model

The agent is a *view-model author*, not a front-end developer. It says "a Column with
a TextField bound to `/email` and a Button calling `submit`" — and the renderer, which
you wrote and audited, decides what any of that looks like and what it may do.

## Status, honestly

Specification created November 2025, v1.0 in **Candidate** status as of mid-2026. This
is the newest and least settled layer of the agent protocol stack. Interesting, worth
understanding, and a real bet if you build on it now — hence `status: seed` on this
note and a place on the watchlist.

## When it is worth it

- **Yes:** an agent that must collect structured input, or render results that are
  genuinely tabular/graphical, across more than one client surface.
- **No:** a single web app you own end to end. Then the agent returns JSON and *your*
  front end renders it — same outcome, no protocol.

## Links

- [A2UI specification v1.0](https://a2ui.org/specification/v1.0-a2ui/) — message types, data binding, the catalog security model.
- [Introducing A2UI](https://developers.googleblog.com/introducing-a2ui-an-open-project-for-agent-driven-interfaces/) — the announcement and motivation.
- [AG-UI](https://docs.ag-ui.com/introduction) — the event protocol between agent and front end, and framework integrations.

## Related
- [[agent-protocol-stack]] — which edge this covers and which it does not.
- [[a2a-protocol]] — A2UI has an extension mapping over A2A.
- [[09-Web-to-Components/MOC-Web-to-Components]] — the non-agentic version of the same problem.
- [[06-MLOps-Caveats/prompt-injection-security]] — why "no executable code from the model" is the load-bearing rule.
