---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [chatbot, rag, chunking, retrieval]
aliases: [semantic chunking, contextual retrieval]
---

# Chunking strategies

> Chunking is a retrieval-quality decision, not a storage optimisation. Get the *granularity* wrong and the right document loses to an irrelevant one that happens to share a word.

## Wide picture

A token-window splitter is the default and it is usually the wrong default. What a
chunk should be is a question about your content: for a CV, one role highlight or one
project; for a FAQ, one entry; for a manual, one procedure. The unit that answers a
question on its own is the unit to index.

Two failure modes dominate, and both are invisible until you measure retrieval
separately from answers.

## Essentials

- **Semantic units over fixed windows.** Cut on the boundaries the content already
  has. Arbitrary windows produce fragments that retrieve well and read badly.
- **Self-contained text.** `"Reduced manual allocation steps"` is useless retrieved
  alone. `"Cicada — settlement automation: reduced manual allocation steps"` answers
  by itself. A cheap test: assert no chunk opens with a bare pronoun.
- **Prepend context before embedding.** Anthropic's *contextual retrieval*: a short
  line naming the document and entity, added to the chunk before it is embedded and
  indexed. Cheap, and it recovers the context the split threw away.
- **Granularity is the sharp edge.** Too coarse and a query about one item competes
  against a chunk mostly about twenty others. Real case: *"has he worked with
  **Kubernetes** in **production**?"* retrieved a chunk about a *production bot*,
  because the incidental word outweighed the only term that mattered against a
  category-sized chunk. Fix: one chunk per item, keeping the category chunk too.
- **Two granularities are allowed.** Per-item chunks answer "does he know X?";
  per-category chunks answer "what does he know about Y?". Index both.
- **Qualifiers travel with the claim.** If a fact has a caveat — a proficiency level, a
  disclaimer, an attribution — put it *inside the chunk text*, not only in metadata.
  Retrieval may hand the model nothing else.
- **Metadata earns its keep** for filtering: entity, date, source, confidence,
  public/private.

## Mental model

A chunk is an answer to a question you have not been asked yet. If it cannot stand
alone in front of a stranger, it is not a chunk — it is a fragment.

## Links

- [Anthropic — Introducing Contextual Retrieval](https://www.anthropic.com/engineering/contextual-retrieval) — prepending context before embedding, with measured retrieval-failure reductions.
- [Pinecone — chunking strategies](https://www.pinecone.io/learn/chunking-strategies/) — the standard survey of window/semantic/recursive approaches.

## Related
- [[retrieval-and-grounding]] — what happens to the chunk once retrieved.
- [[hybrid-retrieval-and-fusion]] — the granularity bug above is also a lexical-vs-dense story.
- [[is-rag-worth-it]] — chunk quality matters even when you end up not retrieving.
- [[02-PoC-Techniques/vector-stores]] — where the chunks land.
