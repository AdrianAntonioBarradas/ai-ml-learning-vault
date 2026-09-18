---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, reproducibility, determinism]
---

# Reproducibility & determinism

> "It worked on my machine" is unacceptable when the artifact is learned.

## Wide picture

ML reproducibility means the same data + code + config + environment → the same model and the same predictions. It breaks in many silent ways: unpinned dependencies, floating-point nondeterminism, GPU non-determinism, unlogged hyperparameters, dataset drift between runs, and (for LLMs) sampling temperature. The reference PoC invests heavily here (offline flags, fixed seeds, determinism digests) because reproducibility is the foundation of trustworthy evaluation.

## Essentials

- **Version everything** — data, code, config, model weights, environment. Pin versions.
- **Fixed seeds + deterministic ops** — and know GPU ops can still be non-deterministic unless configured.
- **Log the full config** of every training/serving run; a model without provenance is undebuggable.
- **Environment pinning** — container/lockfile (the reference PoC uses Pipfile.lock + devbox).
- **LLM nondeterminism** — temperature > 0 ⇒ varying outputs; set temperature 0 for factual routing, log all params.
- **Determinism digests** — hash decision sequences; identical digest across runs = reproducible (the reference PoC pattern).
- **Model + data lineage** — which data trained which weights served which prediction.

## Mental model (SWE angle)

Reproducibility is "pure function over (data, code, config, env)." Any unversioned input is a hidden parameter that will one day change and break things. Make every input explicit and pinned.

## Links

- [The Reproducibility Crisis in ML (Pineau)](https://www.cs.mcgill.ca/~jpineau/ReproducibilityCrisis.pdf) — why it matters.
- [DVC — data versioning](https://dvc.org/) — version data + models.

## Related
- [[02-PoC-Techniques/offline-and-determinism]], [[evaluation-is-hard]], [[data-drift-model-degradation]]
