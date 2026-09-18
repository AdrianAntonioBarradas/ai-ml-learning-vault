---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, evaluation, testing, reproducibility]
---

# Evaluation harness

> The test suite for learned components: golden cases, metrics, thresholds, determinism, latency, memory.

## Wide picture

The POC's `evaluation/` package is the spine that makes the four routers comparable. It runs golden cases + paraphrases + Spanish variants + out-of-domain/sensitive probes, then reports per-case decisions, accuracy, calibration bins, high-confidence precision, entity-extraction accuracy, determinism digests, latency percentiles, and peak memory. This is exactly how you should test any ML component: behavior-driven, reproducible, multi-dimensional.

## Essentials

- **Golden cases** — frozen, hand-verified expected results (Phase 1 = 9 entries; Phase 2 = 47). Like unit tests.
- **Paraphrase / Spanish-variant cases** — property tests: equivalent phrasings must yield equivalent routes.
- **Threshold measurement** — measure the confidence/margin gap so you set thresholds from data, not guesses.
- **Calibration bins** — bin by confidence, report per-bin accuracy + high-confidence precision.
- **Determinism digests** — hash the decision sequence across repeated runs; identical digest = reproducible.
- **Latency (p50/p95) + peak memory** — performance budgets, not afterthoughts.
- **Probes** — out-of-domain, sensitive-topic, ambiguity, short-reply traces.
- **In the codebase:** `src/chatbot/evaluation/{runner,harness,metrics,thresholds,cases,reports,cold_start}.py`.

## Mental model (SWE angle)

An eval harness = the CI pipeline for a learned system. Golden cases = unit tests; paraphrase/variant = property tests; determinism digests = snapshot tests; latency/memory = perf budgets. Build this before you build the model.

## Links

- [Beyond Accuracy (Ribeiro et al.)](https://aclanthology.org/2020.acl-main.184/) — behavior-driven testing for NLP.
- [Eugene Yan — ML testing](https://eugeneyan.com/start-here/) — practical strategy.

## Related
- [[evaluation-metrics]], [[offline-and-determinism]], [[06-MLOps-Caveats/evaluation-is-hard]]
