#!/bin/bash
# Simple lint script for LLM Wiki.
# Checks for orphan pages, broken wikilinks, and index consistency.
# Run with: bash scripts/lint.sh

set -euo pipefail
WIKI_DIR="$(dirname "$0")/../wiki"

echo "=== LLM Wiki Lint ==="
echo ""

# Check for orphan pages (no inbound links from other wiki pages)
# sources/ pages: index.md listing does not count (unlinked source = not digested)
echo "--- Orphan pages (no inbound links) ---"
for page in "$WIKI_DIR"/concepts/*.md "$WIKI_DIR"/entities/*.md "$WIKI_DIR"/analyses/*.md "$WIKI_DIR"/sources/*.md; do
  [ -f "$page" ] || continue
  basename="$(basename "$page" .md)"
  # Count how many other wiki pages link to this page
  if [[ "$page" == "$WIKI_DIR"/sources/* ]]; then
    count=$(grep -rl "\[\[${basename}\]\]" "$WIKI_DIR"/concepts "$WIKI_DIR"/entities "$WIKI_DIR"/analyses "$WIKI_DIR"/sources --include="*.md" 2>/dev/null | wc -l || true)
  else
    count=$(grep -rl "\[\[${basename}\]\]" "$WIKI_DIR" --include="*.md" 2>/dev/null | wc -l || true)
  fi
  if [ "$count" -eq 0 ]; then
    echo "  ORPHAN: $page"
  fi
done
echo ""

# Check for broken wikilinks in wiki/ (skipping fenced code blocks)
echo "--- Broken wikilinks ---"
find "$WIKI_DIR" -name "*.md" -print0 | xargs -0 awk '
  /^```/ { inblock = !inblock; next }
  !inblock {
    while (match($0, /\[\[[^]]*\]\]/)) {
      print substr($0, RSTART, RLENGTH)
      $0 = substr($0, RSTART + RLENGTH)
    }
  }
' \
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

# Check that raw/ files referenced from wiki/ actually exist
echo "--- Missing raw files referenced from wiki/ ---"
grep -roE 'raw/[^])"'"'"'`\[,<>。、「」（）、→]+\.md' "$WIKI_DIR" --include="*.md" \
  | sed 's/.*://' \
  | sort -u \
  | while read -r ref; do
    if [ ! -f "$(dirname "$WIKI_DIR")/$ref" ]; then
      echo "  MISSING RAW: $ref"
    fi
  done
echo ""

# Check that sources/ pages declare their raw archive in frontmatter
echo "--- Sources pages without raw: field ---"
for page in "$WIKI_DIR"/sources/*.md; do
  [ -f "$page" ] || continue
  if ! grep -qE '^raw:' "$page"; then
    echo "  NO RAW: $page"
  fi
done
echo ""

# Count wiki pages
total=$(find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" | wc -l)
echo "Total wiki pages: $total"
echo "=== Done ==="
