---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, generalization]
---

# Bias, variance & generalisation

> A model that fits training data perfectly usually fails in production. Generalisation is the real target.

## Wide picture

The central tension in ML: a model too simple underfits (high **bias**), a model too flexible overfits (high **variance** — sensitive to the particular training sample). You want the sweet spot that captures the underlying signal but not the noise. Every design choice (model size, regularisation, data volume, early stopping) is a lever on this tradeoff.

## Essentials

- **Bias** — systematic error from wrong assumptions (e.g. modelling nonlinear data with a line).
- **Variance** — sensitivity to training data; overfitting. More data / regularisation / simpler model reduce it.
- **Generalisation gap** — train vs. held-out performance gap; the overfitting signal.
- **Regularisation** — L2, dropout, weight decay, early stopping; penalise complexity.
- **Cross-validation** — estimate generalisation honestly from limited data.
- **The double descent curve** — modern overparameterised models can improve again past the interpolation point; don't take the textbook U-curve as gospel.

## Mental model (applied-maths angle)

This is the bias-variance decomposition of expected risk you know from statistics, applied to a function estimator. The modern twist: in the overparameterised regime, implicit regularisation of SGD + huge data means variance can stay low even when the model can fit anything.

## Links

- [Understanding the Bias-Variance Tradeoff (Fortmann-Roe)](https://scott.fortmann-roe.com/docs/BiasVariance.html) — classic visual.
- [Deep Double Descent (OpenAI)](https://openai.com/index/deep-double-descent/) — the modern nuance.
- [The Bitter Lesson (Sutton)](http://www.incompleteideas.net/IncIdeas/BitterLesson.html) — scale + compute beat clever priors.
	 
## Related
- [[evaluation-metrics]], [[what-is-ml]], [[06-MLOps-Caveats/data-drift-model-degradation]]
