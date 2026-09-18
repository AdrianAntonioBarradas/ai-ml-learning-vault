---
created: 2026-08-24
updated: 2026-08-24
last_reviewed: 2026-08-24
status: stable
tags: [platforms, overview, comparison]
---

# Platforms overview — Railway, Supabase, Vercel

> Three complementary platforms. Pick per workload; they compose into a common stack but each has a clear job.

## What each is

- **Vercel** — frontend hosting + edge network + serverless functions. Optimised for web apps, Next.js, previews, and fast global delivery. Not a traditional server.
- **Supabase** — managed PostgreSQL with Auth, Storage, Realtime, and Edge Functions around it. Your backend/data layer. Open-source Firebase alternative on Postgres.
- **Railway** — a PaaS: deploy services, workers, cron, databases from a repo or Dockerfile with minimal config. The "everything else" platform for long-running or background processes.

## Comparison

| | Vercel | Supabase | Railway |
|---|---|---|---|
| Core job | Frontend + serverless API | Postgres backend + auth | Deploy services/workers/DBs |
| Execution | Edge + serverless functions (Fluid Compute) | Postgres + Edge Functions | Containers (always-on / ephemeral) |
| Long-running tasks | No (timeout/size limits) | Edge Functions limited | Yes (workers, cron, daemons) |
| Database | None (bring your own) | Managed Postgres (core feature) | Managed Postgres/Redis/MySQL add-ons |
| Auth | Bring your own | Built-in (Auth + RLS) | Bring your own |
| Best for | Web UIs, SSR, previews | App backend + data | Background jobs, APIs, misc infra |
| Pricing shape | Usage + bandwidth overage | Per-project + usage | Usage (CPU/RAM/egress) |
| Heavy AI/GPU | No | No | No (CPU only) |

## When to pick which

- **Web frontend / SSR / API edge** → Vercel.
- **App database + auth + row security + realtime** → Supabase.
- **Workers, schedulers, long-lived processes, a quick API, a DB you control** → Railway.
- **Heavy AI inference / GPU** → none of these; see [[03-Inference-Deployment/self-hosted-servers]] (Vultr/Hetzner/RunPod) or a hosted API.
- **Simple stateless API prototype** → Railway or Vercel functions; see [[08-Consulting-and-Architecture/heavy-ai-vs-simple]].

## How they combine (the common stack)

See [[stack-integration]]: Vercel serves the frontend and calls Supabase (data/auth) and Railway (background workers / long tasks Vercel can't host). Each owns its concern; secrets and CORS bridge them.

## Mental model (admin)

Each platform optimises one layer and is weak outside it. As an admin you manage: **secrets per platform**, **billing/limits/quotas**, **observability**, **access/SSO/teams**, and **backups/DR**. The cross-platform concerns (env vars shared, networking, CORS, deploy ordering) are where most operational mistakes happen — see [[stack-integration]].

## Links

- [Railway docs](https://docs.railway.com/) — official.
- [Supabase docs](https://supabase.com/docs) — official.
- [Vercel docs](https://vercel.com/docs) — official.
- [How to Use Vercel in 2026](https://blog.reviewaitool.com/2026/05/20/how-to-use-vercel-2026-05201917/) — honest "use for X, pair for Y" framing.

## Related
- [[railway]], [[supabase]], [[vercel]], [[stack-integration]], [[08-Consulting-and-Architecture/cloud-selection]]
