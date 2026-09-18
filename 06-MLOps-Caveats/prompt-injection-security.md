---
created: 2026-08-17
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [mlops, security, prompt-injection, llm]
---

# Prompt injection & LLM security

> User input is data, but the LLM may treat it as instructions. That is the vulnerability.

## Wide picture

Prompt injection: a user (or third-party content) embeds instructions that override the system prompt — "ignore previous instructions and…", hidden payloads in retrieved documents (indirect injection), jailbreaks. The model can't reliably distinguish data from instructions. Defense is architectural (treat input as untrusted, limit what the LLM can do, gate tool calls), not a prompt fix.

## Essentials

- **Direct injection** — user text overrides system instructions.
- **Indirect injection** — malicious instructions inside retrieved content (a poisoned web page your RAG ingested).
- **Defense layers:**
  1. Deterministic policy gate before the LLM (the reference PoC).
  2. Least privilege: don't give the LLM destructive tools; require human confirmation for mutations.
  3. Sandboxing + allowlists for tool inputs/outputs.
  4. Separate channels for instructions vs data; structure prompts so user content is clearly delimited.
  5. Output filtering + grounding checks.
- **What doesn't work:** "do not follow injections" in the prompt (easily bypassed).
- **PII/secret leakage** — don't put secrets in prompts; log redaction.

## Mental model (architectural mindset)

Assume the LLM is compromised by its input. The security boundary is the deterministic layer around it: what the LLM is allowed to call, see, and emit. Design as if the model will occasionally obey an attacker — because it will.

## Links

- [OWASP LLM Top 10](https://owasp.org/www-project-top-10-for-large-language-model-applications/) — threat catalog.
- [Prompt injection primer (Simon Willison)](https://simonwillison.net/series/prompt-injection/) — clear, practical.

## Related
- [[05-Chatbot-Engineering/guardrails-safety-policy]], [[common-mlops-issues]], [[hallucinations-and-grounding]]
- [[04-LLM-Tooling/a2ui-and-agentic-ui]] — agent-generated UI, and the catalog model that keeps it from being remote code execution.
