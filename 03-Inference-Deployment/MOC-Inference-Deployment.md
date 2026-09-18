---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [moc, inference, deployment, serving]
---

# MOC — Inference & deployment

The industry digest: how inference systems are actually deployed. From hosted APIs to self-hosted servers to edge, plus the API architectures (SSE/webhooks/WebSocket) and the multi-user concurrency problem (your CRM chatbot scenario).

## Patterns & runtimes
- [[deployment-patterns-overview]] — the decision tree: hosted vs self-hosted vs edge vs hybrid.
- [[hosted-model-apis]] — OpenAI/Anthropic/Gemini, HF Inference API, serverless.
- [[self-hosted-servers]] — vLLM, TGI, Llama.cpp, Ollama.
- [[serving-runtimes]] — NVIDIA Triton, KServe, BentoML, Ray Serve.
- [[quantization-edge]] — GGUF, AWQ, GPTQ, bitsandbytes, on-device.
- [[embedding-models-in-small-containers]] — measured ONNX memory profile; why a 220 MB model needs ~700 MB of RAM.
- [[batching-caching-scaling]] — continuous batching, KV-cache, autoscaling, prefill/decode split.

## API architectures & concurrency (your specific asks)
- [[inference-api-architectures]] — REST vs SSE vs webhooks vs WebSocket vs gRPC streaming; async batch jobs.
- [[streaming-responses]] — token streaming via SSE, how chat UIs consume it.
- [[multi-user-context-concurrency]] — CRM chatbot scenario: per-user session isolation, Redis/context stores, conversation memory per user, pooling, queueing/backpressure, rate limiting.
- [[stateful-serving-patterns]] — how serving systems keep context across parallel queries.

## Economics & operations
- [[cost-latency-throughput]] — tokens/s, TTFT, ITL, $/1M tokens; the tradeoff triangle.
- [[monitoring-observability]] — metrics, traces, drift, SLOs for inference.

## Related
- [[04-LLM-Tooling/model-standardization]] — the formats/protocols that make deployment portable.
- [[06-MLOps-Caveats/deployment-pitfalls]] — what goes wrong.
- [[08-Consulting-and-Architecture/heavy-ai-vs-simple]] — when you even need to serve a model.
