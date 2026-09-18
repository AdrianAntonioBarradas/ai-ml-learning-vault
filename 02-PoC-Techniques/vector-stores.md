---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [poc, vector-store, caching]
---

# Vector stores & embedding cache

> Store embeddings once, search by similarity. Cache aggressively — re-encoding is pure waste.

## Wide picture

A vector store holds `(text, vector, metadata)` and supports nearest-neighbour search by cosine/euclidean distance. For small corpora (your ~47 FAQ entries) an in-memory NumPy index is enough — no external DB needed. The POC's `EmbeddingCache` avoids recomputing vectors: each text's vector is computed once and stored read-only, keyed by SHA-256 of `namespace + text`.

## Essentials

- **In-memory index** — fine up to a few thousand items; brute-force cosine is fast enough.
- **ANN at scale** — FAISS, HNSW (Chroma/Qdrant/pgvector) for millions of vectors.
- **Embedding cache** — keyed by `SHA-256(model_dir + text)` so caches from different models never collide; reports `hits/misses/stores/hit_rate`.
- **Batch embedding** — intent prototypes embedded in one batch at construction; routing only embeds the incoming message.
- **The vector index is NOT the system of record** — the approved FAQ store is. Vectors are a search index you can rebuild.
- **In the codebase:** `src/chatbot/knowledge/vector_store.py`, embedding cache (`content/embedding_cache.py`) with optional `.npz` persistence.

## Mental model (applied-maths angle)

A vector store is a data structure for approximate nearest-neighbour queries in ℝᵈ. The cache is just a memoisation table keyed by a content hash of the input — correctness doesn't depend on model identity as long as the namespace is unique.

## Links

- [FAISS — similarity search docs](https://faiss.ai/) — the standard ANN library.
- [Vector databases landscape (Eugene Yan)](https://eugeneyan.com/start-here/) — when to use which.
- [pgvector](https://github.com/pgvector/pgvector) — vectors inside Postgres (pragmatic default).

## Related
- [[embeddings-and-sentence-transformers]], [[rag-retrieval-augmented-generation]], [[semantic-routing-embeddings]]

## Index choice, when you get to a real store

- **pgvector** keeps structured rows and vectors in one system, which is often worth more than raw ANN speed.
- **HNSW** — graph index: best recall/latency, higher memory and slower to build. The default for read-heavy work.
- **IVFFlat** — inverted lists: cheaper to build, tune `lists` at build time and `probes` at query time; recall degrades if the data shifts after training.
- **Exact search is underrated at small scale.** A brute-force cosine over a few thousand vectors is sub-millisecond, exact, has no build step and no recall cliff. Reach for ANN when the corpus outgrows memory, when several processes must share the index, or when it has to survive a restart.
- Sizing the process that holds the vectors: [[03-Inference-Deployment/embedding-models-in-small-containers]].
