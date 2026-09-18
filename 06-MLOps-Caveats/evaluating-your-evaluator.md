---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [mlops, evaluation, testing, measurement, gotcha]
aliases: [graders that lie, meta-evaluation, testing the test]
---

# Evaluating your evaluator

> A metric that confidently reports the wrong number is worse than no metric, because it gets acted on. Test the instrument before you trust the reading.

## Wide picture

Evaluation harnesses are code, and usually the least-tested code in the project. They
are also uniquely dangerous: a broken grader does not crash, it produces a plausible
table. You then "fix" a system that was not broken, or ship one that is.

Three failures from a single project, all caught only by reading the answers the
grader had marked wrong.

## Three ways a grader lies

**1. Negation blindness.** A substring grader looking for the forbidden claim
`"tiene experiencia"` fires on `"NO tiene experiencia"` — the correct denial scored as
the assertion it denied. Reported 31/42 when the system was at 41/42. Fix: check for a
negation within a window before the match, and **clip the window at the sentence
boundary**, or one correct sentence launders a false one in the next.

**2. Subject blindness.** Even negation-aware, `"tiene experiencia"` fires on a true
statement about a *different* technology: *"no tiene experiencia con Kubernetes… donde
sí tiene experiencia es en Docker"*. Substring matching has no notion of what a
sentence is about. Fix: forbidden claims must name their subject.

**3. Scoring the wrong component.** Privacy cases were graded on retrieval recall, but
a policy gate answers them *before* retrieval runs, so they could only score zero.
Excluding them moved recall from 0.763 to 0.879. The metric had been reporting a
retrieval failure for a component working exactly as designed.

## The one that generalises

Earlier, unrelated project: a five-encoder sweep showed one model ahead on recall by
52 points. It was also escalating **0 of 5** out-of-domain probes — it had not
retrieved better, it had stopped refusing. **Always report recall and abstention
together**; a single number cannot tell "found more" from "rejects nothing" apart.

## Essentials

- **Write tests for the grader.** Feed it known-correct and known-false answers and
  assert the verdicts. Cheap, and it is where all three bugs above were pinned.
- **Read the failures before believing the score.** Every one of these was obvious in
  the answer text and invisible in the number.
- **Prefer an instrument that cannot invent a pass.** Deterministic substring matching
  is blunt — it marks correct paraphrase as a miss — but it never fabricates success.
  Report such a score as a *floor*, not a grade. An LLM judge reads better and must
  itself be evaluated first.
- **Grade different failure modes separately.** One average hides everything. Split by
  category so a regression says something specific.
- **Never let one metric carry a safety property.** Pair recall with abstention,
  coverage with false-claim count.
- **Run the executable spec, if one exists.** Hand-written contract tests can only
  confirm your own reading. Twelve of mine passed against an implementation that
  failed 16 of 17 official conformance tests — the same misreading wrote both.

## Mental model

Your evaluation is a measuring instrument. You would not trust a thermometer you had
never held against boiling water.

## Links

- [Anthropic — Contextual Retrieval](https://www.anthropic.com/engineering/contextual-retrieval) — worked example of measuring retrieval and reranking properly.
- [RAGAS](https://docs.ragas.io/) — separating retrieval relevance from answer faithfulness, so one number cannot hide the other.
- [Saad-Falcon et al. — ARES](https://arxiv.org/abs/2311.09476) — automated RAG evaluation, and its own validation problem.

## Related
- [[evaluation-is-hard]] — the general version of this problem.
- [[05-Chatbot-Engineering/chatbot-evaluation]] — the harness these bugs lived in.
- [[05-Chatbot-Engineering/is-rag-worth-it]] — decisions made on these numbers.
- [[reproducibility-determinism]] — a non-deterministic harness cannot be debugged.
