#!/bin/bash
# Simple lint script for LLM Wiki.
# Checks for orphan pages, broken wikilinks, and index consistency.
# Run with: bash scripts/lint.sh

set -euo pipefail
WIKI_DIR="$(dirname "$0")/../wiki"

echo "=== LLM Wiki Lint ==="
echo ""

# Check for orphan pages (no inbound links from other wiki pages)
echo "--- Orphan pages (no inbound links) ---"
for page in "$WIKI_DIR"/concepts/*.md "$WIKI_DIR"/entities/*.md "$WIKI_DIR"/analyses/*.md; do
  [ -f "$page" ] || continue
  basename="$(basename "$page" .md)"
  # Count how many other wiki pages link to this page
  count=$(grep -rl "\[\[${basename}\]\]" "$WIKI_DIR" --include="*.md" 2>/dev/null | wc -l)
  if [ "$count" -eq 0 ]; then
    echo "  ORPHAN: $page"
  fi
done
echo ""

# Check for broken wikilinks in wiki/
echo "--- Broken wikilinks ---"
grep -roh '\[\[[^]]*\]\]' "$WIKI_DIR" --include="*.md" \
  | sed 's/\[\[//;s/\]\]//' \
  | sort -u \
  | while read -r target; do
    # Skip non-file targets (URLs, external refs)
    [[ "$target" == http* ]] && continue
    found=$(find "$WIKI_DIR" -name "${target}.md" 2>/dev/null | head -1)
    if [ -z "$found" ]; then
      echo "  BROKEN: [[${target}]]"
    fi
  done
echo ""

# Check that all pages in wiki/ appear in index.md
echo "--- Pages missing from index.md ---"
find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" \
  | while read -r page; do
    basename="$(basename "$page" .md)"
    if ! grep -q "$basename" "$WIKI_DIR/index.md"; then
      echo "  MISSING: $page is not in index.md"
    fi
  done
echo ""

# Count wiki pages
total=$(find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" | wc -l)
echo "Total wiki pages: $total"
echo "=== Done ==="
