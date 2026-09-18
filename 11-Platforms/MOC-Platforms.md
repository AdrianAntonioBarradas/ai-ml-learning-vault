---
created: 2026-08-24
updated: 2026-08-24
last_reviewed: 2026-08-24
status: stable
tags: [moc, platforms, paas]
---

# MOC — Platforms (Railway, Supabase, Vercel)

Admin-level understanding of three modern platforms that often form one stack: **Vercel** (frontend/edge + serverless), **Supabase** (managed Postgres + auth + storage + realtime), **Railway** (PaaS for workers, misc services, databases). Each note covers how it works, strengths, cons/limits, common mistakes, common problems, admin-critical things, questions to ask, and courses/resources.

## Notes
- [[platforms-overview]] — comparison + "when to pick which".
- [[stack-integration]] — how the three combine as a stack, shared concerns, when not to use the combo.
- [[railway]] — PaaS for services, workers, DBs.
- [[supabase]] — managed Postgres + Auth + Storage + Realtime + Edge Functions.
- [[vercel]] — frontend/edge + serverless functions, Fluid Compute, previews.

## Related
- [[08-Consulting-and-Architecture/cloud-selection]] — broader cloud decision matrix.
- [[03-Inference-Deployment/MOC-Inference-Deployment]] — where AI inference fits (and why these aren't for heavy GPU).
- [[06-MLOps-Caveats/deployment-pitfalls]] — generic deployment pitfalls that apply here too.
