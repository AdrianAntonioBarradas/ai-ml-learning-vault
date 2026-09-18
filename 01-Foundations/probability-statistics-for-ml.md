---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, probability, statistics]
---

# Probability & statistics for ML

> ML is statistics that scales; uncertainty is a first-class output, not a footnote.

## Wide picture

Training a model is (usually) maximum-likelihood estimation: pick parameters that make the observed data most probable. Inference is producing a distribution (or a point with a confidence). Classifiers output `P(class | input)` — the reference PoC's `predict_proba` and the semantic router's confidence/margin are exactly this. Knowing the probabilistic meaning stops you from treating a 0.6 score as "60% right."

## Essentials

- **Likelihood vs probability** — likelihood is `P(data | params)` viewed as a function of params; training maximises it (MLE).
- **Bayes' rule** — `P(H|D) ∝ P(D|H) P(H)`; the scaffold for classification, Bayesian updating, and reasoning under uncertainty.
- **Distributions** — softmax turns logits into a categorical distribution; that is what `predict_proba` returns.
- **Confidence vs calibration** — a score of 0.9 should mean "right 90% of the time." The reference PoC measures this with calibration bins (see [[02-PoC-Techniques/evaluation-harness]]).
- **Sampling & variance** — why a single eval run is not enough; determinism + repeated runs matter ([[02-PoC-Techniques/offline-and-determinism]]).

## Mental model (applied-maths angle)

Logistic regression (your classifier POC) is MLE for a Bernoulli-ish categorical model with a linear-logit parameterisation; the TF-IDF weighting is a heuristic feature prior. The "margin" threshold is a frequentist uncertainty gate.

## Links

- [Seeing Theory — A visual intro to probability](https://seeing-theory.brown.edu/) — interactive.
- [Probability for Machine Learning (Murphy, ch.2 of PML)](https://probml.github.io/pml-book/book1.html) — rigorous, free.
- [On Calibration of Modern Neural Networks (Guo et al.)](https://arxiv.org/abs/1706.04599) — why confidence ≠ accuracy.

## Related
- [[evaluation-metrics]], [[02-PoC-Techniques/tfidf-logistic-regression]], [[02-PoC-Techniques/evaluation-harness]]
