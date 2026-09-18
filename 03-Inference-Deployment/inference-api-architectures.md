---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [inference, api, sse, webhooks, websocket, grpc, streaming]
---

# Inference API architectures

> How does the client get tokens back? REST, SSE, webhooks, WebSocket, or gRPC — each fits a different shape of request.

## Wide picture

An inference call has two axes: **how long it takes** and **how you want the result** (all-at-once vs streamed). Short synchronous calls use REST. Long generations stream tokens back via **SSE** or **WebSocket**. Asynchronous batch jobs use a **webhook callback** (submit → get a job id → receive a POST when done). High-throughput internal RPC uses **gRPC streaming**. Picking the wrong one creates either UX lag or ops complexity.

## Essentials

- **REST (request/response)** — simplest; client waits for the full response. Fine for short, bounded calls (embeddings, classification, routing — like the reference PoC's CLI).
- **SSE (Server-Sent Events)** — server streams tokens over a long-lived HTTP response; the standard for LLM chat streaming. One-way (server→client), auto-reconnect, works through proxies.
- **WebSocket** — bidirectional, persistent; use when the client also streams (voice, real-time) and you need a true duplex channel.
- **Webhooks (async jobs)** — for long jobs: POST a task, get `job_id`, server POSTs results to your callback URL when done. Decouples client lifetime from job lifetime.
- **gRPC streaming** — binary, bidirectional, low overhead; good for internal high-throughput service-to-service.
- **Server polling (the fallback)** — client polls a `/status/{job_id}` endpoint; simpler than webhooks but wasteful.

## Decision guide
- Short & bounded → REST.
- LLM chat, token-by-token UX → SSE.
- Duplex / real-time (voice, agents streaming tool calls back) → WebSocket.
- Long offline jobs (batch inference, fine-tunes, transcription) → webhooks.
- Internal high-throughput → gRPC.

## Mental model (architectural mindset)

The protocol choice is about **matching the call's time-shape to the client's patience**. If the client can't wait, stream (SSE) or callback (webhook). If it can, REST. Don't introduce WebSocket complexity for one-way streaming that SSE handles.

## Links

- [OpenAI streaming docs (SSE)](https://platform.openai.com/docs/api-reference/streaming) — the canonical SSE-for-LLMs example.
- [MDN — Server-Sent Events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events) — SSE fundamentals.
- [Webhooks vs polling (Stripe blog)](https://stripe.com/docs/webhooks) — production webhook patterns.
- [gRPC concepts](https://grpc.io/docs/what-is-grpc/core-concepts/) — streaming RPC.

## Related
- [[streaming-responses]], [[multi-user-context-concurrency]], [[hosted-model-apis]]
