---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, stateful, serving, sessions]
---

# Stateful serving patterns

> How serving systems keep context across parallel queries without cross-user leakage.

## Wide picture

A model server is usually stateless per request, but several patterns exist for keeping useful state across calls. Understanding them tells you when you can rely on the server vs when you must hold state yourself.

## Essentials

- **Stateless workers (default)** — each request is self-contained; the client sends the full prompt each call. Simplest to scale; the basis of the OpenAI-compatible API. You own conversation history.
- **KV-cache within a request** — the server caches computed token states for the current generation only; discarded at request end. Not shared across users.
- **Session affinity / sticky routing** — route the same `conversation_id` to the same replica so a server-side prompt cache stays warm. Useful with prompt caching enabled.
- **Prompt caching (provider-side)** — OpenAI/Anthropic cache the prefix of repeated prompts; big cost/latency win for system prompts + long shared context, charged at a discount.
- **External state store** — the robust default for multi-user: context in Redis/DB, model stays stateless. See [[multi-user-context-concurrency]].
- **Prefill/decode disaggregation** — state (the KV-cache) is passed from the prefill replica to a decode replica; a specialised form of stateful serving for throughput.

## Mental model

Treat server-side state as a **performance cache, not the source of truth**. The conversation's authoritative state lives in your store; any server-side cache (prompt cache, sticky routing) is an optimisation you can lose without correctness impact.

## Links

- [Anthropic prompt caching](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching) — prefix caching.
- [OpenAI cached input tokens](https://platform.openai.com/docs/guides/prompt-caching) — provider caching.
- [DistServe (P/D disaggregation)](https://arxiv.org/abs/2401.09670) — passing KV state across replicas.

## Related
- [[multi-user-context-concurrency]], [[batching-caching-scaling]], [[05-Chatbot-Engineering/conversation-state-context]]
