---
created: 2026-08-17
updated: 2026-08-17
last_reviewed: 2026-08-17
status: stable
tags: [consulting, cloud, aws, railway, vultr, architecture]
---

# Cloud selection

> Match the cloud to the workload, not the brand. Pricing, ops burden, and lock-in differ sharply.

## Wide picture

There is no "best cloud" — there's the right platform for a given workload, team, and budget. A GPU inference service, a stateless API, a managed Postgres, and an edge static site have different ideal homes. The decision drivers: workload type, cost structure, ops capacity, lock-in tolerance, and existing stack.

## Decision matrix (by workload)

| Workload | Good fit | Why |
|---|---|---|
| GPU LLM inference (self-hosted) | **Vultr/Hetzner** (GPU bare-metal), **RunPod/Lambda**, AWS EC2 (if in AWS) | GPU price/availability; Hetzner/Vultr cheap, AWS convenient if already there |
| Stateless API / small service | **Railway**, **fly.io**, **Render** | Zero-ops, git-deploy, cheap at small scale |
| Managed DB / full-stack app | **AWS** (RDS/Lambda), **GCP**, **Azure** | Managed services, IAM, compliance |
| Edge / static / global low-latency | **Cloudflare** (Workers/Pages), **Vercel** | CDN-edge, generous free tiers |
| Cheap CPU compute / data | **Hetzner**, **Vultr** | Best $/CPU; no frills |
| Everything-in-one enterprise | **AWS / GCP / Azure** | Breadth, compliance, support — at cost/complexity |

## Per-platform notes
- **AWS** — most services, most complexity, most lock-in, most compliance. Use when you need the breadth or are already in it.
- **Railway** — simplest dev-to-prod for small apps; great for prototypes/POCs; not for heavy GPU.
- **Vultr / Hetzner** — cheap compute/GPU, less managed; you carry more ops. Great cost/perf for self-hosted inference.
- **fly.io** — deploy apps close to users, simple, containers; good for multi-region stateless services.
- **Cloudflare** — edge compute + CDN + cheap; use for latency-sensitive edges and static frontends.
- **GCP / Azure** — strong where you need their specific services (Vertex AI, Azure OpenAI).

## Rules of thumb
- **Prototype on Railway/fly.io/Cloudflare** (low ops); **move to Vultr/Hetzner for self-hosted inference** when cost justifies; **use AWS/GCP/Azure** when you need managed breadth/compliance or are already committed.
- **Avoid lock-in unless it buys you something concrete.** Open standards ([[04-LLM-Tooling/model-standardization]]) keep exit cheap.
- **Cost = steady state × time + egress.** Egress fees are the hidden AWS/GCP tax; Vultr/Hetzner/Cloudflare are gentler.

## Mental model (architectural mindset)

Pick by workload + ops budget, not by hype. The "right" cloud minimises (cost + ops burden + lock-in risk) subject to your constraints. Re-evaluate quarterly — pricing/free tiers move (see [[Review-Log]] watchlist).

> For deep, admin-level notes on Railway, Supabase, and Vercel (how they work, gotchas, limits, stack integration), see [[11-Platforms/MOC-Platforms]].

## Links
- [AWS vs GCP vs Azure (comparisons)](https://www.cloudzero.com/blog/aws-vs-azure-vs-gcp/) — capability comparison.
- [Hetzner Cloud](https://www.hetzner.com/cloud) · [Vultr](https://www.vultr.com/) · [Railway](https://railway.app/) · [fly.io](https://fly.io/) · [Cloudflare](https://www.cloudflare.com/)
- [GPU pricing comparisons (RunPod/Lambda)](https://www.runpod.io/) — GPU market rates.

## Related
- [[architectural-mindset]], [[03-Inference-Deployment/deployment-patterns-overview]], [[03-Inference-Deployment/cost-latency-throughput]]
