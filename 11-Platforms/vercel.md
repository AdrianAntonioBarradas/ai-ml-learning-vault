---
created: 2026-08-24
updated: 2026-08-24
last_reviewed: 2026-08-24
status: stable
tags: [platforms, vercel, serverless, edge]
---

# Vercel

> Frontend hosting + edge network + serverless functions. Optimised for web apps, Next.js, previews, and fast global delivery. Not a traditional server.

## How it works (mental model)

Connect a repo; Vercel builds and deploys your frontend (Next.js, Astro, SvelteKit, etc.) to its edge network. Server-side code runs as **Vercel Functions** (serverless) under the **Fluid Compute** model, which keeps instances warm and scales to one to minimise cold starts. Every push gets a **preview deployment** with a URL; merges to main promote to production. It's a frontend/edge platform with serverless APIs, **not** a place for long-running processes or stateful servers.

## Core building blocks

- **Projects** — linked repo + build settings + env vars.
- **Deployments** — per-commit builds; preview + production promotions; instant rollback.
- **Vercel Functions** — serverless handlers (Fluid Compute); region-selectable.
- **Edge Middleware / Edge Functions** — run at the edge for routing, auth gates, rewrites.
- **Caching / ISR** — static generation, incremental static regen, edge cache.
- **Env vars** — development / preview / production scopes; secrets per environment.
- **Observability** — logs, runtime metrics, Real Experience Monitoring.

## Strengths

- Best-in-class frontend DX: git push → global deploy, PR previews, instant rollback.
- Excellent Next.js/React support + edge network for fast global delivery.
- Fluid Compute mitigates cold starts; "scale to one" keeps a warm instance.
- Strong caching/ISR → cheap, fast for content-heavy apps.
- Good team/SSO, integrations, and security knobs (DDoS protection, WAF).

## Cons / limits

- **No long-running processes** — function timeouts (per-plan); not for workers/daemons. Use Railway. See [[stack-integration]].
- **Function size (250MB)** and memory ceilings; heavy deps blow the limit.
- **Cold starts** still exist despite Fluid Compute; mitigated, not eliminated.
- **Usage-based overage** — bandwidth, function invocations, edge requests can stack at scale.
- **Vendor coupling** with Next.js features; porting a Next app elsewhere can hurt.
- Not a database; bring your own (Supabase fits — see [[stack-integration]]).

## Common mistakes / misuse

- **Treating it like a traditional server** — long tasks in functions → timeouts; move to Railway.
- **Putting secrets in the client bundle** (`NEXT_PUBLIC_*` exposes them) → only non-sensitive values there.
- **Ignoring region** → functions far from your DB/users add latency.
- **Heavy dependencies** → 250MB function size exceeded; split or trim.
- **Running DB queries per request without pooling** → exhausts your DB (use Supabase pooler).
- **Monorepo misconfiguration** → wrong root/build settings; set the app root explicitly.
- **Relying on function-local state** → serverless is ephemeral; use external state.

## Common problems & troubleshooting

- **Function timeout** → offload long work to Railway; raise plan timeout; use Fluid Compute. See [Vercel KB: timeouts](https://vercel.com/kb/guide/what-can-i-do-about-vercel-serverless-functions-timing-out).
- **250MB size exceeded** → trim deps, use external packages, move heavy logic out. See [Vercel KB: 250MB](https://vercel.com/kb/guide/troubleshooting-function-250mb-limit).
- **Cold-start latency** → enable Fluid Compute; keep functions warm; reduce import cost; choose the right region. See [Fluid cold starts](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts).
- **Env var not available** → check scope (dev/preview/production); rebuild after adding.
- **Build errors** → check build command, Node version, framework preset, install output.
- **Preview can't reach backend** → CORS/env for preview domain missing on Supabase/Railway.

## Admin-critical things

- **Env vars & preview secrets** — scope per environment; never expose secrets via `NEXT_PUBLIC_*`; rotate.
- **Billing / DDoS protection** — enable spending alerts and DDoS/WAF; understand overage triggers (bandwidth, invocations).
- **Teams / SSO** — org roles, SSO/SAML on paid plans; remove offboarded members.
- **Observability** — logs (retention per plan), runtime metrics, error tracking; integrate external monitoring for prod.
- **Framework vs raw functions** — prefer framework primitives (Next route handlers) over ad hoc raw functions for portability.
- **Access & deploy controls** — branch protections, required reviews, production deploy hooks guarded.
- **Backups** — Vercel is stateless; backups are your DB's job (Supabase PITR), not Vercel's.

## Questions to ask when unsure

- "Does this need to run longer than a request?" → yes → move to Railway.
- "Is this value safe to expose in the client bundle?" → if unsure, keep it server-side.
- "Which region should the function run in?" → near your DB and users.
- "Will this fit the function size/memory budget?" → estimate deps before building.
- "What's the cost if traffic spikes?" → model bandwidth + invocations + overage.

## Courses & resources

- [Vercel docs](https://vercel.com/docs) — official, start here.
- [Vercel Functions](https://vercel.com/docs/functions) — serverless model.
- [Fluid Compute](https://vercel.com/docs/fluid-compute) — how cold starts are mitigated.
- [Vercel Functions limits](https://vercel.com/docs/functions/limitations) — timeouts, size, memory.
- [Scale to one: how Fluid solves cold starts](https://vercel.com/blog/scale-to-one-how-fluid-solves-cold-starts) — the mechanism.
- [Vercel KB: function timeouts](https://vercel.com/kb/guide/what-can-i-do-about-vercel-serverless-functions-timing-out) — troubleshooting.
- [Vercel KB: 250MB limit](https://vercel.com/kb/guide/troubleshooting-function-250mb-limit) — troubleshooting.

## Related
- [[platforms-overview]], [[stack-integration]], [[supabase]], [[03-Inference-Deployment/streaming-responses]], [[03-Inference-Deployment/inference-api-architectures]]
