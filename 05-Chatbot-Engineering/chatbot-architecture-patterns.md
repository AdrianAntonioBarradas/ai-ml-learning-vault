---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [chatbot, architecture]
---

# Chatbot architecture patterns

> Channel adapter → conversation engine → router → retriever → policy, with the LLM optional and last.

## Wide picture

A robust information chatbot is a layered pipeline, not "an LLM with a prompt." The reference PoC plan already specifies this. The layers: a **channel adapter** (Telegram/WhatsApp) that only handles transport; a **conversation engine** holding session state; a **policy/safety gate** that runs first; an **intent router** choosing the workflow; a **retriever** fetching approved content; an **optional constrained LLM** composing the answer; and **human handoff** on low confidence. The discipline: the LLM is never the source of truth.

## Essentials

- **Channel adapter** — webhook, message normalisation, buttons, retries, rate limits. Channel-neutral core.
- **Conversation engine** — session state, entity tracking, context inheritance (see [[conversation-state-context]]).
- **Policy gate (first)** — sensitive topics escalate before any routing/generation (see [[guardrails-safety-policy]]).
- **Router** — rules / classifier / semantic / hybrid; picks the workflow (see [[intent-routing-design]]).
- **Retriever** — fetch approved FAQ/program records (see [[retrieval-and-grounding]]).
- **Composer (optional)** — LLM reformats retrieved facts; grounded only; reject if no sources.
- **Escalation** — low confidence, sensitive, unsupported → human (see [[human-handoff-escalation]]).
- **Separation principle** — routing ≠ retrieval ≠ generation. Separation improves safety, observability, testing.

## Mental model (architectural mindset)

This is a request pipeline with an ML/LLM stage as one component behind deterministic gates. The deterministic layers (policy, routing thresholds, retrieval checks) are your safety margins. The more you can keep deterministic, the more reliable the bot.

## Links

- [Eugene Yan — LLM systems design](https://eugeneyan.com/machine-learning-system-design/) — patterns.
- [Chip Huyen — Building LLM apps](https://huyenchip.com/2024/03/14/ai-oss.html) — architecture pragmatics.

## Related
- [[intent-routing-design]], [[guardrails-safety-policy]], [[02-PoC-Techniques/clean-architecture-protocols]]
