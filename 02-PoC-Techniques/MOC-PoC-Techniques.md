---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [moc, poc]
---

# MOC — PoC techniques

Techniques extracted from a real (private) FAQ chatbot PoC codebase — a Telegram bot for an educational institution. File paths below are illustrative of that layout (`src/chatbot/...`). Each note ties the concept to the file that implements it, so abstractions stay anchored to working code. The POC compares four routing approaches against the same FAQ corpus, with a shared evaluation harness.

The four POCs: **rules/keywords**, **TF-IDF + logistic regression classifier**, **semantic router (embeddings)**, **hybrid RAG**.

## Architecture & shared layer
- [[clean-architecture-protocols]] — `domain/protocols.py`, Pydantic models, protocol-based routers (the `IntentRouter` interface all four share).
- [[offline-and-determinism]] — `HF_HUB_OFFLINE`, fixed seeds, CPU, tie-breaking; why it matters.

## The four routers
- [[rules-keyword-routing]] — `routing/rules.py` — deterministic baseline.
- [[tfidf-logistic-regression]] — `routing/classifier.py` — scikit-learn pipeline, `predict_proba` calibration, thresholds.
- [[semantic-routing-embeddings]] — `routing/semantic.py` — cosine similarity, confidence + margin gates, context inheritance.
- [[rag-retrieval-augmented-generation]] — `conversation/rag_engine.py` — retrieval, grounding, citations, escalation.

## Supporting components
- [[embeddings-and-sentence-transformers]] — `knowledge/embeddings.py` — the multilingual MiniLM, 384-dim unit vectors.
- [[vector-stores]] — `knowledge/vector_store.py` + embedding cache (SHA-256 keyed, hit-rate stats).
- [[entity-extraction-rule-based]] — `knowledge/entities.py` — program/generation/date/country extraction.
- [[text-normalization]] — `conversation/text_normalizer.py` — spell correction, statement→question, greeting detection.
- [[evaluation-harness]] — `evaluation/*` — golden cases, metrics, threshold measurement, determinism digests, latency/memory.

## Related
- [[01-Foundations/MOC-Foundations]] — the theory behind these.
- [[05-Chatbot-Engineering/MOC-Chatbot-Engineering]] — how these compose into a chatbot.
