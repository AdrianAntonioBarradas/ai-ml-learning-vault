# ai-ml-learning-vault

> 🇲🇽 **ES:** Un vault de Obsidian abierto para aprender IA, ML e ingeniería: intuición construida sobre matemáticas aplicadas e ingeniería de software, con mentalidad de arquitectura. Cada nota da el **panorama general + lo esencial + links curados** (la profundidad vive en los links). Las notas están en inglés; las contribuciones en español son bienvenidas. ¿Quieres colaborar? Lee [`CONTRIBUTING.md`](./CONTRIBUTING.md).

An open Obsidian vault for learning AI, ML, and engineering — building intuition on top of an applied-mathematics and software-engineering foundation, with an architectural mindset.

Each note gives the **wide picture + essentials + curated links** (depth lives in the links). Concepts in the [PoC techniques](./02-PoC-Techniques/MOC-PoC-Techniques.md) section are grounded in a real chatbot proof-of-concept codebase.

## Open as an Obsidian vault

1. `git clone https://github.com/AdrianAntonioBarradas/ai-ml-learning-vault.git`
2. Obsidian → **Open vault** → choose the cloned folder.
3. (Optional, for the stale-notes dashboard) Settings → Community plugins → Browse → install **Dataview**, then enable it. The `00-Home.md` query then lists notes needing review.

Plugins and themes are not bundled — install whatever you like; your local `.obsidian/` changes to workspace/plugin data are gitignored.

## Navigate with Helix (optional)

With the [`marksman`](https://github.com/artempyanykh/marksman) LSP installed, from the vault root:

```bash
hx            # or: just home
```

Useful keys:
- `gd` on a wikilink → jump to that note (marksman go-to-definition).
- `space+s` → document symbol outline (jump between headings in a lesson).
- `space+f` → fuzzy file picker across the vault.
- `space+/` → global (ripgrep) search across all notes.

## Convenience commands ([`just`](https://github.com/casey/just))

```bash
just home              # open the dashboard
just about             # open the project charter
just new "my-note" "01-Foundations"   # scaffold a new note from the template
just search "embedding"               # full-text search
just stale            # notes not reviewed in 90+ days
just toc              # list MOCs
```

## Staleness tracking

AI tooling changes fast. Every note carries `last_reviewed` in its frontmatter; `just stale` lists aging notes, and the Dataview block on `00-Home.md` surfaces them in Obsidian. Log changes in [`Review-Log.md`](./Review-Log.md).

## Sections

| Section | Topic |
|---|---|
| `01-Foundations` | Applied maths → ML |
| `02-PoC-Techniques` | Techniques from a real chatbot PoC (rules, classifier, semantic router, hybrid RAG) |
| `03-Inference-Deployment` | Serving runtimes, API architectures, multi-user concurrency |
| `04-LLM-Tooling` | LangChain, tools/agents, agent protocols, model standardisation |
| `05-Chatbot-Engineering` | Chatbot architecture, RAG, guardrails, evaluation |
| `06-MLOps-Caveats` | Hallucinations, drift, security, pitfalls |
| `07-Learning-Path` | Roadmap, Hugging Face courses map, curated starter pack |
| `08-Consulting-and-Architecture` | Problem framing, heavy-AI-vs-simple, cloud selection |
| `09-Web-to-Components` | Design-to-code, component abstraction |
| `11-Platforms` | Railway, Supabase, Vercel at admin level |

See [`00-About-this-Vault.md`](./00-About-this-Vault.md) for the full project idea and conventions.

## Contributing / Contribuir

PRs and issues are welcome — see [`CONTRIBUTING.md`](./CONTRIBUTING.md) and the [Code of Conduct](./CODE_OF_CONDUCT.md). Questions and broader ideas go to **Discussions**; broken or outdated links go to **Issues**.

## License

[MIT](./LICENSE) © 2026 Adrian Antonio Barradas
