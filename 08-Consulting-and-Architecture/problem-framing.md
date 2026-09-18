---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [consulting, problem-framing]
---

# Problem framing

> The biggest leverage is before any code: defining the right problem.

## Wide picture

Clients ask for solutions ("we need an AI chatbot"), not problems. The consultant's first job is to reverse-engineer the actual problem ("we spend too much staff time answering the same 30 questions"). Most "AI" requests are really automation, search, or data-quality problems in disguise. Framing correctly avoids building an expensive LLM system for something a rules engine + a search box would solve.

## Essentials

- **Listen for the problem behind the request** — "we need AI" → what outcome? what cost? what failure today?
- **Quantify the pain** — how many hours/errors/dollars? This sets the budget for the solution.
- **Define success in business terms** — "reduce repetitive FAQ load by 70%", not "build an LLM".
- **List constraints explicitly** — budget, latency, privacy, data availability, ops capacity, deadlines.
- **Scope the smallest valuable slice** — what's the thinnest thing that proves value? (the PoC-gated approach).
- **Name what's out of scope** — exclusions prevent scope creep (a good project plan does this explicitly).
- **Decide the technique class last** — only after the problem + constraints are clear. See [[heavy-ai-vs-simple]].

## Mental model (architectural mindset)

Problem framing is requirements engineering with a business lens. The deliverable is a crisp problem statement + success metric + constraints, not a tool choice. Get this signed off before touching tools.

## Links

- [Eugene Yan — problem framing](https://eugeneyan.com/machine-learning-system-design/) — applied.
- [The Mom Test (Fitzpatrick)](https://www.momtestbook.com/) — asking the right questions.

## Related
- [[heavy-ai-vs-simple]], [[consulting-deliverables]], [[architectural-mindset]]
