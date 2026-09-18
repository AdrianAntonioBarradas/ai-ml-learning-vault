---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, cost, latency, throughput, slo]
---

# Cost, latency & throughput

> The three corners of the inference triangle; you optimise two at the expense of the third.

## Wide picture

Every inference design trades off **cost** ($/token or $/GPU-hour), **latency** (time to first token + time per token), and **throughput** (tokens/sec aggregate). Knowing the vocabulary and which metric your product is sensitive to is the core of an architectural mindset for AI.

## Essentials

- **TTFT (time to first token)** — prefill latency; what the user feels as "it started." Sensitive to prompt length + prefill compute.
- **ITL (inter-token latency) / TPOT** — decode speed; the typing pace.
- **Throughput** — tokens/sec across all concurrent users; drives cost-per-token on self-hosted.
- **Cost models:**
  - Hosted: `cost = (in_tokens × in_rate) + (out_tokens × out_rate)`; cached input cheaper.
  - Self-hosted: `cost ≈ GPU_hour_rate × hours`; utilisation is king (empty GPUs still cost).
- **Concurrency vs latency** — more concurrent requests raise throughput but, past saturation, latency blows up (Little's Law: `L = λ × W`).
- **The triangle:** cheaper model → lower cost, maybe worse quality; bigger batch → better throughput, worse per-request latency; streaming → better perceived latency, same total cost.
- **SLO framing** — set budgets: "p95 TTFT < 800ms, p95 ITL < 50ms, cost < $X/1k sessions."

## Mental model (architectural mindset)

Measure before optimising. Instrument TTFT, ITL, throughput, and $/session. Most "slow LLM" problems are prefill (long prompts) or queueing (overloaded replicas), not the model — and the fix is often prompt caching, routing, or capacity, not a bigger GPU.

## Links

- [LLM inference economics (HuggingFace)](https://huggingface.co/blog/optimize-llm) — cost + latency levers.
- [LLM-Perf benchmark (Ray)](https://www.anyscale.com/blog/) — real TTFT/throughput numbers.
- [Little's Law](https://en.wikipedia.org/wiki/Little%27s_law) — the queueing intuition you need.

## Related
- [[batching-caching-scaling]], [[monitoring-observability]], [[08-Consulting-and-Architecture/architectural-mindset]]
