---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, hosted, api, serverless]
---

# Hosted model APIs

> Someone else runs the GPUs; you pay per token.

## Wide picture

The default starting point. You call an HTTP API; the provider handles model weights, scaling, uptime, and capacity. It is the fastest path to a working product and the right choice until usage justifies the ops burden of self-hosting. The tradeoff is per-token cost that scales linearly and data leaving your boundary.

## Essentials

- **Proprietary frontier APIs:** OpenAI, Anthropic, Google Gemini, Cohere. Best quality, pay-per-token, rate limits.
- **Open-weight hosted:** HF Inference API, Together, Fireworks, Groq, OpenRouter — serve open models (Llama, Qwen) per-token.
- **Serverless endpoints:** AWS Bedrock, Azure OpenAI, GCP Vertex — hosted models inside a cloud you already use (compliance, IAM, billing integration).
- **The OpenAI-compatible API** is the de-facto standard most providers mimic — see [[04-LLM-Tooling/model-standardization]].
- **Cost model:** `price = input_tokens × in_rate + output_tokens × out_rate` (cached input often discounted).
- **When to leave:** monthly API bill exceeds amortised self-host cost; or privacy/latency demands it.

## Mental model

Hosted = OpEx with zero fixed cost and no ops. It is almost always the right first move; revisit when the bill hurts or constraints bite.

## Links

- [OpenAI API docs](https://platform.openai.com/docs/api-reference) — the de-facto API shape.
- [HuggingFace Inference API](https://huggingface.co/docs/api-inference) — open-model hosted inference.
- [OpenRouter](https://openrouter.ai/) — one API, many providers (good for A/B and fallback).

## Related
- [[inference-api-architectures]], [[cost-latency-throughput]], [[08-Consulting-and-Architecture/cloud-selection]]
