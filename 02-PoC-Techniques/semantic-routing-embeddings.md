---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, semantic-routing, embeddings, cosine-similarity]
---

# Semantic routing with embeddings

> Route by meaning, not wording: embed the message, compare to intent prototypes by cosine similarity, gate on confidence + margin.

## Wide picture

The semantic router embeds bounded intent descriptions + example utterances into vectors. A new message is embedded and compared to every intent prototype by **cosine similarity**. The top intent wins **only if** its score clears a confidence threshold **and** its margin over the runner-up clears a margin threshold. Otherwise: clarify or escalate. Crucially, routing is **not** RAG — it chooses the workflow; retrieval fetches the answer separately.

## Essentials

- **Embedding** the message once; cosine similarity vs. each intent's best-matching prototype.
- **Confidence threshold** (default 0.7) — below it → `unknown` + escalate.
- **Margin threshold** (default 0.1) — top1−top2 too close → `ambiguous`, ask a clarification question instead of guessing.
- **Short-reply context inheritance** — "sí", "ese", "ok" carry no standalone intent; inherit the session's `current_intent`.
- **Policy gate first** — sensitive topics escalate regardless of similarity (safety before routing).
- **Per-intent thresholds** — configurable globally and per intent in `config/intents.json`.
- **Determinism** — fixed torch seed, CPU, `eval()`, one text per forward pass, name-based tie-break.
- **In the codebase:** `src/chatbot/routing/semantic.py`, `routing/base.py` (cosine, short-reply detect), `conversation/policy.py`.

## Mental model (applied-maths angle)

Each intent defines a region in the embedding space (its prototypes). Routing is nearest-neighbour with two rejection rules: too far from any region (low confidence) or on a boundary (low margin). The embedding is a fixed nonlinear map; the router is a simple geometric classifier on top.

## Links

- [Semantic Router (Zep article referenced by the plan)](https://blog.zep.ai/semantic-router/) — the pattern this POC follows.
- [Sentence-BERT paper (Reimers & Gurevych)](https://arxiv.org/abs/1908.10084) — why bi-encoder embeddings + cosine work for semantic search.

## Related
- [[embeddings-and-sentence-transformers]], [[vector-stores]], [[rag-retrieval-augmented-generation]], [[evaluation-harness]]
