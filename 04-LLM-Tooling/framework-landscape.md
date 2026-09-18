---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, framework, langchain, llamaindex, haystack, dspy]
---

# Framework landscape

> LangChain is one option; the others optimise for different things.

## Wide picture

LLM-app frameworks differ in what they centre. LangChain centres **composability** (chains/agents). LlamaIndex centres **data/retrieval** (connectors, indexing, query engines). Haystack centres **production pipelines** (typed components, pipelines-as-DAGs). DSPy centres **prompt optimisation** (compile prompts from examples instead of hand-writing). Knowing the centre of gravity helps you pick.

## Essentials

- **LangChain** — broadest ecosystem, agent + tool focus, LCEL. Ecosystem big; API churny. Good default for agents/tools.
- **LlamaIndex** — strongest for RAG over your own data; rich connectors + indexing patterns. Good when retrieval/data is the hard part.
- **Haystack** — opinionated, pipeline-as-graph, strong typing; good for production NLP/GenAI pipelines with audit needs.
- **DSPy** — declarative; you write signatures + examples, the compiler optimises prompts/few-shot. Good when prompt quality is the bottleneck.
- **Plain code** — often best for small/clear RAG; no abstraction tax. The reference PoC chose this.
- **Pick by bottleneck:** agents → LangChain/LangGraph; data-heavy RAG → LlamaIndex; typed pipelines → Haystack; prompt optimisation → DSPy; simple → plain code.

## Mental model (architectural mindset)

A framework is leverage for the part it's built around and friction everywhere else. Match the framework's centre to your system's hard part. Beware adopting a framework for a problem you can solve in 50 lines.

## Links

- [LangChain](https://python.langchain.com/) · [LlamaIndex](https://docs.llamaindex.ai/) · [Haystack](https://haystack.deepset.ai/) · [DSPy](https://dspy.ai/)
- [LLM app framework comparison (Eugene Yan)](https://eugeneyan.com/start-here/) — practical take.

## Related
- [[langchain-concepts]], [[08-Consulting-and-Architecture/architectural-mindset]]
