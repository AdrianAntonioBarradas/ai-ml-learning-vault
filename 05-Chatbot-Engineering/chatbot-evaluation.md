---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [chatbot, evaluation, testing]
---

# Chatbot evaluation

> Test behavior, not just outputs: golden cases, paraphrases, safety probes, and online metrics.

## Wide picture

A chatbot is tested like the POC's evaluation harness but extended to full journeys: golden cases per FAQ, paraphrase/Spanish-variant consistency, complete conversation journeys (discover → cost → enroll → escalate), and safety probes (injection, clinical requests). Online, you watch escalation rate, handoff actionability, CSAT, and freshness SLA.

## Essentials

- **Golden tests per FAQ ID** — every answer has expected behavior; equivalent phrasings must yield equivalent routes.
- **Journey tests** — full conversation flows + interruptions, topic changes, short replies, duplicate/rapid messages.
- **Safety/resilience tests** — injection, reveal-instructions, clinical/crisis, PII exposure, outages, rate-limit behavior.
- **Acceptance targets (your plan)** — ≥95% correct/escalate on priority golden; 100% escalation for `H` + sensitive; zero unsupported claims; ≥98% delivery; freshness 5–15 min.
- **Online metrics** — escalation rate, handoff actionability (≥95%), helpfulness ≥4/5, latency, cost/session.
- **Regression in CI** — run the golden set on every content or model change.
- **See [[02-PoC-Techniques/evaluation-harness]] for the harness pattern.**

## Mental model

Chatbot eval = integration tests for a conversational system. Golden cases are unit tests; journeys are end-to-end tests; safety probes are security tests; online metrics are your production monitors. All four layers are mandatory.

## Links

- [Beyond Accuracy (Ribeiro et al.)](https://aclanthology.org/2020.acl-main.184/) — behavior-driven testing.
- [RAGAS](https://docs.ragas.io/) — RAG/chatbot quality metrics.

## Related
- [[02-PoC-Techniques/evaluation-harness]], [[guardrails-safety-policy]], [[06-MLOps-Caveats/evaluation-is-hard]]
- [[06-MLOps-Caveats/evaluating-your-evaluator]] — the harness is code too, and a broken grader reports a plausible wrong number instead of crashing.
- [[is-rag-worth-it]] — run the same case set across retrieval modes; it is the only way to tell whether retrieval earns its place.
