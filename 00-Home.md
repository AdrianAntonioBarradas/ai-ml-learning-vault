---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [meta, moc, dashboard]
---

# 🏠 Home

Start here. This is the dashboard for the `ai-ml-learning-vault`. See [[00-About-this-Vault]] for the project idea and conventions.

## Sections

| Section | What it covers |
|---|---|
| [[MOC-Foundations]] | Applied-maths → ML bridge: linear algebra, probability, optimisation, learning paradigms, bias/variance, metrics |
| [[MOC-PoC-Techniques]] | Techniques extracted from a real chatbot PoC codebase, each tied to the file that implements it |
| [[MOC-Inference-Deployment]] | Industry digest: serving runtimes, API architectures, multi-user concurrency, cost/latency |
| [[MOC-LLM-Tooling]] | LangChain concepts, tools/agents, model & tokenizer standardisation |
| [[MOC-Chatbot-Engineering]] | Architecture, intent routing, RAG grounding, guardrails, evaluation (for building your own chatbot) |
| [[MOC-MLOps-Caveats]] | Hallucinations, drift, reproducibility, security, common pitfalls |
| [[MOC-Learning-Path]] | Roadmap, Hugging Face courses map, [[fundamentals-starter-pack]] of curated links |
| [[MOC-Consulting-Architecture]] | Problem framing, heavy-AI-vs-simple, cloud selection, architectural mindset |
| [[MOC-Web-to-Components]] | Design-to-code tools, component abstraction, AI-assisted frontend |
| [[MOC-Platforms]] | Admin-level Railway, Supabase, Vercel: how they work, gotchas, limits, stack integration |

## Start here (given an applied-maths + SWE background)

1. [[07-Learning-Path/fundamentals-starter-pack|Fundamentals starter pack]] — the minimal link set to build basic understanding.
2. [[02-PoC-Techniques/MOC-PoC-Techniques|PoC techniques]] — concrete techniques that anchor the abstractions.
3. [[08-Consulting-and-Architecture/heavy-ai-vs-simple|Heavy AI vs simple]] — the core decision intuition.
4. [[11-Platforms/platforms-overview|Platforms overview]] — master Railway, Supabase, Vercel.

## Needs review / stale

> Requires the **Dataview** community plugin (Settings → Community plugins → Browse → "Dataview"). Once enabled, the block below lists notes flagged `needs-review` or not reviewed in 90+ days.

```dataview
table last_reviewed, status, file.folder as section
where status = "needs-review" or last_reviewed < date(today) - dur(90 days)
sort last_reviewed asc
```

From the terminal instead: `just stale`.

## Recent log

See [[Review-Log]] for what changed and when.
