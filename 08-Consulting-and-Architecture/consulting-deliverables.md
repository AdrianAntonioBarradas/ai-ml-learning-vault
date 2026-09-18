---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [consulting, deliverables, scoping]
---

# Consulting deliverables

> What you actually hand over: a scoped plan, a POC, an honest estimate, and managed expectations.

## Wide picture

As a consulting engineer, the deliverable is rarely "the code" — it's a clear scope, a feasibility proof, an honest estimate with ranges, and expectations calibrated to reality. Over-promising on AI is the classic failure; the discipline is to tie every promise to a measurable gate.

## Essentials

- **Scoping doc** — problem statement, success metrics, in/out of scope, constraints, assumptions. Sign-off before build.
- **POC with gates** — prove the riskiest assumption first; define acceptance thresholds; choose the simplest approach that passes. See [[heavy-ai-vs-simple]].
- **Estimates as ranges** — "2–3 weeks for POC, 10–15 for pilot" with assumptions stated; never a single number.
- **Expectation management** — be explicit about what AI can't do (no clinical advice, no cert decisions); set fallback/escalation expectations.
- **Decision log** — record architectural choices + their tradeoffs (ties to [[architectural-mindset]]).
- **Handoff artifacts** — runbook, dashboards, golden tests, content governance — not just code.
- **Honesty about limits** — surface [[06-MLOps-Caveats/MOC-MLOps-Caveats]] risks up front; clients trust engineers who name the failure modes.

## Mental model

The consulting deliverable is *de-risked decision support*: you give the client enough to decide, prove, and operate — with the risks named. Code is one artifact among several.

## Links
- [Eugene Yan — ML project lifecycle](https://eugeneyan.com/machine-learning-system-design/) — scoping + delivery.

## Related
- [[problem-framing]], [[architectural-mindset]], [[consulting-deliverables]]
