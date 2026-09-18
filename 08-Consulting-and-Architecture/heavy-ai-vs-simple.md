---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [consulting, architecture, decision-guide]
---

# Heavy AI vs simple

> The core consulting intuition: reach for LLM/ML only when simpler approaches can't meet the bar.

## Wide picture

Not every problem needs AI. The cheapest, most reliable solution that meets the quality threshold is the right one — this is exactly the philosophy of the PoCs in [[02-PoC-Techniques/MOC-PoC-Techniques]] (rules → classifier → semantic → RAG, choose the simplest that passes). The decision is a ladder: try the rung below first; climb only when the lower rung fails evaluation.

## The ladder (cheapest → heaviest)

1. **Static content / menus** — fixed answers, buttons. Zero AI. Best for repetitive high-value FAQs (payment, certification).
2. **Keyword / rules** — explicit matching. Predictable, no hallucination. (Your rules POC.)
3. **Search / retrieval (no generation)** — find the right FAQ/document, show it. Often *enough*; no LLM needed. (Your RAG-no-LLM variant.)
4. **Classical ML** — TF-IDF + classifier, embeddings + nearest-neighbor. Cheap, offline, auditable. (See the classifier/semantic PoCs.)
5. **Constrained LLM composition** — LLM rewrites retrieved facts, grounded only. Add only where it measurably helps. (Your hybrid RAG, Gate 4.)
6. **Autonomous LLM agent** — model decides actions/tools. Most powerful, most fragile/costly. Use only when the task truly demands flexibility.

## When to climb
- Lower rung fails the acceptance thresholds on the golden set.
- The task has genuine open-ended language the lower rungs can't parse.
- Flexibility/adaptivity is itself the product value.

## When to stay low
- High-stakes/sensitive answers (predictability > fluency).
- Bounded, stable content (FAQ, catalog).
- Low traffic / tight budget (LLM cost not justified).
- Audit/compliance requirements.

## Mental model (architectural mindset)

Every rung up buys flexibility and loses predictability/cost/auditability. Default to the lowest rung that meets the bar; treat the LLM as a last-resort composition layer behind deterministic gates, not as the brain.

## Links

- [Eugene Yan — ML system design](https://eugeneyan.com/machine-learning-system-design/) — when ML helps.

## Related
- [[05-Chatbot-Engineering/chatbot-architecture-patterns]], [[cost-and-latency-tradeoffs]], [[problem-framing]]
