---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [llm, protocol, open-responses, api, standardization, interop]
aliases: [Open Responses, Responses API]
---

# Open Responses — the interop protocol for agents

> A shared request/response shape so any client can talk to any agent. The front door is `POST {base}/responses`, and the schema is far stricter than the prose suggests.

## Wide picture

Chat Completions became the de-facto standard for *models*. Open Responses is the
equivalent attempt for *agents*: one schema for items, streaming and tool invocation,
so a platform can point at an arbitrary endpoint and get a usable agent. Backed by
OpenAI, NVIDIA, Vercel, Hugging Face and AWS among others.

The practical consequence for anything you build: your agent's public contract and its
internal architecture are separate problems. Keep a translation boundary between them
and the protocol becomes replaceable.

## Essentials

- **Endpoint.** Clients register a *base URL* and append `/responses`. Register
  `https://host/v1` and requests land on `POST /v1/responses`.
- **Auth.** `Authorization: Bearer <key>`.
- **Request.** `model`, `input`, `instructions`, `tools`, `tool_choice`, `stream`,
  `store`, `previous_response_id`. `input` is either a bare string or an array of
  items — accept both.
- **Conversation state is a client-side choice.** Either the client replays the whole
  transcript each turn (stateless agent, often the default) or it sends
  `previous_response_id` and the agent stores state. Check which before building a
  session store you may not need.
- **The response schema has no optional properties.** 31 required fields, including
  ones your agent has no opinion about — `top_logprobs`, `frequency_penalty`,
  `service_tier`, `truncation`, `parallel_tool_calls`. Echo back what was in effect.
- **Request and response schemas for the same concept differ.** A tool in a *request*
  may omit `strict`; the same tool echoed in a *response* requires it. Do not assume
  symmetry because the field names match.
- **Items are the unit of output.** `message`, `function_call`, `function_call_output`,
  `reasoning`. Provider-specific types use `provider_slug:custom_type`.
- **Client-declared tools are the client's to run.** When the caller passes `tools`,
  the agent returns a `function_call` item and stops; the caller executes and sends a
  `function_call_output` next turn. Distinct from tools the agent runs internally.
- **Streaming** is SSE with `Content-Type: text/event-stream`:
  `response.created` → `response.in_progress` → `response.output_item.added` →
  `response.content_part.added` → `response.output_text.delta`* →
  `response.output_text.done` → `response.content_part.done` →
  `response.output_item.done` → `response.completed`, then a literal `data: [DONE]`.
  Every event needs a `sequence_number`.
- **There is an executable compliance suite** — 17 tests, 10 HTTP and 7 WebSocket. See
  [[06-MLOps-Caveats/evaluating-your-evaluator]] for why running it early matters more
  than it sounds.

## Mental model

Treat it like implementing an HTTP server against an RFC, not like calling an SDK. The
spec is a schema first and a document second — so read the OpenAPI, not the prose, and
run the conformance suite before you believe you conform.

## Running the compliance suite

Documented as a `bun` command, but it is plain TypeScript and runs under `npx tsx`:

```bash
git clone --depth 1 https://github.com/openresponses/openresponses.git
cd openresponses && npm i zod tsx
npx tsx bin/compliance-test.ts \
  --base-url https://your-host/v1 --api-key $KEY --model your-model --json
```

Wire the HTTP subset into CI. It is the only test that can tell you your *reading* of
the spec was wrong.

## Links

- [openresponses.org](https://www.openresponses.org/) — spec, reference, compliance tester.
- [Specification](https://www.openresponses.org/specification) — items, streaming, tool semantics.
- [GitHub repo](https://github.com/openresponses/openresponses) — the OpenAPI JSON under `public/openapi/` is the authority; `bin/compliance-test.ts` is the tester.
- [A2A agent card](https://a2a-protocol.org/latest/topics/agent-discovery/) — `/.well-known/agent-card.json`; some platforms auto-fill registration from it. See [[a2a-protocol]].

## Related
- [[agent-protocol-stack]] — which edge this covers, and the three it does not.
- [[model-standardization]] — the OpenAI-compatible API as the other de-facto standard.
- [[03-Inference-Deployment/streaming-responses]] — SSE mechanics on the client side.
- [[reasoning-model-turn-state]] — what a conformant agent must replay between turns.
- [[06-MLOps-Caveats/evaluating-your-evaluator]] — why self-written contract tests pass while the spec fails.
