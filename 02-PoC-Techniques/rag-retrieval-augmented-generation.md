---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, rag, retrieval, grounding]
---

# Retrieval-Augmented Generation (RAG)

> Retrieve approved facts, then compose an answer **only** from them. The LLM is not the source of truth.

## Wide picture

RAG retrieves relevant records from a knowledge store and feeds them to a generator (optionally an LLM) to compose an answer. The safety discipline: if retrieval is empty, stale, contradictory, or below threshold, **do not generate** — fall back or escalate. Your hybrid POC applies policy → routes intent → retrieves approved FAQ/program records → optionally composes with citations → escalates on low confidence.

## Essentials

- **Retrieval ≠ routing** — the semantic router picks the workflow; retrieval fetches the content. Keep them separate (improves observability + safety).
- **Grounding** — the answer must be derivable from retrieved records; cite sources.
- **Escalation gates** — low retrieval confidence, contradictions, or stale content → controlled fallback / human handoff, never a guess.
- **No-LLM variant** — the reference PoC can compose from retrieved facts deterministically (no generation, zero hallucination) as the safe baseline.
- **Retrieval method** — semantic search over the approved FAQ corpus (see [[vector-stores]]).
- **In the codebase:** `src/chatbot/conversation/rag_engine.py`, `knowledge/retriever.py`, `knowledge/vector_store.py`.

## Mental model (SWE angle)

RAG is a read-through cache: the knowledge store is the system of record, the LLM is a presentation layer that reformats retrieved rows for the user. Never let the presentation layer invent rows. Test grounding the way you'd test a cache: does every output trace to a source?

## Links

- [Retrieval-Augmented Generation (Lewis et al., original paper)](https://arxiv.org/abs/2005.11401) — the canonical reference.
- [Pinecone — RAG overview](https://www.pinecone.io/learn/retrieval-augmented-generation/) — practical.

## Related
- [[semantic-routing-embeddings]], [[vector-stores]], [[05-Chatbot-Engineering/retrieval-and-grounding]], [[06-MLOps-Caveats/hallucinations-and-grounding]]
