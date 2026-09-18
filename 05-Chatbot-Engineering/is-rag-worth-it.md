---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [chatbot, rag, evaluation, architecture, decision-guide]
aliases: [retrieval ladder, do I need RAG, baseline first]
---

# Is RAG worth it? Measure the ladder

> "Does retrieval solve a real problem here?" is a question with an answer, not a given. On a small corpus the honest answer is often no — and finding that out is worth more than the pipeline.

## Wide picture

RAG is the reflex for "the model needs to know my data". For a corpus that fits in a
prompt, the reflex can be wrong: retrieval can only *remove* context the model would
have had, and a tool-calling loop spends several round trips per turn re-sending the
system prompt.

The way to know is to build one pipeline with a **mode switch** rather than four
systems, and run the same evaluation set across all of them with retrieval as the only
variable. That makes the comparison cheap enough to actually do.

## The ladder

| Rung | What it does | What it tells you |
|---|---|---|
| A `context` | Whole corpus in the prompt, no retrieval | The baseline. Does retrieval beat *nothing*? |
| B `structured` | Deterministic typed lookups, no vectors | Do you need *semantics*, or just a query? |
| C `dense` | Embedding similarity | Does semantic matching help? |
| D `hybrid` | Dense + BM25 fused | Do exact terms matter? |
| E `+ rerank` | Reorder the candidates | Is precision the bottleneck, not recall? |

Each rung answers what the one below leaves open. Stop at the first that stops
improving.

## A measured example

135 semantic chunks (~40k characters), 42 evaluation cases, one LLM, four modes:

| Mode | No false claims | Coverage | p50 | Tokens |
|---|---:|---:|---:|---:|
| **`context`** | 42/42 | **0.76** | **2.8 s** | **9,406** |
| `structured` | 42/42 | 0.54 | 4.1 s | 54,223 |
| `dense` | 42/42 | 0.68 | 4.0 s | 54,576 |
| `hybrid` | 42/42 | 0.71 | 3.9 s | 62,086 |

The baseline won on every axis, at a sixth of the token cost. Note also that the
*retrieval-only* metrics said hybrid beat dense (recall 0.879 vs 0.818) — true, and
irrelevant to the decision, because the rung they were both losing to was the one
without retrieval at all.

## Essentials

- **Always build rung A.** A pure-prompt baseline is a few lines and it is the only
  thing that can tell you the rest was unnecessary.
- **Corpus size is the first-order variable.** Below roughly a prompt's worth, expect
  the baseline to be competitive. Above it, retrieval stops being optional.
- **Retrieval metrics cannot answer this question.** Recall@k has no meaning for a mode
  that does not rank. You need an end-to-end evaluation across modes.
- **Count tokens, not just quality.** The tool-calling modes cost 6× here, and it was
  invisible until measured — each tool round trip re-sends the system prompt.
- **The reasons to retrieve anyway are real but qualitative:** evidence traceability
  (the baseline returns no source IDs), audit trails, permission-scoped retrieval, and
  the fact that context-stuffing stops working as the corpus grows. Name them as the
  tradeoff they are.
- **"Lost in the middle" is the counterweight.** A big context window is not the same
  as reliable retrieval from it; models underuse information buried mid-prompt. That
  effect grows with corpus size, which is exactly when the baseline stops winning.
- **Build it, measure it, then decide** — and be willing to ship the simpler thing.
  Shipping the sophisticated option your own numbers call worse makes the measurement
  decorative.

## Mental model

Retrieval is a *compression* strategy for context you cannot afford to send. If you can
afford to send it, you are paying compression costs for nothing.

## Links

- [Liu et al. — Lost in the Middle](https://arxiv.org/abs/2307.03172) — why a larger window is not reliable retrieval, and why the baseline degrades as the corpus grows.
- [Lewis et al. — RAG (2020)](https://arxiv.org/abs/2005.11401) — parametric vs non-parametric memory, the framing the ladder tests.
- [Anthropic — Contextual Retrieval](https://www.anthropic.com/engineering/contextual-retrieval) — where retrieval design does pay, at corpus sizes that need it.

## Related
- [[chatbot-evaluation]] — the shared case set the ladder runs on.
- [[hybrid-retrieval-and-fusion]] — rung D, if you get there.
- [[chunking-strategies]] — chunk quality still matters in rung A; same source text.
- [[08-Consulting-and-Architecture/heavy-ai-vs-simple]] — the same instinct, one level up.
- [[06-MLOps-Caveats/evaluating-your-evaluator]] — check the instrument before trusting the table.
