---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, drift, degradation, monitoring]
---

# Data drift & model degradation

> A model is fit on past data; the world moves; accuracy silently rots.

## Wide picture

Models degrade in production not because code changed but because the input distribution shifts: users ask new things, vocabulary evolves, business rules change (new prices/programs). Without monitoring, you discover this via user complaints, not metrics. Drift comes in flavors: **covariate drift** (inputs change), **label drift** (outcomes change), and **concept drift** (the relationship changes).

## Essentials

- **Covariate drift** — input distribution changes (new phrasings, new topics). Embedding-space monitoring catches it.
- **Label/concept drift** — the right answer changes (price updated, program retired). Content freshness + scheduled re-eval catches it.
- **Detection** — track input distributions, confidence distributions, escalation rate, fallback rate over time; alert on shifts.
- **Response** — retrain/re-index, refresh content, adjust thresholds; for LLM apps often it's content/prompt updates, not retraining.
- **The chatbot-specific case** — most "drift" in an FAQ bot is stale content, not model rot. Freshness SLAs + link validation matter most.
- **Shadow evaluation** — run the golden set on a schedule against prod; regression alerts.

## Mental model (architectural mindset)

Plan for decay at design time: instrument the signals, schedule re-eval, and make content updates cheap. A model/KB you can't refresh is one that will silently go wrong.

## Links

- [Evidently AI — Data drift concepts](https://www.evidentlyai.com/glossary/data-drift) — the canonical primer.
- [Google — ML production readiness](https://cloud.google.com/architecture/ml-ops) — monitoring patterns.

## Related
- [[evaluation-is-hard]], [[03-Inference-Deployment/monitoring-observability]], [[reproducibility-determinism]]
