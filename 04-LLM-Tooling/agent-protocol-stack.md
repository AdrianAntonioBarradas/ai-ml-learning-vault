---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [llm, protocol, agents, interop, mcp, a2a, a2ui, decision-guide]
aliases: [agent protocols, MCP vs A2A, protocol stack]
---

# The agent protocol stack — who talks to whom

> Four protocols, four different edges of the same agent. They are not competitors; picking between them is a category error. Ask *which edge* you are standardising.

## Wide picture

The 2025–2026 wave of "agent protocols" reads like a crowded field until you notice
they sit on different boundaries. One agent, four edges:

```
                    ┌───────────────────────┐
   client / host ──►│                       │──► tools, APIs, data
   Open Responses   │        AGENT          │    MCP
                    │                       │
   human / browser ◄┤                       ├──► other agents
   A2UI · AG-UI     └───────────────────────┘    A2A
```

| Edge | Protocol | Standardises |
|---|---|---|
| Client → agent | **Open Responses** | Calling an agent like a model: one request/response schema |
| Agent → tools | **MCP** | Exposing tools, resources and prompts to a model |
| Agent → agent | **A2A** | Delegating a *task* to another agent and getting artifacts back |
| Agent → UI | **A2UI** (over **AG-UI**) | An agent describing an interface for a human to use |

Nothing forces you to adopt all four, and most systems need one or two.

## MCP — the agent-to-tool edge

The one you already use daily. An MCP **server** exposes capabilities; an MCP **client**
(Claude Code, an IDE, your own agent) consumes them.

- **Three primitives:** `tools` (model-invoked functions), `resources` (context the host
  can read), `prompts` (user-invoked templates).
- **Transports:** stdio for local processes, streamable HTTP for remote.
- **Why it matters architecturally:** it moves the tool *implementation* out of the
  agent. The agent declares what it can reach; the server decides what that means.
- **Where it does not help:** it says nothing about how *your* agent is called, or how
  it collaborates with another agent. Different edges.

## Choosing

- Someone needs to **call your agent** over HTTP → Open Responses. See
  [[open-responses-protocol]].
- Your agent needs **tools that other people maintain** → MCP.
- Your agent needs to **hand a task to a specialist agent** and get a result back →
  A2A. See [[a2a-protocol]].
- Your agent needs to **put a form, a chart or a picker in front of a human** →
  A2UI. See [[a2ui-and-agentic-ui]].
- **None of the above** — one agent, your own tools, one client you control → skip all
  of it. A protocol is only worth its weight when the thing on the other side is not
  yours.

## Mental model

Networking layers, not competing standards. MCP is the driver interface, A2A is the
peer protocol, A2UI is the presentation layer, Open Responses is the public API. Asking
"MCP or A2A?" is like asking "USB or Ethernet?"

## The honest caveat

This space is moving fast and consolidating unevenly. MCP has broad adoption; A2A has
governance and SDKs but thinner production usage; A2UI and AG-UI are new enough that
committing early is a bet. Read adoption before architecture — a protocol with no
counterparties is just a schema. On the **watchlist** for exactly this reason.

## Links

- [Model Context Protocol](https://modelcontextprotocol.io/) — spec, SDKs, server registry.
- [A2A Protocol](https://a2a-protocol.org/latest/) — spec and the Linux Foundation governance.
- [A2A & MCP, side by side](https://a2a-protocol.org/latest/topics/a2a-and-mcp/) — the official "complementary, not competing" argument.
- [A2UI](https://a2ui.org/) — agent-driven declarative interfaces.
- [AG-UI](https://docs.ag-ui.com/introduction) — the event-streaming transport A2UI usually rides on.
- [Open Responses](https://www.openresponses.org/) — the client-facing contract.

## Related
- [[open-responses-protocol]] — the edge covered in depth.
- [[a2a-protocol]], [[a2ui-and-agentic-ui]] — the other two.
- [[model-standardization]] — the older layer: standardising the *model*, not the agent.
- [[08-Consulting-and-Architecture/heavy-ai-vs-simple]] — whether you need any of this.
