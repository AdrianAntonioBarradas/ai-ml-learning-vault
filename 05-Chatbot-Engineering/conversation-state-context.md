---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [chatbot, state, context, sessions]
---

# Conversation state & context

> Carry the right context per conversation: entities, pending questions, last intent — isolated per user.

## Wide picture

Conversational coherence comes from state: which program the user is asking about, whether a V-type question is pending, what the last intent was. The reference PoC keeps this in a session; at scale it lives in an external store keyed by user/conversation. The design rule: keep minimal, useful state; inherit it for short replies; never leak it across users.

## Essentials

- **Session state** — `current_intent`, extracted entities (program, generation), pending V-type question, recent turns.
- **Short-reply inheritance** — "sí"/"ese"/"ok" reuse `current_intent`; don't route them standalone.
- **Entity carryover** — "¿y el precio?" uses the program established earlier in the session.
- **Per-user isolation at scale** — context keyed by `user_id + conversation_id` in Redis; see [[03-Inference-Deployment/multi-user-context-concurrency]].
- **Sliding window** — last N turns in hot storage; full transcript in durable storage.
- **Context expiration** — TTL sessions so abandoned contexts don't accumulate.
- **State ≠ history dump** — don't stuff unbounded history into the prompt; summarise + retrieve.

## Mental model (SWE angle)

Conversation state is a small per-session object with explicit fields, not "all prior messages." Treat it like a form the user is filling out; track the fields, inherit them, and expire the form when idle.

## Links

- [Redis session patterns](https://redis.io/docs/use-cases/session-management/) — hot context store.

## Related
- [[03-Inference-Deployment/multi-user-context-concurrency]], [[intent-routing-design]], [[02-PoC-Techniques/semantic-routing-embeddings]]
