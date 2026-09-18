---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [chatbot, rag, grounding]
---

# Retrieval & grounding for chatbots

> The answer must come from approved content; the LLM only reformats.

## Wide picture

For an information chatbot, grounding is non-negotiable: retrieve approved records, compose only from them, cite sources, and fall back/escalate when retrieval is empty or weak. This is RAG with a safety bias. The reference PoC's hybrid RAG implements exactly this.

## Essentials

- **Content model** — structured FAQ fields (ID, intent, approved answer, response type, scope, dates, owner, status, version). The vector index is *not* the source of truth.
- **Chunking** — for FAQ-scale, one record = one chunk; for documents, semantic chunking with overlap. Granularity is the sharp edge: see [[chunking-strategies]].
- **Citations** — every answer links to the source record(s); users can verify.
- **Grounding rules** — generate only when retrieval is non-empty and above threshold; reject contradictory/stale content.
- **No-LLM baseline** — compose deterministically from retrieved facts first; add LLM composition only where it measurably helps (the reference PoC's Gate 4).
- **Freshness** — detect expired promotions/dates; never serve stale answers.
- **See [[02-PoC-Techniques/rag-retrieval-augmented-generation]] for the concept + [[02-PoC-Techniques/vector-stores]] for storage.**

## Mental model

Grounding = "the model may only quote, not invent." Treat retrieval like a database read and the LLM like a templating engine over the rows. If the read returns nothing, you don't render a page — you show a fallback.

## Links

- [RAG fundamentals (Pinecone)](https://www.pinecone.io/learn/retrieval-augmented-generation/) — practical.
- [RAGAS — groundedness metrics](https://docs.ragas.io/) — measure grounding.

## Related
- [[02-PoC-Techniques/rag-retrieval-augmented-generation]], [[guardrails-safety-policy]], [[chatbot-evaluation]]
- [[is-rag-worth-it]] — before any of this, check that retrieval beats putting the corpus in the prompt.
- [[chunking-strategies]], [[hybrid-retrieval-and-fusion]] — the two decisions that determine whether retrieval works.
