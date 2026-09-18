---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, features, representations]
---

# Feature representations

> The single highest-leverage decision: what representation of the input does the model see?

## Wide picture

Before deep learning, "feature engineering" was the job — hand-crafting inputs (TF-IDF weights, n-grams, domain features) that a simple model could use. Deep learning learns representations, but the choice of representation paradigm (tokens, embeddings, image patches) still dominates outcomes. The reference PoC sits right on this boundary: it compares hand-crafted TF-IDF features against learned dense embeddings for the same routing task.

## Essentials

- **Hand-crafted features:** TF-IDF (word + char n-grams), one-hot, counts. Cheap, interpretable, offline. Your classifier POC.
- **Learned embeddings:** dense vectors from a pretrained model; capture semantics TF-IDF can't. Your semantic router POC.
- **The tradeoff:** TF-IDF = ~7× smaller, ~10× faster, no model download, but worse paraphrase recall. Embeddings = better semantic match, cost ~1.25GB. (Measured in the reference PoC.)
- **Tokenisation** is representation too — see [[04-LLM-Tooling/tokenizer-standardization]].
- **Garbage in:** no model fixes a broken representation or bad data.

## Mental model (applied-maths angle)

TF-IDF is a fixed (non-learned) linear feature map into a sparse high-dimensional space; the logistic regression is a linear classifier on top. Embeddings are a learned nonlinear map into a dense low-dimensional space; cosine is the metric. The POC literally benchmarks the same downstream task under both representations.

## Links

- [HuggingFace — Tokenizers summary](https://huggingface.co/docs/transformers/tokenizer_summary) — representation at the token level.
- [Bag of Words vs Embeddings (Jay Alammar)](https://jalammar.github.io/illustrated-word2vec/) — visual.
- [On the Relation Between TF-IDF and...](https://rare-technologies.com/papers/) — when sparse beats dense.

## Related
- [[02-PoC-Techniques/tfidf-logistic-regression]], [[02-PoC-Techniques/semantic-routing-embeddings]], [[linear-algebra-for-ml]]
