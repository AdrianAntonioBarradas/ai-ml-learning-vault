---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, batching, kv-cache, scaling]
---

# Batching, caching & scaling

> The levers that turn a slow model into a cheap, fast service.

## Wide picture

Naive one-request-at-a-time serving wastes the GPU. Real inference servers squeeze throughput with three techniques: **continuous batching** (add/remove requests from a batch mid-flight), **KV-cache** (don't recompute past tokens), and **prefill/decode disaggregation** (separate the expensive first-token pass from cheap continuations). Scaling then layers on autoscaling, replication, and load balancing.

## Essentials

- **KV-cache** — cache the key/value tensors of processed tokens so each new token only attends to cached state; the core LLM speedup.
- **Continuous batching** (vLLM, TGI) — dynamic batch membership; requests join/leave between steps; huge throughput vs static batching.
- **PagedAttention** — vLLM's memory management for the KV-cache (like virtual memory paging); reduces fragmentation.
- **Prefill vs decode** — prefill (prompt processing) is compute-bound; decode (generation) is memory-bound. Splitting them (P/D disaggregation) lets you scale each separately.
- **Speculative decoding** — a small model drafts, the big model verifies; lower latency at same quality.
- **Autoscaling** — scale GPU replicas on latency/queue depth; watch cold-start (model load is slow).
- **Caching at higher layers** — prompt caching (OpenAI/Anthropic), semantic cache for repeated questions (relevant to chatbots).

## Mental model (applied-maths angle)

Throughput optimisation is a scheduling + memory problem. Continuous batching maximises GPU utilisation by keeping the batch full; PagedAttention is memory virtualisation applied to the KV-cache; P/D split separates two regimes with different bottleneck resources.

## Links

- [vLLM — PagedAttention paper](https://arxiv.org/abs/2309.06180) — the core idea.
- [Continuous batching (AnyScale)](https://www.anyscale.com/blog/continuous-batching-llm-inference) — explained.
- [DistServe (P/D disaggregation)](https://arxiv.org/abs/2401.09670) — prefill/decode split.
- [Speculative decoding](https://arxiv.org/abs/2302.01318) — draft + verify.

## Related
- [[self-hosted-servers]], [[cost-latency-throughput]], [[monitoring-observability]]
