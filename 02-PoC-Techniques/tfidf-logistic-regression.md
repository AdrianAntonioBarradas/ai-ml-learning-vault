---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [poc, classifier, tfidf, logistic-regression, scikit-learn]
---

# TF-IDF + logistic regression

> A classic, tiny, offline text classifier: weighted n-gram features into a linear model with calibrated probabilities.

## Wide picture

This POC routes a message to a bounded intent using a scikit-learn pipeline: a `FeatureUnion` of **word-level TF-IDF (1–2 grams)** and **character-level TF-IDF (3–5 char_wb grams)** into a multinomial **LogisticRegression**. The char n-grams make it robust to misspellings and Spanish inflection. Confidence is the model's `predict_proba` posterior; routing gates on confidence + margin thresholds.

## Essentials

- **TF-IDF** — term frequency × inverse document frequency; weights terms by how discriminative they are across the corpus.
- **Char n-grams (char_wb)** — substrings within word boundaries; tolerate typos/inflection without a model.
- **Logistic regression** — linear classifier; `predict_proba` gives calibrated-ish posteriors. `C=8.0`, balanced class weights, fixed seed.
- **Thresholds** — confidence < 0.5 → escalate; margin (top1−top2) < 0.1 → ask clarification.
- **Training data** — intent catalog + approved FAQ rows + classifier-only augmentation (kept separate so it doesn't distort the semantic router's geometry).
- **Footprint:** ~576KB persisted, trains in ~0.7s, ~7× smaller and ~10× faster than the embedding router — but worse paraphrase recall.
- **In the codebase:** `src/chatbot/routing/classifier.py`, `config/classifier_training.json`, `knowledge/entities.py`.

## Mental model (applied-maths angle)

A linear model on a sparse high-dimensional feature space: `P(y|x) = softmax(W·tfidf(x) + b)`. Training is convex (logistic loss) → global optimum, deterministic with a fixed seed. The char n-grams are a smoothing prior on word forms.

## Links

- [scikit-learn — TF-IDF vectorizer docs](https://scikit-learn.org/stable/modules/generated/sklearn.feature_extraction.text.TfidfVectorizer.html) — the exact transform used.
- [Logistic Regression (Murphy, PML §8)](https://probml.github.io/pml-book/book1.html) — the maths.

## Related
- [[feature-representations]], [[semantic-routing-embeddings]], [[evaluation-harness]], [[entity-extraction-rule-based]]
