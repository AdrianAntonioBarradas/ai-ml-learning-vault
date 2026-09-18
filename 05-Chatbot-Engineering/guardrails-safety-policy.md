---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [chatbot, guardrails, safety, policy]
---

# Guardrails & safety policy

> Define what the bot must NOT do, and enforce it deterministically before any generation.

## Wide picture

A customer-information chatbot needs hard boundaries: no clinical advice, no unsupported claims, no cert/refund decisions, no revealing internal instructions. These are enforced as a **policy gate that runs first**, before routing or generation — not as a polite request in the prompt. Combine deterministic rules (keyword/scope checks) with sensitive-topic escalation.

## Essentials

- **Explicit exclusions** — clinical/diagnosis, crisis, financial/legal advice, unsupported prices/dates/promos, revealing system prompts.
- **Policy gate first** — `policy.evaluate_message` runs before routing (the reference PoC does this).
- **Scope check** — out-of-scope → default "I don't have that information" or escalate.
- **Sensitive-topic escalation** — medical emergency, legal, harassment → human handoff immediately.
- **Prompt-injection defense** — treat user input as untrusted data, not instructions; see [[06-MLOps-Caveats/prompt-injection-security]].
- **PII handling** — don't log raw sensitive content; redact or skip.
- **Defaults over guesses** — when in doubt, the safe fallback (clarify / escalate) wins.

## Mental model (SWE angle)

Guardrails are the input-validation + authorization layer of the chatbot. Put them in code, enforced before the LLM, and test them like security tests (red-team probes in your eval harness).

## Links

- [NeMo Guardrails (NVIDIA)](https://github.com/NVIDIA/NeMo-Guardrails) — programmable guardrails.
- [OWASP LLM Top 10](https://owasp.org/www-project-top-10-for-large-language-model-applications/) — threat catalog.

## Related
- [[human-handoff-escalation]], [[06-MLOps-Caveats/prompt-injection-security]], [[intent-routing-design]]
