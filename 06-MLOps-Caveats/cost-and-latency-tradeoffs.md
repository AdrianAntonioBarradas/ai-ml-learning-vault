---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, cost, latency, tradeoffs]
---

# Cost & latency tradeoffs

> LLM apps burn money per token and time per token; without budgets, both go unbounded.

## Wide picture

Unlike traditional services, LLM cost accrues per request in proportion to text length, and latency is dominated by sequential generation. Without explicit budgets and routing discipline, a chatbot can rack up surprising bills and sluggish UX. The mitigation is the architectural mindset: cheapest sufficient path, caching, and thresholds.

## Essentials

- **Cost drivers** — input + output tokens, model tier, frequency. Long system prompts × every call = big cost.
- **Latency drivers** — TTFT (prompt length/prefill) + generation length; queueing under load.
- **Mitigations:**
  - Route to the cheapest sufficient model (rules → classifier → small LLM → frontier LLM).
  - Prompt caching for repeated prefixes; semantic cache for repeated questions.
  - Shorter prompts; summarise context, don't dump history.
  - Streaming for perceived latency.
  - Constrain max output tokens.
- **Budgets** — $/session, $/day; alert on burn. See [[03-Inference-Deployment/cost-latency-throughput]].
- **The trap** — "just add an LLM" feels cheap in dev; in prod it's the dominant line item.

## Mental model (architectural mindset)

Cost/latency are first-class NFRs, not optimisations after launch. Decide the routing ladder (when to use which model) at design time, instrument from day one, and treat tokens like a metered utility.

## Links

- [LLM inference economics (HuggingFace)](https://huggingface.co/blog/optimize-llm) — cost + latency levers.
- [Prompt caching (Anthropic)](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching) — big win for repeated prefixes.
- [[08-Consulting-and-Architecture/heavy-ai-vs-simple]] — when to use AI at all.

## Related
- [[03-Inference-Deployment/cost-latency-throughput]], [[evaluation-is-hard]], [[common-mlops-issues]]
