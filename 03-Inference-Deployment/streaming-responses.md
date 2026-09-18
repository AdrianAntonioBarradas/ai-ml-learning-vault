---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, streaming, sse, chat-ui]
---

# Streaming responses (SSE)

> Show the user words as they're generated — perceived latency drops even when total time is unchanged.

## Wide picture

LLM generation is sequential: each token depends on the previous. Waiting for the full answer before showing anything feels slow. Streaming sends each token (or small chunk) to the client as it's produced, almost always over **SSE**. The user sees text appear immediately; perceived latency drops dramatically and you can cancel mid-generation.

## Essentials

- **SSE format** — `data: {chunk}\n\n` lines over `text/event-stream`; end with `data: [DONE]`.
- **Delta vs full** — providers stream token deltas; the client accumulates into the full message.
- **Why SSE not WebSocket for chat** — one-way (server→client), plain HTTP, auto-reconnect, proxy-friendly. WebSocket is overkill for token streaming.
- **Cancellation** — client closes the connection; the server should stop generation (saves cost).
- **Tool-call streaming** — agents can stream partial tool-call JSON too, so the UI can render tool progress.
- **Backend implications** — streaming holds a connection open; requires async handling + connection limits (see [[multi-user-context-concurrency]]).

## Mental model (SWE angle)

Streaming trades request simplicity for UX. The backend becomes a generator yielding chunks instead of returning one payload. Test it like any async stream: partial-failure, cancellation, reconnection, and ordering.

## Links

- [OpenAI streaming guide](https://platform.openai.com/docs/api-reference/streaming) — reference implementation.
- [HuggingFace TGI streaming](https://huggingface.co/docs/text-generation-inference) — SSE for self-hosted.
- [Vercel AI SDK — streaming UI](https://sdk.vercel.ai/docs) — client-side streaming patterns.

## Related
- [[inference-api-architectures]], [[05-Chatbot-Engineering/chatbot-architecture-patterns]]
