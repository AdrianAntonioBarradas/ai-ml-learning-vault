---
created: 2026-08-24
updated: 2026-08-24
last_reviewed: 2026-08-24
status: stable
tags: [platforms, supabase, postgres, auth]
---

# Supabase

> Managed PostgreSQL plus Auth, Storage, Realtime, and Edge Functions. Your backend/data layer. Open-source Firebase alternative built on Postgres.

## How it works (mental model)

Each **project** is a dedicated Postgres database plus a set of services: **Auth** (JWT-based, with providers), **Storage** (S3-like with policies), **Realtime** (Postgres changes broadcast), **Edge Functions** (Deno, on the edge), and auto-generated **REST/GraphQL APIs** over your schema (via PostgREST/pg_graphql). Security is enforced by **Row Level Security (RLS)** policies in Postgres itself — the same DB that holds data enforces access. Two keys: `anon` (safe for clients, constrained by RLS) and `service_role` (bypasses RLS — server only, never in a browser).

## Core building blocks

- **Postgres** — the core; schemas, tables, functions, triggers, RLS.
- **Auth** — users, sessions, JWTs, OAuth providers, magic links; ties to `auth.users`.
- **RLS (Row Level Security)** — policies that gate rows per user/role; the security backbone.
- **Storage** — buckets + policies (auth-backed object access).
- **Realtime** — subscribe to row changes via websockets.
- **Edge Functions** — Deno functions for server-side logic near the edge.
- **APIs** — auto REST (PostgREST) + GraphQL from your schema.
- **Pooler (Supavisor)** — connection pooler for serverless clients.
- **Branching** — git-like DB branches for preview environments.

## Strengths

- Real Postgres — full SQL, extensions, functions, triggers; no proprietary lock-in on data.
- Built-in auth deeply integrated with RLS → secure client access without a custom backend.
- Auto APIs + Realtime accelerate full-stack dev.
- Open source; self-hostable if needed.
- Branching + CLI + migrations for proper DB workflow.

## Cons / limits

- **Free tier pauses idle projects** — not for always-on prod without paying; pauses can break integrations.
- **Connection exhaustion** — serverless clients can open too many PG connections; must use the **pooler**.
- **RLS is easy to get wrong** — a missing policy = data leak; policies can be slow if not indexed/kept simple.
- Edge Functions have size/runtime limits; not for heavy compute.
- Realtime has scale limits; not a magic infinite broadcast layer.
- Less hand-holding than Firebase; you're expected to understand Postgres.

## Common mistakes / misuse

- **Exposing `service_role` key in a client bundle** → full DB bypass; catastrophic. Server only.
- **Skipping RLS** on a table → anon can read/write everything.
- **Using direct PG connection from serverless** instead of the pooler → connection exhaustion.
- **Trusting `anon` key as secret** — it's not secret; safety comes from RLS, not the key.
- **N+1 via the auto REST API** → use embedded resources / views / functions for batches.
- **Ignoring indexes** on RLS policy columns → slow queries.
- **Client-side business logic** that should be a Postgres function or Edge Function.

## Common problems & troubleshooting

- **"My data is public"** → check RLS; enable policies; never rely on the key alone.
- **Auth issues** → JWT secret/expiry, provider redirect URLs, email templates, confirmation flow.
- **Too many connections** → switch to pooler connection string; use a single client in serverless.
- **Slow queries** → EXPLAIN, index policy columns, avoid `SECURITY DEFINER` misuse, add indexes on FKs.
- **Realtime not firing** → enable realtime for the table, check replication, check RLS for realtime.
- **Project paused** → upgrade or keep it active; handle gracefully in clients.

## Admin-critical things

- **RLS** — enable on every table; write explicit policies; test with both auth'd and anon roles.
- **Keys & JWT secret** — rotate; keep `service_role` out of clients; rotate JWT secret carefully (invalidates sessions).
- **Backups / PITR** — enable Point-In-Time Recovery on prod; verify restore; export schemas regularly.
- **Observability** — logs, query stats (`pg_stat_statements`), project health, API analytics.
- **Project pause** — don't let prod sit idle on free; budget for always-on.
- **Branching & migrations** — use the CLI + migrations; review schema changes before prod.
- **Access / SSO** — org/team roles; least privilege; remove stale members.

## Questions to ask when unsure

- "Can the client do this safely under RLS, or does it need `service_role` on the server?"
- "Is this table covered by RLS policies?" (default: assume no until verified)
- "Am I using the pooler for serverless connections?"
- "What's the worst case if the project pauses?" → budget for always-on in prod.
- "Is this query going to scale?" → EXPLAIN + index policy columns.

## Courses & resources

- [Supabase docs](https://supabase.com/docs) — official, start here.
- [Supabase for beginners](https://supabase.com/solutions/beginners) — official intro.
- [Best Supabase courses 2026 (Scrimba)](https://scrimba.com/articles/best-supabase-courses-and-tutorials-2026/) — course comparison.
- [Supabase RLS guide 2026](https://www.agilesoftlabs.com/blog/2026/06/supabase-row-level-security-guide/) — real examples.
- [Supabase security best practices](https://supaexplorer.com/guides/supabase-security-best-practices) — RLS, keys, auth, storage.
- [Common Supabase mistakes](https://www.coddykit.com/pages/blog-detail?id=512539&slug=navigating-the-pitfalls) — pitfalls + fixes.
- [Best practices: security, scaling, maintainability](https://leanware.co/insights/supabase-best-practices) — ops guide.

## Related
- [[platforms-overview]], [[stack-integration]], [[vercel]], [[06-MLOps-Caveats/prompt-injection-security]], [[05-Chatbot-Engineering/guardrails-safety-policy]]
