---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [chatbot, handoff, escalation]
---

# Human handoff & escalation

> Know when to stop automating, and hand off a clean summary so the human can act fast.

## Wide picture

A good chatbot escalates deliberately, not as a failure mode: sensitive cases, `H`-typed FAQs, low-confidence routes, missing entities, stale/contradictory content, and out-of-scope requests. The handoff must include a structured summary so the human doesn't re-ask everything.

## Essentials

- **When to escalate** — `H` cases, sensitive topics, confidence below threshold, ambiguous (low margin), missing required entities, stale/contradictory retrieval, complaints, exceptional cases.
- **Handoff summary** — program, interest, pending question, escalation reason (your plan spec). Structured, actionable.
- **User experience** — always offer "talk to a person"; set expectations; don't leave the user in limbo.
- **Context continuity** — pass the conversation transcript + extracted entities to the human agent.
- **Telemetry** — log every escalation + outcome; feed back into threshold tuning and content gaps.
- **Default safe** — when anything is uncertain, escalate rather than answer wrongly.

## Mental model

Escalation is a first-class feature, not a bug. Design the escalation path as carefully as the answer path; a poor handoff destroys trust faster than a wrong answer.

## Links

- [Conversational AI handoff patterns (Google Dialogflow)](https://cloud.google.com/dialogflow/es/docs/handoff) — patterns.

## Related
- [[guardrails-safety-policy]], [[intent-routing-design]], [[chatbot-evaluation]]
