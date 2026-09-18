---
created: 2026-08-17
updated: 2026-09-14
last_reviewed: 2026-09-14
status: stable
tags: [moc, chatbot]
---

# MOC — Chatbot engineering

How the pieces compose into a reliable chatbot — grounded in a real FAQ-style chatbot build. The pattern the reference PoC embodies: policy gate → route → retrieve → compose (optionally) → escalate.

## Notes
- [[chatbot-architecture-patterns]] — the layered architecture (adapter → engine → router → retriever → policy).
- [[intent-routing-design]] — choosing/extracting intents, thresholds, clarification, escalation.
- [[retrieval-and-grounding]] — RAG for chatbots: chunking, citations, grounded composition.
- [[is-rag-worth-it]] — **measure the ladder before building it**: on a small corpus the pure-prompt baseline often wins.
- [[chunking-strategies]] — semantic units, self-contained text, and the granularity bug that costs you the right answer.
- [[hybrid-retrieval-and-fusion]] — dense + BM25, and why you fuse ranks rather than scores.
- [[guardrails-safety-policy]] — scope limits, sensitive-topic handling, prompt-injection defense.
- [[human-handoff-escalation]] — when and how to hand off; handoff summaries.
- [[conversation-state-context]] — session state, entity carryover, short-reply handling, per-user context at scale.
- [[chatbot-evaluation]] — golden sets, paraphrase tests, safety probes, online metrics.

## Related
- [[02-PoC-Techniques/MOC-PoC-Techniques]] — the techniques behind each layer.
- [[03-Inference-Deployment/multi-user-context-concurrency]] — serving many users.
- [[06-MLOps-Caveats/MOC-MLOps-Caveats]] — what goes wrong.
- [[06-MLOps-Caveats/evaluating-your-evaluator]] — check the harness before you trust its table.
- [[04-LLM-Tooling/open-responses-protocol]] — exposing the finished agent over a standard contract.
