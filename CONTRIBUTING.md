# Contribuir / Contributing

[Español](#español) · [English](#english)

---

## Español

¡Gracias por querer aportar! Este vault es un mapa de aprendizaje de IA/ML/ingeniería: cada nota da el panorama general, lo esencial y **links curados**. Toda ayuda cuenta: notas nuevas, links mejores, correcciones, traducciones o reportar links rotos.

### Formas de ayudar

- **Reportar** un link roto o una nota desactualizada → abre un *Issue*.
- **Proponer** una nota o sección nueva → abre un *Issue* o una *Discussion* antes de escribir mucho, así lo platicamos.
- **Preguntar** o debatir ideas → usa *Discussions*.
- **Enviar cambios** → Pull Request (ver abajo).

### Flujo para un Pull Request

1. Haz *fork* del repo y clónalo.
2. Crea una rama: `git checkout -b nota/nombre-corto`.
3. Crea la nota desde la plantilla: `just new "mi-nota" "05-Chatbot-Engineering"` (o copia `Templates/note-template.md`).
4. Revisa que todo esté bien: `just check` (o `python3 scripts/check_vault.py`).
5. Agrega una entrada breve con fecha en `Review-Log.md`.
6. Haz commit, push y abre el PR contra `main`. Llena el checklist de la plantilla.

Un mantenedor revisa cada PR. Puede que te pidamos ajustes; es normal. Los PRs se integran con *squash merge*.

### Convenciones

- **Frontmatter obligatorio:** `created`, `updated`, `last_reviewed` (fechas `AAAA-MM-DD`), `status` (`seed`/`draft`/`stable`/`needs-review`) y `tags`.
- **Links internos:** wikilinks de Obsidian (`[[carpeta/nota]]`), no links markdown. Deben apuntar a notas que existan (el CI lo verifica).
- **Links externos:** cada link lleva una línea que explique *por qué* vale la pena: `- [Título](url) — por qué`.
- **Estructura:** panorama general → esencial → modelo mental → links → relacionadas. Profundidad en los links, no en la nota.
- **MOCs:** si agregas una nota, enlázala desde el `MOC-*.md` de su sección.
- **Idioma:** las notas existentes están en inglés; se aceptan notas en español. Indícalo con el tag `spanish`.
- **Archivos:** un tema por nota, nombres en `kebab-case.md`.

### Qué NO subir

- Datos de clientes, empleadores, código privado o información confidencial de terceros.
- Secretos: tokens, API keys, contraseñas, `.env`.
- Tu configuración local de Obsidian (`.obsidian/workspace*.json`, datos de plugins); ya está en `.gitignore`.
- Contenido con copyright que no puedas redistribuir. Mejor enlázalo.

### Licencia

Al contribuir aceptas que tu aporte se publique bajo la [licencia MIT](./LICENSE) del proyecto.

---

## English

Thanks for wanting to help! This vault is a learning map for AI/ML/engineering: each note gives the wide picture, the essentials, and **curated links**. New notes, better links, fixes, translations and broken-link reports are all welcome.

### Ways to help

- **Report** a broken link or stale note → open an *Issue*.
- **Propose** a new note or section → open an *Issue* or *Discussion* before writing a lot, so we can align.
- **Ask** or discuss ideas → use *Discussions*.
- **Send changes** → Pull Request (below).

### Pull request workflow

1. Fork the repo and clone it.
2. Create a branch: `git checkout -b note/short-name`.
3. Scaffold the note from the template: `just new "my-note" "05-Chatbot-Engineering"` (or copy `Templates/note-template.md`).
4. Run the checks: `just check` (or `python3 scripts/check_vault.py`).
5. Add a short dated entry to `Review-Log.md`.
6. Commit, push, and open a PR against `main`. Fill in the template checklist.

A maintainer reviews every PR and may ask for changes. PRs are squash-merged.

### Conventions

- **Required frontmatter:** `created`, `updated`, `last_reviewed` (`YYYY-MM-DD`), `status` (`seed`/`draft`/`stable`/`needs-review`), and `tags`.
- **Internal links:** Obsidian wikilinks (`[[folder/note]]`), not markdown links. They must resolve to existing notes (CI checks this).
- **External links:** each one gets a one-line *why*: `- [Title](url) — why`.
- **Shape:** wide picture → essentials → mental model → links → related. Depth lives in the links.
- **MOCs:** link any new note from its section's `MOC-*.md`.
- **Language:** existing notes are in English; Spanish notes are welcome (tag them `spanish`).
- **Files:** one topic per note, `kebab-case.md` names.

### Do NOT commit

- Client/employer data, private code, or anyone's confidential information.
- Secrets: tokens, API keys, passwords, `.env` files.
- Your local Obsidian state (`.obsidian/workspace*.json`, plugin data); it is gitignored.
- Copyrighted material you can't redistribute. Link to it instead.

### License

By contributing, you agree that your contribution is licensed under the project's [MIT license](./LICENSE).
