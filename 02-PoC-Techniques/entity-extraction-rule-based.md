---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, ner, entity-extraction, rules]
---

# Rule-based entity extraction

> Pull structured entities (program, generation, date, country) from free text without a model.

## Wide picture

Before reaching for an ML NER model, a deterministic rule-based extractor often wins: it's auditable, offline, and exact on a bounded domain. The reference PoC extracts four entity types with alias tables + regex, normalising to canonical forms. Entities attach to the `RouteDecision` even when routing escalates — so a "cost" question that gets escalated still carries the detected program.

## Essentials

- **Alias tables** — canonical name + informal forms ("psico" → Psicología), matched on folded text with word boundaries.
- **Generation** — explicit ("2024-1"), natural ("primero de 2024"), reversed ("2024 primero") → normalised `YYYY-N`.
- **Date** — ISO, Latin numeric, named months, relative ("mañana") resolved against an injectable `reference_date` (benchmark pins it for reproducibility).
- **Country** — 20 LatAm countries with demonyms, ISO codes, common misspellings → canonical name.
- **Per-entity confidence** — full canonical = 0.95, alias/misspelling = 0.85; nothing scores 1.0 (headroom for corroboration).
- **Multiple mentions** — list of all, dedup by normalised value, ordered by position; overlapping spans → earliest longest.
- **In the codebase:** `src/chatbot/knowledge/entities.py`.

## Mental model (SWE angle)

This is a parser, not a learner. The value is determinism + auditability: you can explain exactly why an entity was extracted. Tradeoff: it doesn't generalise to entities outside the tables — add a learned NER model only when coverage gaps justify it.

## Links

- [spaCy — Named Entity Recognition](https://spacy.io/usage/linguistic-features#named-entities) — when you outgrow rules.
- [Rule-based vs ML NER (Explosion blog)](https://explosion.ai/blog/rule-based-models) — when rules win.

## Related
- [[tfidf-logistic-regression]], [[text-normalization]], [[clean-architecture-protocols]]
