---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, evaluation, metrics]
---

# Evaluation metrics

> You cannot improve what you cannot measure — and the wrong metric quietly lies to you.

## Wide picture

Choosing the metric is a product decision: what does "good" mean for this system? Accuracy hides class imbalance; a confidence threshold changes everything; a retrieval system needs recall@k, not accuracy. The reference PoC deliberately measures top-1 accuracy, paraphrase consistency, calibration, and threshold gaps separately because they answer different questions.

## Essentials

- **Classification:** accuracy, precision, recall, F1, ROC-AUC. Which matters depends on class balance and error cost.
- **Confidence-aware:** calibration, top-1/top-2 margin, high-confidence precision. The reference PoC uses these as routing gates (see [[02-PoC-Techniques/evaluation-harness]]).
- **Retrieval (RAG):** recall@k, precision@k, MRR, NDCG. Did the right document make the cut?
- **LLM-specific:** human eval, LLM-as-judge, faithfulness/groundedness, reference-free metrics (e.g. RAGAS).
- **Offline vs online:** offline golden sets catch regressions; online metrics (latency, CSAT, escalation rate) catch real-world drift.
- **Holdout discipline:** never tune on the test set; keep a frozen golden set (the reference PoC's Phase 1 baseline).

## Mental model (SWE angle)

An evaluation harness is the test suite for a learned component. Golden cases = unit tests; paraphrase/Spanish-variant cases = property tests; determinism digests = reproducibility tests. Treat eval with the same rigor as CI.

## Links

- [Beyond Accuracy (Ribeiro et al.)](https://aclanthology.org/2020.acl-main.184/) — behavior-driven eval for NLP.
- [RAGAS — RAG evaluation framework](https://docs.ragas.io/) — faithfulness/recall metrics for RAG.
- [Eugene Yan — Evaluating LLM applications](https://eugeneyan.com/start-here/) — practical eval strategy.

## Related
- [[02-PoC-Techniques/evaluation-harness]], [[06-MLOps-Caveats/evaluation-is-hard]], [[probability-statistics-for-ml]]
