---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, quantization, edge, gguf, onnx]
---

# Quantization & edge inference

> Shrink the model so it fits where you can't fit a GPU: laptops, phones, embedded.

## Wide picture

Quantisation reduces the precision of model weights (FP16 → INT8/INT4) to cut size, memory, and latency at a modest quality cost. It is what makes open LLMs runnable on consumer hardware and edge devices. The formats and the runtimes are coupled: GGUF for Llama.cpp, ONNX for cross-platform, GPTQ/AWQ for GPU, bitsandbytes for easy training/inference.

## Essentials

- **GGUF** — the Llama.cpp format; k-quants (Q4_K_M etc.); the standard for CPU/Mac/local LLMs.
- **GPTQ / AWQ** — post-training INT4 quantisation for GPU serving; AWQ generally better quality-preserving.
- **bitsandbytes** — easy 8/4-bit for training + inference (QLoRA relies on it).
- **ONNX Runtime** — cross-framework, cross-platform (CPU/GPU/mobile); good for non-LLM models + some LLMs.
- **Float16 / BF16** — the baseline precision for most LLM serving; quantise below this only when you must.
- **Quality tradeoff** — INT4 ≈ small quality loss, big size win; measure on your task, don't assume.
- **On-device** — mobile (Core ML, ML Kit, TFLite), browser (WebGPU/WebLLM); see [[09-Web-to-Components/ai-assisted-frontend]] for browser LLMs.

## Mental model (applied-maths angle)

Quantisation is a low-rank/low-precision approximation of the weight matrix; the error it introduces is bounded and task-dependent. The art is choosing the precision that keeps task error below your tolerance while maximising the size/latency win.

## Links

- [GGUF & quantisation (Llama.cpp wiki)](https://github.com/ggerganov/llama.cpp) — the GGUF ecosystem.
- [AWQ paper (Lin et al.)](https://arxiv.org/abs/2306.00978) — activation-aware quantisation.
- [ONNX Runtime](https://onnxruntime.ai/) — cross-platform inference.
- [WebLLM](https://webllm.mlc.ai/) — LLMs in the browser via WebGPU.

## Related
- [[04-LLM-Tooling/model-standardization]], [[self-hosted-servers]], [[cost-latency-throughput]]
