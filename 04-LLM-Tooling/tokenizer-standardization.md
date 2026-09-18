---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, tokenizer, bpe, sentencepiece, tiktoken]
---

# Tokenizer standardization

> Models don't read text; they read token IDs. The tokenizer decides cost, limits, and multilingual fairness.

## Wide picture

A tokenizer maps text ↔ integer IDs over a fixed vocabulary. It is part of the model artifact (shipped alongside weights) and defines how strings become inputs. The choice of tokenizer drives token counts (and thus cost/latency), context-window consumption, and how well the model handles non-English text.

## Essentials

- **BPE (Byte-Pair Encoding)** — merge frequent byte pairs; the basis of GPT tokenizers. `tiktoken` is OpenAI's fast BPE.
- **SentencePiece / Unigram** — language-agnostic, works on raw bytes; used by Llama, T5, multilingual MiniLM. The reference PoC's model ships a `sentencepiece.bpe.model`.
- **WordPiece** — BERT family.
- **Why it matters for cost:** providers charge per token, not per character; Spanish often costs more tokens than English for the same content.
- **Why it matters for limits:** context window is in tokens; a long prompt can blow the budget before generation.
- **Standardization:** tokenizers ship as standard files (`tokenizer.json`, `tokenizer_config.json`, `special_tokens_map.json`) loadable by the HF `tokenizers` library — portable across frameworks.
- **Special tokens** — `<s>`, `</s>`, pad, mask — model-specific; using the wrong ones silently breaks generation.

## Mental model (applied-maths angle)

A tokenizer is a learned, deterministic compression `text → IDs` over a fixed codebook. It's a discrete preprocessing map; the model is continuous on top of it. Bad tokenization (e.g. token per char for a script it didn't train on) inflates sequence length and cost.

## Links

- [HuggingFace — Tokenizer summary](https://huggingface.co/docs/transformers/tokenizer_summary) — all the algorithms.
- [tiktoken (OpenAI)](https://github.com/openai/tiktoken) — fast BPE + the GPT vocab.
- [Byte-Pair Encoding (original, Sennrich et al.)](https://arxiv.org/abs/1508.07909) — the paper.

## Related
- [[model-standardization]], [[02-PoC-Techniques/embeddings-and-sentence-transformers]], [[feature-representations]]
