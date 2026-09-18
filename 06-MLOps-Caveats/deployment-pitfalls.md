---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, deployment, serving, pitfalls]
---

# Deployment pitfalls

> Serving a model is a different engineering problem than training one.

## Wide picture

Training succeeds in a notebook; deployment fails in prod. Common failure modes: slow model load (cold starts), no autoscaling strategy, unbounded queues, no fallback when the model is down, version skew between model and code, and treating the LLM as infallible. Each has a known fix; ignoring them causes outages.

## Essentials

- **Cold start** — model load is slow (seconds to minutes); keep warm pools / min replicas; don't scale-to-zero for latency-sensitive paths.
- **No fallback** — when the model/API errors, the user gets nothing. Always have a deterministic fallback + graceful degradation.
- **Queue blow-up** — unbounded request queues → latency explodes (Little's Law). Bound the queue; reject early.
- **Version skew** — model weights, prompt template, and client code must version together; a mismatch silently breaks behavior.
- **No canary/rollback** — ship 100% on first deploy = brave. Canaries + instant rollback are table stakes.
- **Cost surprises** — no per-token budgeting ⇒ a loop or a spammer bankrupts you. Rate-limit + budget.
- **Context leakage** — shared state across users (see [[03-Inference-Deployment/multi-user-context-concurrency]]).
- **Inference ≠ training configs** — sampling params, max tokens, stop sequences must be pinned and logged.

## Mental model (SWE angle)

Treat model serving like any stateful service: capacity planning, graceful degradation, canaries, rollback, budgets, SLOs. The model is the flakiest dependency — design the system to survive its failure.

## Links

- [Chip Huyen — ML systems design](https://huyenchip.com/ml-interviews-book/) — serving pitfalls.
- [Google — MLOps maturity](https://cloud.google.com/architecture/ml-ops) — deployment practices.
- [[03-Inference-Deployment/monitoring-observability]] — seeing failures.

## Related
- [[03-Inference-Deployment/batching-caching-scaling]], [[cost-and-latency-tradeoffs]], [[common-mlops-issues]]
