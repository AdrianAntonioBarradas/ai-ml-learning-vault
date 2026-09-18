---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [moc, mlops, caveats]
---

# MOC — MLOps caveats & common issues

The limitations and recurring problems of working as an AI/ML Ops engineer. Read these before you build, not after something breaks in production.

## Notes
- [[hallucinations-and-grounding]] — why LLMs invent, and how grounding mitigates it.
- [[data-drift-model-degradation]] — models rot as the world changes; how to detect and respond.
- [[reproducibility-determinism]] — same input must give same output; the many ways it breaks.
- [[prompt-injection-security]] — user input as attack surface.
- [[cost-and-latency-tradeoffs]] — the budget triangle; runaway cost.
- [[evaluation-is-hard]] — offline metrics that lie; online metrics that lag.
- [[evaluating-your-evaluator]] — three ways a grader reports the wrong number with confidence, and how to catch them.
- [[deployment-pitfalls]] — serving, scaling, and rollout mistakes.
- [[common-mlops-issues]] — consolidated checklist of recurring pain.

## Related
- [[02-PoC-Techniques/evaluation-harness]] — the testing antidote.
- [[03-Inference-Deployment/monitoring-observability]] — seeing problems in prod.
- [[05-Chatbot-Engineering/guardrails-safety-policy]] — safety in practice.
