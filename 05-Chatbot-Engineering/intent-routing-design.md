---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [chatbot, intent, routing]
---

# Intent routing design

> Pick the workflow from the message; reject when unsure instead of guessing.

## Wide picture

Intent routing decides *what to do* with a message before *what to answer*. The reference PoC compares four strategies (rules, classifier, semantic, hybrid). The design discipline is identical across them: bounded intents (from FAQ subtopics, not one per wording), confidence + margin thresholds, clarification on ambiguity, escalation on low confidence, and short-reply context inheritance.

## Essentials

- **Bounded intents** — derive from FAQ subtopics (cost, enrollment, certification, handoff…), not per-wording. ~20–40 is the sweet spot.
- **Confidence + margin gates** — top score below threshold → escalate; top1−top2 below margin → clarify. Set thresholds from data (see [[02-PoC-Techniques/evaluation-harness]]).
- **Short-reply inheritance** — "sí", "ese" inherit the session's current intent.
- **Policy-first** — sensitive topics escalate regardless of score.
- **Hybrid ladder** — cheapest deterministic path first; escalate to richer models only when needed (matches "heavy AI vs simple" — see [[08-Consulting-and-Architecture/heavy-ai-vs-simple]]).
- **Logging** — log score, selected route, answer ID, escalation outcome for every decision.

## Mental model

Routing is a classifier with **rejection options**. A confident-but-wrong route is worse than an honest "I'm not sure, could you clarify?" Design the rejection boundaries as carefully as the classifier.

## Links

- [Semantic Router (Zep)](https://blog.zep.ai/semantic-router/) — the pattern the reference PoC follows.

## Related
- [[02-PoC-Techniques/semantic-routing-embeddings]], [[02-PoC-Techniques/tfidf-logistic-regression]], [[guardrails-safety-policy]]
