---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, routing, rules]
---

# Rules / keyword routing

> Deterministic baseline: explicit rules and keyword matching. Predictable, cheap, no hallucinations.

## Wide picture

The simplest routing approach: match keywords or rules to a fixed response. It is the baseline every other approach must beat. It cannot handle paraphrase, but for high-value repetitive FAQs (payment, certification, handoff) its predictability is a feature, not a limitation. The reference PoC uses it as the rules baseline (`just run-cli rules`).

## Essentials

- **Keyword / substring matching** on normalised text; fixed responses per match.
- **Strengths:** 100% predictable, zero hallucination, trivial to test, cheapest to run.
- **Weaknesses:** brittle to phrasing, no paraphrase recall, hard to scale to many variants.
- **Best use:** high-priority repetitive FAQs, sensitive flows, policy/payment/certification, human-handoff triggers.
- **In the codebase:** `src/chatbot/routing/rules.py`; same `IntentRouter` protocol as the other routers.

## Mental model

This is the "write the rules by hand" end of the ML spectrum — no learning. Keep it as the safety baseline: if a learned router does not clearly beat it on the golden set, ship rules.

## Links

- [Heuristic vs ML — when to use rules](https://eugeneyan.com/machine-learning-system-design/) — decision framing.

## Related
- [[tfidf-logistic-regression]], [[semantic-routing-embeddings]], [[clean-architecture-protocols]]
