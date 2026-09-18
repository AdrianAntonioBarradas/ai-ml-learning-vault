---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, langchain, retrieval, rag]
---

# LangChain retrievers

> The RAG half of LangChain: a `Retriever` interface that returns documents for a query, composable into chains.

## Wide picture

LangChain's `Retriever` is an interface: `get_relevant_documents(query) -> List[Document]`. Implementations wrap vector stores, search engines, or hybrid strategies. You compose a retriever into a RAG chain: `retriever | prompt | model | parser`. The reference PoC implements retrieval directly (no LangChain); these notes map the concept to the framework so you can compare.

## Essentials

- **VectorStoreRetriever** — wraps a vector store (Chroma, FAISS, pgvector) for similarity search.
- **Retrieval strategies:**
  - **Multi-query** — generate variants of the query, retrieve for each, union.
  - **Compression** — post-retrieve, compress/filter documents to the relevant passages.
  - **Parent-document** — retrieve small chunks, return the larger parent for context.
  - **Ensemble / hybrid** — combine dense + BM25/keyword retrieval.
- **Document object** — `page_content` + `metadata` (source, page, etc.); metadata drives citations.
- **Grounding pattern** — pass retrieved docs into the prompt; instruct the model to cite; reject if no docs.
- **When LangChain helps vs hurts** — for simple RAG, plain code + a vector store is often clearer; LangChain pays off at higher composition/observability needs.

## Mental model

The retriever is a typed query API over your knowledge store. The RAG chain is `search → stuff into prompt → generate`. Keep retrieval quality (chunking, embeddings, hybrid) as the priority — framework choice is secondary.

## Links

- [LangChain — Retrievers docs](https://python.langchain.com/docs/concepts/retrievers/) — the interface + strategies.
- [LangChain — RAG tutorial](https://python.langchain.com/docs/tutorials/rag/) — end-to-end.
- [Pinecone — RAG patterns](https://www.pinecone.io/learn/series/rag/) — chunking + retrieval deep dive.

## Related
- [[02-PoC-Techniques/rag-retrieval-augmented-generation]], [[02-PoC-Techniques/vector-stores]], [[langchain-concepts]]
