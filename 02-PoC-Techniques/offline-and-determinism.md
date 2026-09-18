---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, determinism, offline, reproducibility]
---

# Offline operation & determinism

> A routing decision must be reproducible bit-for-bit. No network, fixed seeds, deterministic tie-breaks.

## Wide picture

For a chatbot that gives approved answers, non-determinism is a bug: the same question must route the same way every time. The POC enforces this hard: offline flags before any model import, `local_files_only=True`, fixed torch seeds, CPU, `eval()` mode, one text per forward pass (so a vector never depends on its batch), read-only cached vectors, and name-based tie-breaking. Tests prove it by blocking sockets during load and checking decision digests across runs.

## Essentials

- **Offline flags** — `HF_HUB_OFFLINE=1`, `TRANSFORMERS_OFFLINE=1`, telemetry-off, set **before** importing `sentence_transformers`.
- **`local_files_only=True`** — model loads from the vendored `models/` dir, never the network.
- **Fixed seeds + CPU + `eval()`** — no dropout, no stochasticity.
- **One text per forward pass** — embeddings don't depend on batch composition.
- **Read-only cache + name-based tie-break** — identical inputs → identical outputs.
- **Determinism digest** — hash the decision sequence; three runs produce identical digests.
- **Why it matters** — eval is meaningless without it; production answers must be auditable.
- **In the codebase:** `knowledge/embeddings.py`, `routing/semantic.py`, tests block `socket` to prove offline.

## Mental model (SWE angle)

Reproducibility is the "pure function" property for ML: same inputs + same env → same outputs. Treat the routing decision as a pure function of (message, session, model). Anything that breaks that (network, RNG, batching order) is a side effect to eliminate.

## Links

- [HuggingFace — Offline mode docs](https://huggingface.co/docs/transformers/installation#offline-mode) — the flags used.
- [The Reproducibility Crisis (Joelle Pineau)](https://www.cs.mcgill.ca/~jpineau/ReproducibilityCrisis.pdf) — why this matters at scale.

## Related
- [[evaluation-harness]], [[06-MLOps-Caveats/reproducibility-determinism]], [[embeddings-and-sentence-transformers]]
