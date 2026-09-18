---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, self-hosted, vllm, ollama, llama-cpp]
---

# Self-hosted inference servers

> You run the weights on your own GPUs/CPUs; full control, data stays in, you carry the ops.

## Wide picture

Once usage or privacy justifies it, you run an open-weight model on your own infra. The serving software matters as much as the model: it handles batching, KV-cache, quantisation, and concurrency. The landscape is dominated by a few engines optimised for throughput (vLLM, TGI) and a few for local/edge simplicity (Llama.cpp, Ollama).

## Essentials

- **vLLM** — high-throughput, PagedAttention, continuous batching; the de-facto default for GPU serving. OpenAI-compatible API.
- **TGI (Text Generation Inference, HF)** — production server from Hugging Face; optimised, supports many models.
- **Llama.cpp** — C++ inference, CPU + GPU, GGUF quantised models; great for local/single-user and edge.
- **Ollama** — friendly wrapper over Llama.cpp; `ollama run llama3`. Ideal for dev/local and small deployments.
- **SGLang** — newer, fast, structured-output-friendly; competing with vLLM on throughput.
- **Open weights you'd serve:** Llama, Qwen, Mistral, Gemma — see [[04-LLM-Tooling/model-standardization]].
- **Ops you take on:** GPU capacity, autoscaling, model loading, versioning, monitoring — see [[monitoring-observability]].

## Mental model (architectural mindset)

Self-hosting trades OpEx (per-token API) for CapEx (GPU rental/purchase) + ops labour. Break-even is a function of steady traffic; bursty/low traffic favours hosted. The serving engine is your "application server" — pick it for throughput, API compatibility, and ops maturity.

## Links

- [vLLM docs](https://docs.vllm.ai/) — the default GPU server.
- [Ollama](https://ollama.com/) — simplest local serving.
- [Text Generation Inference](https://huggingface.co/docs/text-generation-inference) — HF's production server.
- [SGLang](https://github.com/sgl-project/sglang) — high-throughput + structured outputs.

## Related
- [[serving-runtimes]], [[quantization-edge]], [[batching-caching-scaling]], [[hosted-model-apis]]
