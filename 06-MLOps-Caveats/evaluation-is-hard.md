---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, evaluation, testing]
---

# Evaluation is hard

> The metric you can measure is rarely the one you care about; the one you care about lags in production.

## Wide picture

Evaluation is the hardest part of ML/LLM ops. Offline metrics (accuracy, F1) can look great while the product feels wrong; online metrics (CSAT, retention) arrive too late to prevent harm. LLM outputs are open-ended, so "correctness" is often subjective — requiring human or LLM-as-judge evaluation with its own biases. The discipline: triangulate multiple metrics, keep frozen golden sets, and close the loop between online behavior and offline tests.

## Essentials

- **Goodhart's law** — when a measure becomes a target, it ceases to be a good measure. Don't overfit to one metric.
- **Offline vs online gap** — golden-set accuracy ≠ user satisfaction; supplement with shadow + canary.
- **LLM-as-judge** — scalable but biased (verbosity, position, self-preference); calibrate against humans.
- **Open-ended outputs** — need reference-free metrics (faithfulness, groundedness, task completion).
- **Frozen golden sets** — prevent training-on-test; the reference PoC's Phase 1 baseline is the pattern.
- **Behavior-driven eval** — test behaviors (equivalent phrasings → equivalent routes), not just inputs→outputs.
- **Close the loop** — feed prod escalations back into the golden set.

## Mental model

Evaluation is a measurement system with its own error model. Trust no single number; maintain a panel of metrics + a frozen reference set + a human spot-check channel. The eval harness is the part of the system that most determines whether you can improve safely.

## Links

- [Beyond Accuracy (Ribeiro et al.)](https://aclanthology.org/2020.acl-main.184/) — behavior-driven testing.
- [LLM-as-judge pitfalls (Zheng et al.)](https://arxiv.org/abs/2306.05685) — judge biases.
- [Eugene Yan — evaluating LLM apps](https://eugeneyan.com/start-here/) — practical triangulation.

## Related
- [[02-PoC-Techniques/evaluation-harness]], [[data-drift-model-degradation]], [[hallucinations-and-grounding]]
