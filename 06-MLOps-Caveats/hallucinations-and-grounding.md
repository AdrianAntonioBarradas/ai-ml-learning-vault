---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [mlops, hallucination, grounding, llm]
---

# Hallucinations & grounding

> LLMs generate plausible text, not necessarily true text. Grounding is the mitigation.

## Wide picture

LLMs are trained to produce likely next tokens, not to retrieve facts. So they confidently invent ("hallucinate") — names, citations, prices, dates. This is a property of the architecture, not a bug you can patch with prompt tweaks. The reliable mitigation is **grounding**: constrain generation to retrieved, approved content and verify the output traces to it.

## Essentials

- **Why it happens** — autoregressive generation maximises plausibility, not truthfulness; no internal fact-check.
- **Mitigations, strongest first:**
  1. Don't generate when retrieval is empty/weak (the reference PoC's gate).
  2. Ground: compose only from retrieved sources + cite.
  3. Verify: post-generation check that claims are supported (faithfulness eval).
  4. Calibrate: low-temperature, constrained decoding for factual tasks.
- **What doesn't fix it:** "be careful not to hallucinate" in the prompt; bigger models (reduces, doesn't eliminate).
- **Detection in prod:** faithfulness/groundedness metrics, contradiction detection, answer-vs-source entailment.

## Mental model (architectural mindset)

Treat the LLM as a fluent liar that becomes truthful only when its output is anchored to sources you control. Design the system so an ungrounded answer is impossible to ship, not merely discouraged.

## Links

- [Survey of Hallucination in LLMs (Huang et al.)](https://arxiv.org/abs/2202.03629) — the taxonomy.
- [RAGAS — faithfulness](https://docs.ragas.io/) — measure it.

## Related
- [[05-Chatbot-Engineering/retrieval-and-grounding]], [[evaluation-is-hard]], [[02-PoC-Techniques/rag-retrieval-augmented-generation]]
