---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, optimization, gradient-descent]
---

# Optimisation & gradient descent

> Training = iteratively nudging parameters down the loss surface using the slope.

## Wide picture

Nearly all modern ML training is **first-order optimisation**: compute the gradient of the loss w.r.t. parameters, then step opposite to it. You already know optimisation theory; the ML-specific parts are (a) the loss is non-convex but works anyway, (b) we use stochastic mini-batches, and (c) the tricks (momentum, Adam, learning-rate schedules) that make it stable in practice.

## Essentials

- **Loss function** — the objective; e.g. cross-entropy for classification, MSE for regression. Defines "what is good."
- **Gradient descent** — `θ ← θ − η ∇L(θ)`. The learning rate `η` is the single most important hyperparameter.
- **Stochastic / mini-batch** — estimate the gradient on a sample; cheaper and noisy in a useful way.
- **Adam** — adaptive, momentum-based; the default optimiser for most DL/LLM fine-tuning.
- **Backpropagation** — reverse-mode autodiff to compute gradients efficiently; frameworks (PyTorch) do it for you.
- **Convergence is not guaranteed** (non-convex); we rely on empirics + reproducibility.

## Mental model (applied-maths angle)

Gradient descent is steepest descent in parameter space with a fixed metric. Adam is a diagonal preconditioning (per-parameter adaptive step). Batch norm / layer norm are changing the conditioning of the problem. Fine-tuning an LLM is the same loop with a much bigger `θ`.

## Links

- [3Blue1Brown — What is backpropagation really doing?](https://www.youtube.com/watch?v=Ilg3gGewQ5U) — visual.
- [Optimizing Neural Network Performance (Karpathy)](https://karpathy.github.io/2019/04/25/recipe/) — practical recipe.
- [An overview of gradient descent optimization algorithms (Ruder)](https://ruder.io/optimizing-gradient-descent/) — the canonical survey.

## Related
- [[what-is-ml]], [[probability-statistics-for-ml]]
