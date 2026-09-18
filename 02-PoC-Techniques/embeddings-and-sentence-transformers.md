---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, embeddings, sentence-transformers, models]
---

# Embeddings & sentence-transformers

> Turn text into a fixed-size vector that captures meaning; load the model once, reuse offline.

## Wide picture

A sentence-transformer is a transformer fine-tuned (via contrastive learning) so that semantically similar texts map to nearby vectors. The reference PoC uses `paraphrase-multilingual-MiniLM-L12-v2` (384 dimensions) because the FAQ corpus is Spanish and the model must run **fully offline**. The `EmbeddingService` loads it once from `models/` with `local_files_only=True`, returns **unit-length** vectors, and caches them.

## Essentials

- **Bi-encoder** — each text encoded independently → a vector; similarity = cosine. Cheap at query time (unlike cross-encoders).
- **384-dim unit vectors** — normalised so cosine = dot product; fast and numerically stable.
- **Multilingual model** — covers Spanish phrasing, accents, informal register (English-only MiniLM would not).
- **Offline flags** — `HF_HUB_OFFLINE`, `TRANSFORMERS_OFFLINE`, telemetry-off set **before** import; `local_files_only=True`. See [[offline-and-determinism]].
- **Embedding cache** — vectors computed once, keyed by SHA-256(namespace+text); see [[vector-stores]].
- **Cost on this machine:** ~3.2s load, ~1.25GB peak, p50 ~0.5ms warm routing.
- **In the codebase:** `src/chatbot/knowledge/embeddings.py`; model vendored in `models/` (~450MB, gitignored), `just fetch-model` materialises it on a fresh machine.

## Mental model (applied-maths angle)

A learned map `φ: text → S³⁸³` (unit sphere). Contrastive training shapes `φ` so that `φ(a)·φ(b)` is high iff `a`, `b` mean similar things. Everything downstream (routing, retrieval) is geometry on this sphere.

## Links

- [Sentence-Transformers docs](https://www.sbert.net/) — the library used.
- [HuggingFace — Multilingual MiniLM model card](https://huggingface.co/sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2) — the exact model.
- [Illustrated Sentence Embeddings (Jay Alammar)](https://jalammar.github.io/illustrated-sentence-embeddings/) — visual intuition.

## Related
- [[semantic-routing-embeddings]], [[vector-stores]], [[offline-and-determinism]], [[04-LLM-Tooling/model-standardization]]
