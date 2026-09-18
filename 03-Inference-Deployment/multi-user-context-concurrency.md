---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, concurrency, multi-user, state, redis, chatbot]
---

# Multi-user context & concurrency

> Many users hit the chatbot at once; each conversation's context must stay isolated, correct, and fast.

## Wide picture

The CRM chatbot problem: hundreds/thousands of users send messages concurrently. Each has their own conversation history and entities (which program they're asking about). The model server is stateless between calls, so **context lives outside the model** — in a session store keyed by user/conversation. The system must route each message to the right context, keep conversations from leaking into each other, and shed load gracefully under spikes.

## Essentials

- **Stateless model, stateful conversation** — the inference server holds no per-user state between requests; you keep history/entities in an external store.
- **Session key** — every request carries `user_id` + `conversation_id`; all context lookups are keyed on them.
- **Context store** — Redis (fast, TTL) for hot session state; Postgres for durable transcripts. Keep a sliding window of recent turns + extracted entities.
- **Per-user conversation memory** — last N messages + persisted entities (program, generation) so "¿y el precio?" resolves with context. This mirrors the reference PoC's `current_intent` + entity tracking, now per-user at scale.
- **Concurrency primitives** — async I/O (FastAPI/uvicorn), a connection pool to the store, bounded request queues.
- **Backpressure** — when the model queue is full, reject/prioritise/queue; don't let latency go unbounded. Use a queue (Celery/RQ/Redis Streams) for bursts.
- **Rate limiting** — per-user + global (token bucket); protects the model budget and fairness.
- **Isolation guarantee** — never share KV-cache or prompt context across users; the only shared state is the model weights.
- **Idempotency** — retries (common on flaky networks) must not duplicate side-effects (sending a Telegram message twice).

## Mental model (architectural mindset)

This is a classic stateful-session-on-stateless-workers pattern (same as web app sessions). The model is a pure function `f(history, message) -> reply`; your job is to feed each user the right `history` fast and concurrently, and to shed load before the queue destroys latency. Design for: isolation, bounded queues, graceful degradation (escalate to "please wait" / human), and observability per conversation.

## Links

- [Redis — session store patterns](https://redis.io/docs/use-cases/session-management/) — the standard hot-context store.
- [FastAPI concurrency (Sebastián Ramírez)](https://fastapi.tiangolo.com/async/) — async serving.
- [Token bucket rate limiting (Cloudflare)](https://blog.cloudflare.com/counting-things-a-lot-of-different-things/) — rate limiting at scale.
- [Little's Law (queueing intuition)](https://en.wikipedia.org/wiki/Little%27s_law) — why queue depth = arrival × wait.

## Related
- [[stateful-serving-patterns]], [[05-Chatbot-Engineering/conversation-state-context]], [[05-Chatbot-Engineering/chatbot-architecture-patterns]]
