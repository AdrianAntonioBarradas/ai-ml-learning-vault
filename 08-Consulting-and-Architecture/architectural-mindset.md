---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [consulting, architecture, mindset, tradeoffs]
---

# Architectural mindset

> Think in tradeoffs, not tools. Every choice trades one good for another; make the trade explicit.

## Wide picture

The architectural mindset is the meta-skill: choosing *what* to build and *how it fits*, before *how to build it*. It's reasoning about the cost/latency/reliability triangle, build-vs-buy, coupling vs flexibility, and prototype-vs-production — and making those tradeoffs explicit so they can be reviewed and reversed.

## Essentials

- **The triangle:** cost ↔ latency ↔ reliability/quality. You rarely improve all three; state which you're prioritising and which you're sacrificing.
- **Build vs buy:** buy (hosted API/SaaS) for speed and low fixed cost; build (self-host) for amortised cost + control. Match to traffic shape + ops capacity.
- **Coupling vs flexibility:** tight coupling is fast to build, slow to change; clean boundaries (see [[02-PoC-Techniques/clean-architecture-protocols]]) cost now, pay later.
- **Prototype vs production:** a POC proves feasibility cheaply; don't ship the POC, extract the architecture. (The PoCs in this vault do exactly this via gates.)
- **Reversibility:** prefer reversible decisions (DB choice behind an interface) and spend care on irreversible ones (data model, privacy architecture).
- **NFRs are requirements:** latency, cost, security, observability are first-class, not optimisations.
- **Simplest sufficient:** always ask "what's the simplest thing that meets the bar?" — see [[heavy-ai-vs-simple]].

## Mental model

Architecture = making tradeoffs explicit and binding them at the right boundary. The value isn't picking the "best" tool; it's knowing which constraint you're honouring, which you're bending, and where the seams are so you can change later.

## Links
- [Fundamental Lessons in Systems Design (Eugene Yan)](https://eugeneyan.com/machine-learning-system-design/) — tradeoffs applied.
- [The System Design Primer](https://github.com/donnemartin/system-design-primer) — broad fundamentals.
- [A Philosophy of Software Design (Ousterhout)](https://web.stanford.edu/~ouster/cgi-bin/book.php) — deep modules, seams.

## Related
- [[heavy-ai-vs-simple]], [[cloud-selection]], [[problem-framing]], [[06-MLOps-Caveats/common-mlops-issues]]
