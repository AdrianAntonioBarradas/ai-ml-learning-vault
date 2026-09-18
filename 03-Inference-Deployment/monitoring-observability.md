---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, observability, monitoring, slo]
---

# Monitoring & observability for inference

> You can't run what you can't see: latency, errors, cost, and output quality must all be instrumented.

## Wide picture

Inference systems degrade in ways traditional services don't: latency is long-tailed, cost accrues per token, and the *output* can be wrong without any error code. Observability spans the usual infra metrics plus LLM-specific signals (token usage, refusal rate, groundedness, hallucination indicators).

## Essentials

- **Infra metrics:** TTFT, ITL, error rate, queue depth, GPU utilisation, replica count, OOMs.
- **Business metrics:** $/session, escalation rate, human-handoff rate, CSAT, task completion.
- **Quality signals:** refusal/empty-answer rate, retrieval hit rate, groundedness (is the answer in the sources?), hallucination flags.
- **Distributed tracing** — trace each conversation across adapter → router → retriever → model → policy; essential for debugging latency.
- **Logging** — log the *decisions* (intent, confidence, retrieved IDs), not raw PII. The reference PoC logs scores + selected route + answer ID — extend that pattern to prod.
- **Alerts/SLOs** — p95 latency, error budget burn, cost budget burn, escalation-rate spike.
- **Dashboards** — per-conversation traces + aggregate trends; golden-set regression in CI.

## Mental model (SWE angle)

Treat the model like any external dependency: instrument it, trace it, budget it. The extra dimension is *output quality* — add eval signals (groundedness, refusal rate) as pseudo-metrics alongside latency/cost.

## Links

- [OpenTelemetry — LLM semantic conventions](https://opentelemetry.io/docs/specs/semconv/gen-ai/) — standard LLM tracing attributes.
- [Arize Phoenix](https://phoenix.arize.com/) — LLM observability.
- [Langfuse](https://langfuse.com/) — tracing + eval for LLM apps.

## Related
- [[cost-latency-throughput]], [[06-MLOps-Caveats/MOC-MLOps-Caveats]], [[02-PoC-Techniques/evaluation-harness]]
