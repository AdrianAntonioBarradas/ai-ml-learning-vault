---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [moc, llm, langchain, tooling]
---

# MOC — LLM tooling & standardization

How LLM applications are assembled (frameworks, especially LangChain) and how the models themselves are standardized so they're portable.

## LangChain & frameworks
- [[langchain-concepts]] — LCEL, chains, prompts, models, output parsers, memory, callbacks.
- [[langchain-tools-and-agents]] — Tool/ToolCall abstraction, ReAct, tool-calling models, agent executors.
- [[langchain-retrievers]] — RAG chains, vectorstore retrievers, compression, multi-query.
- [[framework-landscape]] — LangChain vs LlamaIndex vs Haystack vs DSPy.

## Standardization
- [[model-standardization]] — safetensors/GGUF/ONNX formats, HF Hub as distribution, the OpenAI-compatible API as the de-facto serving standard, model cards + config.
- [[tokenizer-standardization]] — BPE/SentencePiece/tiktoken; why tokenization shapes cost and limits.
- [[reasoning-model-turn-state]] — thinking blocks and thought signatures must be replayed verbatim, or the *next* request fails.

## Agent protocols
- [[agent-protocol-stack]] — **start here**: four protocols, four edges of the same agent. MCP, A2A, A2UI and Open Responses do not compete.
- [[open-responses-protocol]] — client → agent. `POST {base}/responses`, items, SSE, and an executable compliance suite.
- [[a2a-protocol]] — agent → agent. Agent cards, the task state machine, and why `INPUT_REQUIRED` is the interesting state.
- [[a2ui-and-agentic-ui]] — agent → UI. Declarative interfaces from a trusted catalog; A2UI over AG-UI.

## Related
- [[02-PoC-Techniques/rag-retrieval-augmented-generation]] — RAG as a concept, implemented without LangChain.
- [[03-Inference-Deployment/MOC-Inference-Deployment]] — where these models run.
- [[05-Chatbot-Engineering/MOC-Chatbot-Engineering]] — composing these into a chatbot.
