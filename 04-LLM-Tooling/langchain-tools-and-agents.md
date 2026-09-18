---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [llm, langchain, tools, agents, react, function-calling]
---

# LangChain tools & agents

> Tools are functions the LLM can call; an agent is the loop that decides which to call and acts on the result.

## Wide picture

Your specific ask: understand LangChain's tool concepts. A **Tool** is a callable with a name, a description, an input schema, and a function. The LLM is given the tool schemas and, given a user request, **decides** to call a tool (producing a structured ToolCall) instead of answering directly. An **agent** is the loop: model → tool call → execute tool → feed result back → model → … until it produces a final answer. This is how an LLM becomes *actuating* rather than just text-generating.

## Essentials

- **Tool abstraction** — `@tool` decorator or `StructuredTool`; defined by name + description + args_schema (Pydantic). The description is what the model reads to decide usage — write it carefully.
- **Tool calling / function calling** — native model capability: the model emits a structured call (`name`, `args`) rather than free text. Most modern models support it; this replaced the text-parsing ReAct pattern.
- **ReAct** — the classic "Reason + Act" loop: Thought → Action → Observation → … prompt-based; still useful for models without native tool calling.
- **Agent executor** — the loop driver: invoke model, parse tool calls, execute, loop. LangGraph is now the recommended way to build agents (stateful, controllable graphs) over the older `AgentExecutor`.
- **Binding tools** — `model.bind_tools([...])` exposes tools to the model.
- **Tool selection** — too many tools confuses the model; retrieve/filter relevant tools per query (tool RAG).
- **Safety** — tools that mutate state need confirmation, scopes, and sandboxing. See [[06-MLOps-Caveats/prompt-injection-security]].

## Mental model (SWE angle)

Tools are the LLM's "standard library" — an external function table the model addresses by name. The agent is an interpreter loop calling those functions. The hard parts are: good tool descriptions, limiting the tool surface, handling errors/retries, and preventing the model from calling the wrong thing under injection.

## Links

- [LangChain — Tools docs](https://python.langchain.com/docs/concepts/tools/) — the tool abstraction.
- [LangChain — Tool calling](https://python.langchain.com/docs/how_to/tool_calling/) — binding + executing.
- [LangGraph](https://langchain-ai.github.io/langgraph/) — the recommended agent runtime.
- [OpenAI — Function calling guide](https://platform.openai.com/docs/guides/function-calling) — the native capability underneath.

## Related
- [[langchain-concepts]], [[05-Chatbot-Engineering/chatbot-architecture-patterns]], [[06-MLOps-Caveats/prompt-injection-security]]
