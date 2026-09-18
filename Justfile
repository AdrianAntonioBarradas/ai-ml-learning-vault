# Convenience commands for the ai-ml-learning-lab Obsidian vault.
# Requires: hx (Helix), rg (ripgrep), find, sed, date (GNU).
# gh is required only for repo operations (push/pull).

default:
    @just --list

# Open the Home dashboard in Helix
home:
    hx 00-Home.md

# Open the project charter
about:
    hx 00-About-this-Vault.md

# Open the review log
log:
    hx Review-Log.md

# List all MOCs
toc:
    @rg -l 'tags:.*moc' --glob '*MOC*.md' .

# Full-text search across notes: just search "embedding"
search query:
    rg -i --no-heading -n '{{query}}' --glob '*.md' .

# Create a new note from the template: just new "my-note" "01-Foundations"
new name section='01-Foundations':
    #!/usr/bin/env bash
    set -euo pipefail
    path="{{section}}/{{name}}.md"
    if [ -f "$path" ]; then echo "already exists: $path"; exit 1; fi
    today=$(date +%Y-%m-%d)
    cp Templates/note-template.md "$path"
    sed -i "s/<created>/$today/; s/<updated>/$today/; s/<last_reviewed>/$today/" "$path"
    echo "created $path"
    hx "$path"

# Notes whose last_reviewed is older than N days (default 90) or missing.
stale days='90':
    #!/usr/bin/env bash
    set -euo pipefail
    cutoff=$(date -d "-{{days}} days" +%Y-%m-%d)
    echo "Notes last reviewed before $cutoff (or never):"
    while IFS= read -r f; do
      line=$(grep -m1 '^last_reviewed:' "$f" 2>/dev/null || true)
      lr="${line#last_reviewed:}"
      lr="${lr## }"            # strip leading spaces
      lr="${lr%% }"            # strip trailing spaces
      if [ -z "$lr" ] || [ "$lr" \< "$cutoff" ]; then
        printf '%-55s %s\n' "$f" "${lr:-NEVER}"
      fi
    done < <(find . -name '*.md' -not -path './.git/*' | sort)

# Update a note's last_reviewed + updated dates to today: just touch-note path/to/note.md
touch-note path:
    #!/usr/bin/env bash
    set -euo pipefail
    today=$(date +%Y-%m-%d)
    sed -i "s/^updated: .*/updated: $today/; s/^last_reviewed: .*/last_reviewed: $today/" "{{path}}"
    echo "stamped {{path}} -> $today"

# Check frontmatter and wikilinks (same check CI runs)
check:
    python3 scripts/check_vault.py
