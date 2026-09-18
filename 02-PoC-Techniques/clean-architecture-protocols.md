---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, architecture, clean-code, pydantic, protocols]
---

# Clean architecture & protocols

> One `IntentRouter` protocol; four interchangeable implementations; shared engine + eval harness.

## Wide picture

The POC is structured so the four routing approaches are **plug-replaceable**: they all implement the same `IntentRouter` protocol and plug into a shared `ConversationEngine`, CLI, and evaluation harness. Domain models are Pydantic (`RouteDecision`, entities, FAQ records); dependencies point inward (domain has no framework imports). This is what lets you benchmark apples-to-apples and swap a router without touching the engine.

## Essentials

- **Protocol-based interfaces** — `domain/protocols.py` defines `IntentRouter`; rules/classifier/semantic/rag all implement it.
- **Pydantic domain models** — typed, validated data (`domain/models.py`); entities, decisions, FAQ rows.
- **Dependency inversion** — the engine depends on the protocol, not on concrete routers.
- **Channel-neutral core** — `channels/cli.py` (and future `telegram.py`) are thin adapters; the conversation API doesn't know the channel.
- **Separation of concerns** — routing / retrieval / policy / conversation state are distinct modules.
- **In the codebase:** `src/chatbot/domain/{protocols,models}.py`, `conversation/engine.py`, `channels/cli.py`.

## Mental model (SWE angle)

This is ports-and-adapters / hexagonal applied to an ML system: the learned components are adapters behind stable ports. The payoff is exactly what the POC demonstrates — you can A/B four ML strategies behind one interface and one test suite.

## Links

- [Ports & Adapters (Alistair Cockburn)](https://alistair.cockburn.us/hexagonal-architecture/) — the pattern.
- [Pydantic docs](https://docs.pydantic.dev/) — the validation layer used.
- [Clean Architecture in ML systems (Eugene Yan)](https://eugeneyan.com/machine-learning-system-design/) — applied.

## Related
- [[rules-keyword-routing]], [[evaluation-harness]], [[05-Chatbot-Engineering/chatbot-architecture-patterns]]
