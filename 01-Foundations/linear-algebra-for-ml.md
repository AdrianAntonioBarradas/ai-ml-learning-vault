---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, linear-algebra, embeddings]
---

# Linear algebra for ML

> Matrices are the data structure of ML; vectors are how meaning gets represented.

## Wide picture

Almost every ML model is, at the bottom, a sequence of matrix multiplications and nonlinearities. Your applied-maths background already covers this; the ML-specific reframe is: **a learned vector representation (embedding) is a point in a space where "similar" things are near each other.** That single idea underpins semantic routing, RAG retrieval, recommender systems, and modern neural nets.

## Essentials

- **Tensors** = n-dimensional arrays; a batch of token embeddings is a `(batch, seq, dim)` tensor.
- **Matrix multiply** = the primitive of every layer; GPUs are built to do it fast.
- **Embeddings** = learned projections of discrete inputs (words, items, users) into a metric vector space. Distance (cosine) ≈ semantic similarity. See [[02-PoC-Techniques/semantic-routing-embeddings]] and [[02-PoC-Techniques/embeddings-and-sentence-transformers]].
- **Rank / SVD / PCA** = dimensionality reduction, the maths behind compression and "latent factors."
- **Norms & normalisation** = unit vectors (the reference PoC normalises embeddings to unit length for cosine = dot product).

## Mental model (applied-maths angle)

An embedding model learns a map `φ: text → ℝᵈ` such that inner products approximate a target similarity. The 384-dim `paraphrase-multilingual-MiniLM` in the reference PoC is exactly this: a learned `φ` evaluated with `local_files_only=True`, then cosine (dot of unit vectors) for routing.

## Links

- [3Blue1Brown — Essence of Linear Algebra](https://www.3blue1brown.com/topics/linear-algebra) — visual intuition.
- [The Matrix Calculus You Need for Deep Learning (Parr & Howard)](https://arxiv.org/abs/1802.01528) — bridges calc + linear algebra to ML.
- [HuggingFace — Embeddings conceptual guide](https://huggingface.co/blog/getting-started-with-embeddings) — embeddings in practice.

## Related
- [[feature-representations]], [[02-PoC-Techniques/embeddings-and-sentence-transformers]], [[02-PoC-Techniques/vector-stores]]
