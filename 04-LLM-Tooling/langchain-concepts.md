---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, langchain, lcel, chains]
---

# LangChain concepts

> LangChain composes LLM calls into pipelines: prompt → model → output parser, wired with memory and callbacks.

## Wide picture

LangChain is an orchestration framework for LLM applications. The core idea is a **chain**: a sequence of steps (prompt template → LLM → parser) you compose and run. The modern expression is **LCEL** (LangChain Expression Language), which makes chains pipeable (`prompt | model | parser`) and gives you streaming, async, and batch for free. Around that sit components for memory, retrieval, tools, and observability.

## Essentials

- **LCEL** — the `|` pipe syntax; a Runnable protocol with `.invoke`, `.stream`, `.batch`, `.ainvoke`. Prefer this over legacy chain classes.
- **PromptTemplate / ChatPromptTemplate** — parameterised prompts; the input contract to the model.
- **Models** — `ChatModel` abstraction over providers (OpenAI, Anthropic, HF, Ollama); swap by changing one line.
- **Output parsers** — turn model text into structured data (JSON, Pydantic). Often replaced by native tool/function calling now.
- **Memory** — conversation history; in practice often replaced by explicit message lists passed to the model.
- **Callbacks / tracing** — hooks for logging, LangSmith tracing, token accounting.
- **Structured output** — `with_structured_output(schema)` returns typed objects via the model's tool-calling.

## Mental model (SWE angle)

LangChain is a data-processing pipeline library where one stage is an LLM. LCEL is the stream/iterator combinator. The value is provider abstraction + composability + tracing; the cost is abstraction overhead and a churny API surface (see [[Review-Log]] watchlist).

## Links

- [LangChain — LCEL docs](https://python.langchain.com/docs/concepts/lcel/) — the core concept.
- [LangChain — Runnable interface](https://python.langchain.com/docs/concepts/runnables/) — invoke/stream/batch.
- [LangSmith](https://docs.smith.langchain.com/) — tracing/observability for LangChain apps.

## Related
- [[langchain-tools-and-agents]], [[langchain-retrievers]], [[model-standardization]]
