---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, checklist, issues]
---

# Common MLOps issues (consolidated)

> The recurring pain of AI/ML Ops engineering, as a checklist. Skim before a design review or an incident.

## The recurring issues

- **Unversioned data/model/env** → unreproducible bugs. *Fix: pin + log everything.*
- **No reproducible eval** → can't tell if a change helped. *Fix: frozen golden set + determinism digests.*
- **Hallucinated answers shipped** → trust loss. *Fix: grounding gates, refuse when retrieval weak, faithfulness checks.*
- **Stale content served** → wrong prices/dates. *Fix: freshness SLA, link validation, expiry detection.*
- **Prompt injection** → model obeys attacker. *Fix: deterministic policy gate, least-privilege tools, output checks.*
- **Runaway cost** → bill shock. *Fix: per-session budget, routing ladder, prompt/semantic caching, rate limits.*
- **Latency blow-ups** → slow UX. *Fix: streaming, bounded queues, warm pools, prompt caching.*
- **Cross-user context leak** → privacy/UX bug. *Fix: per-session keyed state, never share KV-cache across users.*
- **Model/API outage, no fallback** → outage. *Fix: deterministic fallback + human handoff.*
- **Drift undetected** → silent rot. *Fix: monitor confidence/escalation distributions + scheduled re-eval.*
- **Cold-start kills latency** → first requests slow. *Fix: min replicas, warm pools, preloaded models.*
- **"Just add an LLM" overuse** → cost/latency/fragility. *Fix: heavy-AI-vs-simple decision guide ([[08-Consulting-and-Architecture/heavy-ai-vs-simple]]).*
- **Prompt as untested code** → prompt changes regress silently. *Fix: prompt versioning + eval on every change.*
- **LLM nondeterminism unhandled** → flaky behavior. *Fix: temperature 0 for factual paths; log all params.*
- **No observability** → can't debug. *Fix: per-conversation traces + token/cost/quality metrics.*

## How to use this list

- Before architecting: use it as a design checklist (which of these am I handling?).
- During incidents: use it as a hypothesis list (which of these is the cause?).
- In review: use it as a gate (no PR ships without addressing the relevant items).

## Related
- [[MOC-MLOps-Caveats]] — the detailed notes behind each item.
- [[02-PoC-Techniques/evaluation-harness]] — the testing antidote.
- [[08-Consulting-and-Architecture/architectural-mindset]] — the mindset that prevents most of these.
