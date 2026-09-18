---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [foundations, paradigms]
---

# Learning paradigms

> The label is what differs: supervised has answers, unsupervised finds structure, RL gets rewards.

## Wide picture

"Machine learning" is an umbrella for several problems that share the fitting-from-data idea but differ in what signal you have. Knowing which paradigm a task belongs to tells you which methods and metrics apply.

## Essentials

- **Supervised** — `(X, y)` pairs; predict `y`. Classification / regression. The reference PoC classifier (intent → answer) is supervised.
- **Unsupervised** — only `X`; discover structure (clustering, dim reduction, density).
- **Self-supervised** — generate labels from the data itself (next-token prediction, contrastive). This is how LLMs and embedding models (your MiniLM) are pretrained.
- **Reinforcement learning** — learn a policy from reward sequences; actions affect future state. Used for RLHF (aligning LLMs).
- **Transfer learning / fine-tuning** — take a pretrained model, adapt it. The dominant practical pattern; you use it when you load a pretrained sentence-transformer.

## Mental model

Most "applied ML" today is **transfer learning on top of self-supervised pretraining**: someone self-supervises a giant model, you fine-tune or prompt it for your task. The reference PoC never fine-tunes — it uses the pretrained embeddings as a fixed feature extractor, which is the simplest transfer case.

## Links

- [Hugging Face — What is transfer learning?](https://huggingface.co/learn/nlp-course/chapter3/1) (in the course you're following).
- [Self-Supervised Learning (Lilian Weng)](https://lilianweng.github.io/posts/2021-06-30-self-supervised/) — deep survey.
- [Spinning Up in RL (OpenAI)](https://spinningup.openai.com/) — RL fundamentals.

## Related
- [[what-is-ml]], [[feature-representations]], [[02-PoC-Techniques/embeddings-and-sentence-transformers]]
