---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, deployment, architecture]
---

# Deployment patterns overview

> Where does the model run? The answer drives cost, latency, ops burden, and privacy.

## Wide picture

There are four broad places a model can run, and the choice is an architecture decision (not a technical fashion one): **hosted APIs** (someone else runs it), **self-hosted servers** (you run it on your infra), **edge/on-device** (you ship the model to the user's device), and **hybrid** (route between them). The right choice depends on cost, latency budget, traffic shape, privacy, and how much ops you can carry.

## Essentials

- **Hosted API** — fastest to ship, pay-per-token, no GPU ops; cost scales linearly with usage; data leaves your boundary.
- **Self-hosted** — amortise cost at scale, data stays in, full control; you carry GPU ops + capacity planning.
- **Edge / on-device** — lowest latency, offline, privacy-max; model size/quality constrained; hard to update.
- **Hybrid** — e.g. cheap deterministic path locally, expensive LLM call only when needed (matches the reference PoC's escalate-only-when-needed philosophy).
- **Decision drivers:** tokens/month, p95 latency budget, privacy constraints, team ops capacity, peak vs average traffic.
- **Rule of thumb:** start hosted, move self-hosted when monthly API cost > amortised GPU cost, go edge only when latency/offline demands it.

## Mental model (architectural mindset)

This is a build-vs-buy-vs-ship decision. Hosted = buy (OpEx, low fixed cost). Self-hosted = build (CapEx, high fixed cost, low marginal). Edge = ship-the-capex-to-the-user. Match the cost structure to your traffic shape.

## Links

- [Eugene Yan — ML model serving patterns](https://eugeneyan.com/machine-learning-system-design/) — patterns surveyed.
- [Serving LLMs: choices (Hamel Husain)](https://hamel.dev/blog/posts/llm-inference/) — practical tradeoffs.
- [Chip Huyen — Designing ML Systems](https://huyenchip.com/ml-interviews-book/) — serving chapters.

## Related
- [[hosted-model-apis]], [[self-hosted-servers]], [[quantization-edge]], [[08-Consulting-and-Architecture/heavy-ai-vs-simple]]
