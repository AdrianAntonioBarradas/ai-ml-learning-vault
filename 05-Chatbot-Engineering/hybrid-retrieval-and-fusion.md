---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [chatbot, rag, retrieval, bm25, hybrid, rrf]
aliases: [hybrid search, reciprocal rank fusion, RRF]
---

# Hybrid retrieval & rank fusion

> Dense search finds *meaning*, lexical search finds *the exact token you typed*. Fuse their ranks, never their scores.

## Wide picture

Embeddings are strong on paraphrase and concept and weak on precisely the queries
users ask most confidently: product names, acronyms, technologies, identifiers. Asked
about `ISIN` or `pgvector`, a dense index returns a neighbourhood of *related* things —
the wrong answer, delivered with high similarity. BM25 either finds the token or does
not. Running both and fusing is the standard fix.

## Essentials

- **What each half is for.** Dense: "what did he do about compliance?" Lexical:
  "does he know Go?", "has he used TanStack?", "what is an ISIN?"
- **BM25 over naive overlap.** Term saturation and length normalisation matter even on
  small corpora: a chunk listing thirty technologies should not outrank a chunk that is
  *about* the one being asked for.
- **Normalise for the language.** Fold accents (`liquidación` → `liquidacion`), strip
  stopwords, and keep technology-shaped tokens intact (`node-22`, `.net`, `recall@k`).
- **Fold simple plurals, symmetrically.** A corpus saying "ISINs" against a query
  saying "ISIN" returns *nothing* — the exact-term case lexical search exists to serve,
  silently broken. Apply the same transform at index and query time and it can only
  make matching symmetric.
- **Fuse ranks, not scores.** Cosine similarities and BM25 sums live on different
  scales. Blending them requires inventing a weight that then needs its own
  calibration. Reciprocal Rank Fusion discards magnitudes:
  `score(d) = Σ 1/(k + rank_i(d))`, conventionally `k = 60`. It survives an encoder or
  corpus change without retuning.
- **What RRF actually guarantees.** Appearing in *both* lists beats topping one. It
  does **not** mean ranks 2+2 beat 1+3 — the reciprocal is convex, so it rewards a
  strong showing rather than penalising it. Worth knowing before you write a test
  asserting the opposite, as I did.
- **Break ties deterministically** (score, then id). Otherwise your evaluation is not
  reproducible.
- **Reranking is a later stage.** It raises precision within the candidates recall
  already found. If recall is the bottleneck, a reranker cannot help.

## Mental model

Two witnesses with different biases. You do not average their confidence — you check
whether they agree.

## Links

- [Qdrant — hybrid search](https://qdrant.tech/documentation/search/text-search/hybrid-search/) — dense + sparse and why fusion beats blending.
- [Elastic — RRF](https://www.elastic.co/docs/reference/elasticsearch/rest-apis/reciprocal-rank-fusion) — the formula and the choice of `k`.
- [Anthropic — Contextual Retrieval](https://www.anthropic.com/engineering/contextual-retrieval) — measured complementarity of embeddings and BM25, plus reranking on top.

## Related
- [[chunking-strategies]] — fusion cannot rescue chunks at the wrong granularity.
- [[is-rag-worth-it]] — measure whether any of this beats the baseline first.
- [[chatbot-evaluation]] — recall@k and MRR are how you tell the halves apart.
- [[02-PoC-Techniques/vector-stores]] — the dense half's storage.
