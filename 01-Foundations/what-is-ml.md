---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, ml]
---

# What is machine learning?

> ML is fitting a function from **data** instead of writing it by hand.

## Wide picture

In traditional software engineering you write the rules: `if X then Y`. In ML you give examples `(X, Y)` and an algorithm **fits** a function `f` such that `f(X) ≈ Y`. You then deploy `f` to predict on new inputs. The engineering discipline is the same (interfaces, tests, observability) but the core artifact is **learned**, not authored — which changes how you test, debug, and maintain it.

## Essentials
 
- **Three ingredients:** a hypothesis class (what functions you allow), a loss function (how wrong is "wrong"), and an optimiser (how you improve).
- **Generalisation is the goal,** not fitting the training data. A model that memorises is useless. See [[bias-variance-generalization]].
- **Data > model.** Representation and data quality usually beat model sophistication. See [[feature-representations]].
- **Types of learning:** [[learning-paradigms]] (supervised, unsupervised, self-supervised, RL).
- **The ML system ≠ the model.** Data pipelines, evaluation, serving, monitoring are most of the work — see [[06-MLOps-Caveats/MOC-MLOps-Caveats]].

## Mental model (SWE angle)

A model is a **stateful component whose behaviour is derived from training data** rather than code. Debugging means reasoning about data + learned weights, not just logic. That is why reproducibility, versioning, and evaluation harnesses (see [[02-PoC-Techniques/evaluation-harness]]) matter.

## Links

- [Google ML Crash Course — Introduction](https://developers.google.com/machine-learning/crash-course/ml-intro) — pragmatic first pass.
- [Hugging Face Course — Chapter 1](https://huggingface.co/learn/nlp-course/chapter1) — intro in the NLP context you are already studying.
- [A Few Useful Things to Know About Machine Learning (Domingos)](https://homes.cs.washington.edu/~pedrod/papers/cacm12.pdf) — 12 classic insights, short.

## Related
- [[learning-paradigms]], [[bias-variance-generalization]], [[02-PoC-Techniques/MOC-PoC-Techniques]]
