---
created: 2026-09-11
updated: 2026-09-11
last_reviewed: 2026-09-11
status: stable
tags: [inference, deployment, onnx, memory, containers, embeddings]
aliases: [ONNX memory footprint, embedding model in 1GB]
---

# Running an embedding model in a small container

> The weights are the small part. An ONNX session is ~660 MB resident before you embed anything, and embedding a corpus in one call can double it.

## Wide picture

Local embeddings are attractive: no third API key, no network hop on the read path,
deterministic vectors, zero per-query cost. The bill comes due as **resident memory**,
and PaaS tiers are commonly 512 MB–1 GB. The model file size tells you almost nothing
about it.

Measure before you size the container. `resource.getrusage(...).ru_maxrss` at a few
checkpoints takes five minutes and replaces a day of guessing.

## A measured profile

`paraphrase-multilingual-MiniLM-L12-v2` (384-dim, ~220 MB of weights) via fastembed,
CPU, 135 chunks:

| Stage | Peak RSS |
|---|---:|
| baseline Python | 34 MB |
| corpus + chunks parsed | 34 MB |
| ONNX session loaded | **667 MB** |
| embedding all 135 docs in one call | **1202 MB** ← OOM at a 1 GB limit |
| same corpus, batches of 8 | **708 MB** |
| one query afterwards | 708 MB |

Two separate costs: a large fixed session, and a spike proportional to batch size.

## Essentials

- **Cap intra-op threads.** onnxruntime allocates a memory *arena per thread* and
  defaults to one per vCPU. `threads=1` roughly halves the footprint on a 2-vCPU box
  and costs nothing when the index is small — searching 135 vectors takes ~4 ms
  single-threaded.
- **Batch the corpus embedding.** The one-shot spike is what kills you, and the corpus
  is embedded once at boot, so throughput is irrelevant. Batches of 8–16.
- **Bake the weights into the image at build time.** Otherwise the first request after
  a cold start pays the download, and a network failure presents as a user-facing
  timeout instead of a failed build.
- **Load at startup, not lazily.** In a lifespan/startup hook an OOM kill happens at
  boot where the healthcheck catches it and the deploy is not promoted. Lazily, it
  happens mid-request and looks like a 502 from an apparently healthy service.
- **Don't let the process manager re-resolve dependencies at boot.** `uv run` /
  `npm start` style wrappers may sync on every container start; invoke the interpreter
  in the venv directly.
- **Read the platform's memory metric during the crash.** "Usage 0.99987 GB against a
  0.99999 GB limit" names the problem in one line; logs showed only silent restarts.
- **The alternative is a hosted embeddings API** — tiny container, fast cold start,
  pennies at this scale, at the cost of a key, a network hop and non-determinism.
  A real tradeoff, not an obvious win either way.

## Mental model

An inference session is a *resident* cost, like a JVM heap — not a file you load and
free. Size the box for the session, then keep the transient spikes below the headroom
that's left.

## Links

- [onnxruntime — performance tuning](https://onnxruntime.ai/docs/performance/tune-performance/threading.html) — thread pools and arena allocation, the lever that matters most here.
- [fastembed](https://github.com/qdrant/fastembed) — ONNX embeddings without torch; `threads` and `batch_size` are the two knobs.
- [Railway — resource limits](https://docs.railway.com/reference/pricing/plans) — the kind of tier ceiling this note exists for.

## Related
- [[deployment-patterns-overview]] — hosted vs self-hosted, of which this is the cost detail.
- [[cost-latency-throughput]] — the other two corners of the same triangle.
- [[quantization-edge]] — the next lever if threads and batching are not enough.
- [[02-PoC-Techniques/vector-stores]] — what the vectors feed.
