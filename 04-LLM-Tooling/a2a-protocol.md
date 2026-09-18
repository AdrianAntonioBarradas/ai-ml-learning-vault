---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [llm, protocol, a2a, agents, interop, multi-agent]
aliases: [A2A, Agent2Agent, agent card]
---

# A2A — the agent-to-agent protocol

> Delegating a *task* to an agent you did not write, without either side exposing its internals. Tasks are long-lived and stateful, which is what separates it from a function call.

## Wide picture

Started at Google, donated to the **Linux Foundation**; the steering committee now
includes AWS, Cisco, IBM, Microsoft, Salesforce, SAP and ServiceNow. Version 1.0, with
a Protobuf definition as the normative source of truth.

The framing that makes it click: **MCP gives one agent tools; A2A lets agents
collaborate**. An MCP tool call is a function that returns. An A2A task is a unit of
work that can take minutes, ask you a clarifying question halfway through, need
authentication, stream partial results, and produce artifacts.

## Essentials

- **Discovery: the Agent Card** at `/.well-known/agent-card.json` — `name`,
  `description`, `version`, `skills` (id, name, description, tags, examples),
  `capabilities` (`streaming`, `push_notifications`, `extensions`),
  `security_schemes`, `default_input_modes` / `default_output_modes`, and
  `supported_interfaces` listing each URL + binding.
- **Three transport bindings:** JSON-RPC 2.0 over HTTP/SSE, gRPC, and HTTP/REST. The
  agent advertises which it speaks.
- **The Task is the unit**, not the message. `id`, `context_id`, `status`, `artifacts`,
  `history`, `metadata`.
- **Task states:** `SUBMITTED` → `WORKING` → one of `COMPLETED` / `FAILED` /
  `CANCELED` / `REJECTED` (terminal), or an interruption: `INPUT_REQUIRED`,
  `AUTH_REQUIRED`. Those last two are the interesting part — the protocol expects an
  agent to *stop and ask*.
- **Messages carry `Part`s** — `text`, `raw` bytes, `url`, or structured `data`, each
  with a `media_type`. **Artifacts** are the durable outputs.
- **Core RPCs:** `SendMessage`, `SendStreamingMessage`, `GetTask`, `ListTasks`,
  `CancelTask`, `SubscribeToTask`, plus push-notification config CRUD.
- **Long-running work has two shapes:** SSE streaming for a connected client, and
  **push notifications** (webhooks, authenticated per task) for work that outlives the
  connection.
- **SDKs:** Python (`a2a-sdk`), JS/TS, Java, Go, .NET, Rust. Integrations with
  LangGraph, CrewAI, Google ADK, PydanticAI.

## What A2A explicitly is not

Worth knowing before reaching for it: not an agent-building framework, not a
sub-agent/orchestration mechanism inside one system, not an MCP replacement, and not a
human messaging platform. It is machine-to-machine, between agents that belong to
*different owners*.

## Mental model

A ticketing system between organisations, not a function call. You file work with
another team, they may come back with questions, and eventually you get deliverables —
`INPUT_REQUIRED` is the "we need more info from you" reply.

## When it is overkill

If both agents are yours and in the same process or repo, A2A buys you serialisation
overhead and a task state machine you did not need — call the function. It earns its
weight at an **ownership boundary**: another team, another vendor, another company.

## Note on the agent card

The card is useful on its own even without adopting A2A wholesale. Some platforms
accept a card URL and auto-fill agent registration from it,
so serving `/.well-known/agent-card.json` makes an agent discoverable for ~40 lines,
whatever protocol actually serves the traffic.

## Links

- [A2A specification](https://a2a-protocol.org/latest/specification/) — v1.0; the `.proto` is normative, the JSON Schema is generated.
- [Life of a Task](https://a2a-protocol.org/latest/topics/life-of-a-task/) — the state machine, which is the concept to internalise.
- [A2A and MCP](https://a2a-protocol.org/latest/topics/a2a-and-mcp/) — the complementarity argument, from the source.
- [Agent discovery](https://a2a-protocol.org/latest/topics/agent-discovery/) — the card, and how agents find each other.

## Related
- [[agent-protocol-stack]] — where this sits relative to MCP, A2UI and Open Responses.
- [[a2ui-and-agentic-ui]] — A2UI can ride over A2A as an extension.
- [[open-responses-protocol]] — the client-facing edge; also uses an agent card.
- [[03-Inference-Deployment/inference-api-architectures]] — SSE vs webhooks, the same choice A2A exposes.
