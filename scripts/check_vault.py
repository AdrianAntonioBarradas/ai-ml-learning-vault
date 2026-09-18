#!/usr/bin/env python3
"""Vault checks: required frontmatter fields and wikilinks that resolve to a note."""
import pathlib, re, sys

REQUIRED = ("created", "updated", "last_reviewed", "status", "tags")
SKIP = {"README.md", "CONTRIBUTING.md", "CODE_OF_CONDUCT.md"}

files = [p for p in pathlib.Path(".").rglob("*.md") if not any(part.startswith(".") for part in p.parts)]
names = {p.stem for p in files}
paths = {p.with_suffix("").as_posix() for p in files}
errors = []

for p in files:
    if p.name in SKIP:
        continue
    text = p.read_text(encoding="utf-8")
    if p.parts[0] != "Templates":
        fm = re.match(r"^---\n(.*?)\n---\n", text, re.S)
        if not fm:
            errors.append(f"{p}: missing frontmatter")
        else:
            for key in REQUIRED:
                if not re.search(rf"^{key}:", fm.group(1), re.M):
                    errors.append(f"{p}: frontmatter missing '{key}'")
    for m in re.finditer(r"\[\[([^\]|#]+)", text):
        target = m.group(1).strip()
        if target not in names and target not in paths:
            errors.append(f"{p}: broken wikilink [[{target}]]")

print("\n".join(errors) or f"OK: {len(files)} notes checked")
sys.exit(1 if errors else 0)
