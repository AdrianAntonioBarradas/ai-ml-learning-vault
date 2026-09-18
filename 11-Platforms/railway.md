---
created: 2026-08-24
updated: 2026-08-24
last_reviewed: 2026-08-24
status: stable
tags: [platforms, railway, paas]
---

# Railway

> A PaaS: deploy services, workers, cron, and databases from a repo or Dockerfile with minimal config. The "everything else" platform for long-running or background processes.

## How it works (mental model)

You create a **project**, add **services** (from a GitHub repo, a Dockerfile, an image, or a template), and Railway builds + runs them as containers. Services get **variables**, **volumes** (persistent storage), and private **networking** within the project. You can provision managed **databases** (Postgres, Redis, MySQL) as add-ons. Usage is metered (CPU, RAM, egress) against a plan. Think of it as Heroku-like simplicity with container flexibility.

## Core building blocks

- **Project → Service → Deployment** — a service is one container; deployments are versioned revisions with rollback.
- **Variables / Secrets** — per-service and shared (service references). Never commit them.
- **Volumes** — persistent mounts for stateful services (tie a volume to a service; data survives redeploy).
- **Private networking** — services in a project talk via internal hostnames (e.g. `postgres:5432`).
- **Databases** — one-click Postgres/Redis/MySQL; connection strings in variables automatically.
- **Health checks / restart policies** — configure to avoid silent-dead services.
- **Environments** — dev/preview/prod within a project (separate variables + DBs).

## Strengths

- Fastest path from repo/Dockerfile to a running service; trivial workers/cron/daemons.
- Long-running processes allowed (unlike serverless) — ideal for queue consumers, schedulers, bots.
- Managed DBs + private networking in one place.
- Good DX: git push deploys, PR previews, CLI (`railway up`), web terminal/logs.
- Sensible for prototypes and small-to-medium production services.

## Cons / limits

- **No GPU / no heavy AI inference** — CPU only. Don't run LLM serving here. See [[03-Inference-Deployment/self-hosted-servers]].
- **Usage-based cost can runaway** — always-on services + egress + DB compute add up; set spending limits.
- **Free trial is not production** — trial credits expire; the free tier is limited (see Railway free-tier limits). Don't build a prod dependency on trial credits.
- Less mature than big-cloud for enterprise compliance, VPC peering, fine-grained IAM.
- Egress/region choices fewer than AWS/GCP; multi-region failover is not its strength.

## Common mistakes / misuse

- Treating the **free trial as a prod environment** (credits expire, resources reclaimed).
- Running **stateful services without a volume** → data loss on redeploy.
- Exposing a DB publicly when **private networking** should be used.
- Not setting **health checks** → silent crashes look "deployed but down".
- Ignoring **spending limits** → surprise bills from a runaway loop or noisy neighbor traffic.
- Putting secrets in the repo instead of Railway **variables**.

## Common problems & troubleshooting

- **Build fails** → check build logs, Dockerfile, build-time vs runtime variables, memory during build.
- **Deploy succeeds but service unhealthy** → health check path/port wrong; check logs via web terminal.
- **Can't reach DB** → use the internal hostname within the project; for external clients use the public connection string + pooler.
- **High cost** → audit always-on services, scale down CPU/RAM, enable sleep for non-prod, review egress.
- **OOM kills** → raise RAM, check for memory leaks, avoid loading huge files into memory.

## Admin-critical things

- **Secrets** — store in variables; use service references; rotate; never log.
- **Teams / RBAC** — invite teammates with appropriate roles; remove offboarded users.
- **Billing / spending limits** — set a cap and usage alerts; review invoices for orphan services.
- **Backups** — managed Postgres has backups; verify retention; for volume state, schedule your own backups (volumes aren't auto-backed up like the DB).
- **Observability** — use logs, metrics, deploy health; integrate external monitoring if needed.
- **Access control** — GitHub integration scope; least-privilege; SSO where available.
- **Environments hygiene** — keep prod variables/DBs separate from dev/preview.

## Questions to ask when unsure

- "Does this need to be long-running or is it a short request?" (long → Railway; short/edge → Vercel).
- "Is this stateful?" → attach a volume or use a managed DB.
- "What's the worst-case monthly cost?" → model CPU+RAM+egress before shipping.
- "Should this service be public or private within the project?" → default private.
- "What happens when it crashes?" → health check + restart policy + alerting.

## Courses & resources

- [Railway docs](https://docs.railway.com/) — start here; covers platform, services, variables, volumes, DBs.
- [Railway platform overview](https://docs.railway.com/platform) — mental model + use cases.
- [Railway use cases](https://docs.railway.com/platform/use-cases) — real deployment patterns.
- [15 Railway Tips (2026)](https://softverdict.com/railway-app-tips-tricks-2026/) — practical gotchas.
- [Railway free tier limits 2026](https://kuberns.com/blogs/railway-free-tier/) — what trial/free actually give.
- [Is Railway reliable for AI apps?](https://stackandsails.substack.com/p/railway-reliable-for-ai-apps-2026) — where it breaks for AI workloads.

## Related
- [[platforms-overview]], [[stack-integration]], [[08-Consulting-and-Architecture/cloud-selection]], [[03-Inference-Deployment/deployment-patterns-overview]]
