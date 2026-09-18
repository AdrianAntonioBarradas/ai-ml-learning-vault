---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, preprocessing, normalization]
---

# Text normalization

> Preprocess messy human input so downstream routers see clean, consistent text.

## Wide picture

Real users misspell, skip accents, write statements instead of questions, and greet before asking. Phase 3 of the reference PoC adds a `TextNormalizer` preprocessing layer before routing: spell correction, statement→question conversion, greeting/help detection. It hardens the classifier and RAG POCs for non-tech-savvy users and improves fallback UX ("did you mean?").

## Essentials

- **Accent/punctuation folding** — normalise before matching (shared in `routing/base.py`).
- **Chat-abbreviation expansion** — informal forms mapped to canonical.
- **Spell correction** — fix common typos before classification/retrieval.
- **Statement→question** — "quiero saber el precio" → treated as a question.
- **Greeting/help detection** — route "hola"/"ayuda" to the right flow without confusing the intent model.
- **Context-aware conversation flow** — V-type pending questions, entity tracking, follow-up suggestions.
- **In the codebase:** `src/chatbot/conversation/text_normalizer.py`, `routing/base.py`.

## Mental model (SWE angle)

Normalisation is the input validation layer for NLP — cheap, deterministic, and high-leverage because every downstream component benefits. Get it wrong and you're asking the model to do the janitor's job.

## Links

- [Text normalization concepts (NLTK book)](https://www.nltk.org/book/ch03.html) — foundations.

## Related
- [[tfidf-logistic-regression]], [[entity-extraction-rule-based]], [[evaluation-harness]]
