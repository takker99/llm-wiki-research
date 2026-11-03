#!/bin/bash
# Simple lint script for LLM Wiki.
# Checks for orphan pages, open (unresolved) wikilinks, and index consistency.
# Run with: bash .agents/skills/llm-wiki-lint/scripts/lint.sh

set -euo pipefail
WIKI_DIR="$(cd "$(dirname "$0")/../../../.." && pwd)/wiki"

echo "=== LLM Wiki Lint ==="
echo ""

# Check for orphan pages (no inbound links from other wiki pages)
# sources/ pages: index.md listing does not count (unlinked source = not digested)
echo "--- Orphan pages (no inbound links) ---"
while read -r page; do
  [ -f "$page" ] || continue
  basename="$(basename "$page" .md)"
  # Count how many other wiki pages link to this page
  if [[ "$page" == "$WIKI_DIR"/sources/* ]]; then
    count=$(grep -rl --include="*.md" --exclude="$(basename "$page")" "\[\[${basename}\([\\|].*\)\?\]\]" "$WIKI_DIR"/concepts "$WIKI_DIR"/entities "$WIKI_DIR"/analyses "$WIKI_DIR"/sources 2>/dev/null | wc -l || true)
  else
    count=$(grep -rl --include="*.md" --exclude="index.md" --exclude="log.md" --exclude="overview.md" --exclude="$(basename "$page")" "\[\[${basename}\([\\|].*\)\?\]\]" "$WIKI_DIR" 2>/dev/null | wc -l || true)
  fi
  if [ "$count" -eq 0 ]; then
    echo "  ORPHAN: ${page#"$WIKI_DIR"/}"
  fi
done < <(find "$WIKI_DIR"/concepts "$WIKI_DIR"/entities "$WIKI_DIR"/analyses "$WIKI_DIR"/sources -name "*.md" 2>/dev/null | sort)
echo ""

# Check for open links (wikilinks whose target page does not exist yet) in wiki/.
# An open link is not a defect: it marks a place where the graph has no node yet.
# Classification by reference count is our operating rule, not a Cosense term:
#   1 page   = OPEN_LINK (1 page)  — check spelling/path form; leave it if intentional
#   2+ pages = OPEN_LINK (n pages) — virtual page / hub seed; candidate for page creation
# Open links never fail the run.
echo "--- Open links (unresolved wikilinks, classified by ref count) ---"
find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" -print0 | xargs -0 awk '
  /^```/ { inblock = !inblock; next }
  !inblock {
    line = $0
    gsub(/`[^`]*`/, "", line)
    while (match(line, /\[\[[^]]*\]\]/)) {
      print FILENAME "\t" substr(line, RSTART, RLENGTH)
      line = substr(line, RSTART + RLENGTH)
    }
  }
' \
  | sed 's/\[\[//;s/\]\]//' \
  | awk -F'\t' '{ split($2, a, "|"); sub(/\\$/, "", a[1]); print $1 "\t" a[1] }' \
  | sort -u \
  | awk -F'\t' '{ count[$2]++ } END { for (t in count) print count[t] "\t" t }' \
  | sort -rn \
  | while read -r count target; do
    # Skip non-file targets (URLs, external refs, empty)
    [[ "$target" == http* ]] && continue
    [ -z "$target" ] && continue
    found=$(find "$WIKI_DIR" -name "${target}.md" 2>/dev/null | head -1)
    if [ -z "$found" ]; then
      if [ "$count" -ge 2 ]; then
        echo "  OPEN_LINK ($count pages): [[${target}]] — virtual page / hub seed; candidate for page creation"
      else
        echo "  OPEN_LINK (1 page): [[${target}]] — check spelling or path form; leave it if intentional"
      fi
    fi
  done
echo ""

# Check same-line duplicate wikilinks within pages
# (detects accidental duplicates caused by batch replacement, e.g. [[PageA]]...[[PageA]] on the same line)
echo "--- Same-line duplicate wikilinks ---"
find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" -print0 | xargs -0 awk -v wiki_dir="$WIKI_DIR" '
  FNR == 1 {
    infm = 0; inblock = 0
    relpath = FILENAME
    if (index(relpath, wiki_dir "/") == 1) {
      relpath = substr(relpath, length(wiki_dir) + 2)
    }
  }
  {
    line = $0
    if (FNR == 1 && line == "---") { infm = 1; next }
    if (infm == 1 && line == "---") { infm = 2; next }
    if (infm == 1) next
    if (line ~ /^```/) { inblock = !inblock; next }
    if (inblock) next

    clean = line
    gsub(/`[^`]*`/, "", clean)
    work = clean
    delete count_on_line
    delete targets_on_line
    n_targets = 0

    while (match(work, /\[\[[^]]+\]\]/)) {
      m_start = RSTART; m_len = RLENGTH
      raw_link = substr(work, m_start + 2, m_len - 4)
      split(raw_link, parts, "|")
      sub(/\\$/, "", parts[1])
      target = parts[1]
      sub(/^[ \t\r\n]+/, "", target); sub(/[ \t\r\n]+$/, "", target)
      if (target != "" && target !~ /^http/) {
        if (++count_on_line[target] == 1) {
          targets_on_line[++n_targets] = target
        }
      }
      work = substr(work, m_start + m_len)
    }

    for (i = 1; i <= n_targets; i++) {
      t = targets_on_line[i]
      if (count_on_line[t] >= 2) {
        printf "  L%d: SAME_LINE_DUPLICATE x%d: [[%s]] in %s\n", FNR, count_on_line[t], t, relpath
      }
    }
  }
'
echo ""
# Known limitation: wikilinks containing https:// or # (URL/anchor targets)
# cannot be resolved to files by any classification above
echo "  NOTE: wikilinks containing https:// or # are not resolvable here — manual check at review is fine"
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

# Check that index.md entries point to existing files (stale entries)
# URL-encoded paths (e.g. %20 for spaces) are decoded before checking
echo "--- Stale index entries (target file missing) ---"
grep -E '^- \[' "$WIKI_DIR/index.md" \
  | grep -oE '\]\([^)]+\.md\)' \
  | sed -e 's/^](//' -e 's/)$//' -e 's/%20/ /g' \
  | sort -u \
  | while read -r rel; do
      [ -f "$WIKI_DIR/$rel" ] || echo "  STALE: $rel"
    done || true
echo ""

# Check that raw/ files referenced from wiki/ actually exist
# Inline code and fenced code blocks are stripped first (quoted design
# examples in analyses pages are not raw references)
echo "--- Missing raw files referenced from wiki/ ---"
find "$WIKI_DIR" -name "*.md" -print0 | xargs -0 awk '
  /^```/ { inblock = !inblock; next }
  !inblock { gsub(/`[^`]*`/, "", $0); print }
' \
  | grep -oE 'raw/[^])"'"'"'`\[,<>。、「」（）、→]+\.md' \
  | sort -u \
  | while read -r ref; do
    if [ ! -f "$(dirname "$WIKI_DIR")/$ref" ]; then
      echo "  MISSING RAW: $ref"
    fi
  done || true
echo ""

# Check that sources/ pages declare a pointer to the source in frontmatter
# (raw: path or source_url: — at least one is required)
echo "--- Sources pages without raw: or source_url: ---"
for page in "$WIKI_DIR"/sources/*.md; do
  [ -f "$page" ] || continue
  if ! grep -qE '^(raw|source_url):' "$page"; then
    echo "  NO POINTER: $page"
  fi
done
echo ""

# Check image links resolve, and no asset is unused
echo "--- Image links / unused assets ---"
find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" -print0 | xargs -0 awk '
  /^```/ { inblock = !inblock; next }
  !inblock {
    line = $0
    gsub(/`[^`]*`/, "", line)
    while (match(line, /!\[[^]]*\]\([^)]+\)/)) {
      m = substr(line, RSTART, RLENGTH)
      sub(/^!\[[^]]*\]\(/, "", m)
      sub(/\)$/, "", m)
      sub(/^[ \t]*</, "", m)
      sub(/>[ \t]*$/, "", m)
      sub(/[ \t]+["'\''].*$/, "", m)
      sub(/[?#].*$/, "", m)
      print FILENAME "\t" m
      line = substr(line, RSTART + RLENGTH)
    }
  }
' | while IFS=$'\t' read -r md img; do
  [ -n "$img" ] || continue
  [[ "$img" =~ ^https?:// ]] && continue
  [[ "$img" =~ ^data: ]] && continue
  dir=$(dirname "$md")
  if [ ! -f "$dir/$img" ]; then
    echo "  MISSING IMAGE: ${md#"$WIKI_DIR"/} -> $img"
  fi
done
if [ -d "$WIKI_DIR/assets" ]; then
  for f in "$WIKI_DIR"/assets/*; do
    [ -f "$f" ] || continue
    if ! grep -qr --include='*.md' "$(basename "$f")" "$WIKI_DIR"; then
      echo "  UNUSED ASSET: ${f#"$WIKI_DIR"/}"
    fi
  done
fi
echo ""

# Count wiki pages
total=$(find "$WIKI_DIR" -name "*.md" ! -name "index.md" ! -name "log.md" | wc -l)
echo "Total wiki pages: $total"
echo "=== Done ==="
