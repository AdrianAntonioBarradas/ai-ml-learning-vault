---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, standardization, formats, hf-hub, onnx, gguf, safetensors]
---

# Model standardization

> Two layers of standardization: the **file format** the weights live in, and the **API protocol** clients speak to them.

## Wide picture

How is model standardization done? It happens at two levels. (1) **Weight/artifact formats** — `safetensors` (safe, fast, the HF default), `GGUF` (quantised, for Llama.cpp), `ONNX` (cross-runtime). (2) **Distribution + metadata** — the Hugging Face Hub is the de-facto distribution standard, with `config.json` (architecture), `model card` (capabilities/limits), tokenizer files, and revision pinning. (3) **Serving API protocol** — the OpenAI-compatible HTTP API is the de-facto client protocol; almost every server (vLLM, TGI, Ollama, OpenRouter) mimics it, so client code is portable.

## Essentials

- **safetensors** — secure (no arbitrary code execution like pickle), fast mmap, the default for PyTorch/HF weights.
- **GGUF** — single-file, quantised, for Llama.cpp/Ollama; includes metadata + tokenizer. The edge/local standard.
- **ONNX** — cross-framework graph format; run on ONNX Runtime (CPU/GPU/mobile). Strong for non-LLM + some LLMs.
- **Hugging Face Hub** — the distribution layer: repos, revisions (git-based), `config.json` defines architecture, `model card` documents intent/limits, `tokenizer.json` + `tokenizer_config.json` ship with the model.
- **Architecture config (`config.json`)** — `model_type`, hidden size, layers, vocab — enough to instantiate the model class. This is how a framework loads any compatible model.
- **OpenAI-compatible API** — `/v1/chat/completions`, `/v1/embeddings`; the lingua franca. Swap the `base_url` and most clients work.
- **Model cards + metadata** — license, intended use, eval numbers, known limitations — the contractual layer of standardization.

## Mental model (architectural mindset)

Standardization is what makes models **portable across providers and runtimes**. Format standardization (safetensors/GGUF) decouples weights from a framework; Hub metadata decouples instantiation from hand-coding; the OpenAI-compatible API decouples clients from servers. Bet on these standards to avoid lock-in.

## Links

- [safetensors](https://github.com/huggingface/safetensors) · [GGUF spec](https://github.com/ggerganov/ggml/blob/master/docs/gguf.md) · [ONNX](https://onnx.ai/)
- [Hugging Face Hub docs](https://huggingface.co/docs/hub) — distribution + model cards.
- [OpenAI API reference](https://platform.openai.com/docs/api-reference) — the de-facto serving protocol.

## Related
- [[tokenizer-standardization]], [[03-Inference-Deployment/self-hosted-servers]], [[03-Inference-Deployment/quantization-edge]]
