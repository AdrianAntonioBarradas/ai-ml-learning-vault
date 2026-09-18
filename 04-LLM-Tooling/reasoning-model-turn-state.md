---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [llm, tool-use, reasoning, providers, agents, gotcha]
aliases: [thought signature, thinking blocks, opaque turn state]
---

# Reasoning models attach state to a turn — replay it unchanged

> When a reasoning model calls a tool, its turn carries provider state you must hand back verbatim. Rebuild the turn from text and you break the *next* request, not this one.

## Wide picture

The classic agent loop rebuilds the assistant turn from what you understood of it:
some text, plus a list of tool calls. That worked when a turn was only text and tool
calls. Reasoning models attach opaque state to the turn — a signature, a thinking
block — and require it back on the following request. Reconstructing the turn silently
drops it.

The failure is nasty because it is **delayed and misattributed**: turn one succeeds,
the tool runs fine, and the error surfaces on turn two pointing at a field you never
knowingly handled.

## Essentials

- **Gemini 3** attaches `extra_content.google.thought_signature` to each function call
  and rejects the follow-up with `Function call is missing a thought_signature in
  functionCall parts`.
- **Anthropic** returns `thinking` blocks on the assistant turn when adaptive thinking
  is on; they must be replayed unchanged alongside the tool results.
- **The general rule:** an assistant turn is the provider's artifact, not yours. Store
  the provider's own representation and replay it; do not re-serialise from your
  parsed view.
- **One mechanism covers every provider.** Give your message type a `provider_raw`
  field (and tool calls a `provider_extra`), have the adapter fill it, and have the
  loop move it around without interpreting it. A new provider's requirement then costs
  nothing above the adapter.
- **Do not disable thinking to dodge this.** On current models it has its own failure
  modes, including tool calls written into visible text. Lower the effort instead.
- Related shape: **caching**. Reasoning state and prompt caching both punish rebuilding
  a prefix you should have preserved byte for byte.

## Mental model

Think of the assistant turn as an opaque blob with a text view, not as text you can
reconstruct. You are allowed to *read* it; you are not allowed to *rewrite* it and
hand it back.

## Links

- [Anthropic — extended thinking with tool use](https://docs.claude.com/en/docs/build-with-claude/extended-thinking) — the replay rules for thinking blocks.
- [Gemini API — thought signatures](https://ai.google.dev/gemini-api/docs/thinking) — what the signature is and when it is required.

## Related
- [[langchain-tools-and-agents]] — the loop this breaks if the abstraction hides the raw turn.
- [[open-responses-protocol]] — `reasoning` is a first-class item type there.
- [[06-MLOps-Caveats/common-mlops-issues]] — delayed, misattributed failures as a class.
