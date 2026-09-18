---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, runtimes, triton, kserve, bentoml, ray]
---

# Serving runtimes & orchestration

> The layer above the model: packaging, routing, scaling, multi-model, and standardised endpoints.

## Wide picture

A serving runtime wraps a model (or several) into a deployable service with a standard API, health checks, batching, autoscaling, and often multi-framework support. You use these when you graduate from "one vLLM process" to "a fleet of models with traffic management."

## Essentials

- **NVIDIA Triton** — high-performance, multi-framework (TensorRT/PyTorch/ONNX), dynamic batching; the enterprise GPU default.
- **KServe** — Kubernetes-native, standardised "InferenceService" CRD; cloud-portable, good for standardising many models.
- **BentoML** — developer-friendly packaging + serving; ship a model as a containerised service quickly.
- **Ray Serve** — scalable, composable, great for multi-model pipelines + RL/agents; integrates with Ray.
- **TensorRT-LLM** — NVIDIA's compiled, optimised LLM runtime (often wrapped by Triton/vLLM).
- **What they add over raw vLLM:** model versioning, canary/rollout, multi-model routing, autoscaling, observability hooks.
- **When you need one:** multiple models, complex pipelines, strict rollout/rollback, or platform-style internal ML serving.

## Mental model

Raw inference servers (vLLM) are the runtime; these are the **application server / platform**. You don't need them for one model on one box; you need them when serving becomes a platform problem (many models, teams, rollout discipline).

## Links

- [NVIDIA Triton docs](https://docs.nvidia.com/deeplearning/triton-inference-server/) — enterprise serving.
- [KServe](https://kserve.github.io/website/) — K8s-native inference platform.
- [BentoML docs](https://docs.bentoml.com/) — packaging + serving.
- [Ray Serve](https://docs.ray.io/en/latest/serve/) — scalable composable serving.

## Related
- [[self-hosted-servers]], [[batching-caching-scaling]], [[08-Consulting-and-Architecture/architectural-mindset]]
