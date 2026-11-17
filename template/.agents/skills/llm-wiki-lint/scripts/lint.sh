#!/bin/bash
# Simple lint script for LLM Wiki.
# Checks for orphan pages, open (unresolved) wikilinks, frontmatter completeness, and asset references.
# Run with: bash .agents/skills/llm-wiki-lint/scripts/lint.sh

set -euo pipefail
WIKI_DIR="$(cd "$(dirname "$0")/../../../.." && pwd)/wiki"

# All content pages, in every wiki/ subdirectory. log/index/overview are wiki-level
# bookkeeping files, not content pages.
content_pages() {
  find "$WIKI_DIR" -name "*.md" ! -name "log.md" ! -name "index.md" ! -name "overview.md" 2>/dev/null | sort
}

echo "=== LLM Wiki Lint ==="
echo ""

# Check for orphan pages (no inbound links from other wiki pages)
# All content pages in every subdirectory are scanned, so renamed/added
# directories (e.g. analyses -> decisions) keep working. On sources/ pages,
# zero inbound links also means an undigested source.
echo "--- Orphan pages (no inbound links) ---"
while read -r page; do
  [ -f "$page" ] || continue
  basename="$(basename "$page" .md)"
  # Escape BRE metacharacters so titles like "v1.2" or "C*" are matched literally
  escaped="$(printf '%s' "$basename" | sed 's/[][\\.*^$~]/\\&/g')"
  # Links resolve by basename regardless of directory and case, so accept an
  # optional "dir/" prefix and match case-insensitively.
  count=$(grep -rli --include="*.md" \
    --exclude="log.md" --exclude="index.md" --exclude="overview.md" \
    -e "\[\[\([^]|#]*/\)\?${escaped}\([\\|#].*\)\?\]\]" "$WIKI_DIR" 2>/dev/null \
    | grep -vxF -- "$page" | wc -l || true)
  if [ "$count" -eq 0 ]; then
    echo "  ORPHAN: ${page#"$WIKI_DIR"/}"
  fi
done < <(content_pages)
echo ""

# Check frontmatter completeness: summary on all content pages (one line),
# raw source pointer on sources pages (raw: or source_url:, at least one)
echo "--- Missing frontmatter keys ---"
while read -r page; do
  [ -f "$page" ] || continue
  if [ "$(head -1 "$page")" != "---" ]; then
    echo "  NO FRONTMATTER: $page"
    continue
  fi
  fm="$(awk 'NR==1{next} /^---$/{exit} {print}' "$page")"
  # summary must be a single non-empty line: comments, empty strings, block
  # scalars (| or >) and indented continuation lines all fail here.
  summary_ok="$(printf '%s\n' "$fm" | awk '
    BEGIN { q = sprintf("%c", 39) }
    /^summary:/ {
      found = 1
      val = $0
      sub(/^summary:[ \t]*/, "", val)
      sub(/[ \t]+$/, "", val)
      if (val ~ /^[|>][-+]?([ \t]+#.*)?$/) bad = 1
      first = substr(val, 1, 1)
      last = substr(val, length(val), 1)
      if ((first == "\"" && last == "\"") || (first == q && last == q)) {
        val = substr(val, 2, length(val) - 2)
      } else {
        sub(/[ \t]+#.*$/, "", val)
        if (val ~ /^#/) bad = 1
      }
      gsub(/[ \t]/, "", val)
      if (val == "") bad = 1
      check_next = 1
      next
    }
    check_next {
      if ($0 ~ /^[ \t]+[^ \t#]/) bad = 1
      check_next = 0
    }
    END { print (found && !bad) ? "ok" : "bad" }
  ')"
  [ "$summary_ok" = "ok" ] || echo "  MISSING/MULTILINE summary: $page"
  if [[ "$page" == "$WIKI_DIR"/sources/* ]]; then
    echo "$fm" | grep -qE '^(raw|source_url):' || echo "  MISSING raw/source_url: $page"
  fi
done < <(content_pages)
echo ""

# Check for open links (wikilinks whose target page does not exist yet) in wiki/.
# An open link is not a defect: it marks a place where the graph has no node yet.
# Classification by reference count is our operating rule, not a Cosense term:
#   1 page   = OPEN_LINK (1 page)  — check spelling/path form; leave it if intentional
#   2+ pages = OPEN_LINK (n pages) — virtual page / hub seed; candidate for page creation
# Open links never fail the run.
echo "--- Open links (unresolved wikilinks, classified by ref count) ---"
# Basename index for resolution: links resolve by basename, case-insensitively,
# so titles containing glob metacharacters (. * [ ] ?) are not a problem.
# A temp file of lowercased basenames keeps this working on bash 3.2 (no
# associative arrays) and on macOS find (no -printf).
BASENAME_INDEX="$(mktemp "${TMPDIR:-/tmp}/llm-wiki-basenames.XXXXXX")" || exit 1
trap 'rm -f "$BASENAME_INDEX"' EXIT
find "$WIKI_DIR" -name "*.md" 2>/dev/null | sort | while IFS= read -r path; do
  basename "$path" .md
done | tr '[:upper:]' '[:lower:]' | sort -u > "$BASENAME_INDEX"

find "$WIKI_DIR" -name "*.md" ! -name "log.md" -exec awk '
  /^```/ { inblock = !inblock; next }
  !inblock {
    line = $0
    gsub(/`[^`]*`/, "", line)
    while (match(line, /\[\[[^]]*\]\]/)) {
      print FILENAME "\t" substr(line, RSTART, RLENGTH)
      line = substr(line, RSTART + RLENGTH)
    }
  }
' {} + \
  | sed 's/\[\[//;s/\]\]//' \
  | awk -F'\t' '{ split($2, a, "|"); sub(/\\$/, "", a[1]); print $1 "\t" a[1] }' \
  | sort -u \
  | awk -F'\t' '{ count[$2]++ } END { for (t in count) print count[t] "\t" t }' \
  | sort -rn \
  | while read -r count target; do
    # Skip non-file targets (URLs, external refs, empty)
    [[ "$target" == http* ]] && continue
    [ -z "$target" ] && continue
    # Resolve like ORPHAN does: ignore any "dir/" prefix and "#anchor"
    lookup="${target##*/}"
    lookup="${lookup%%#*}"
    # Anchor-only links ([[#heading]]) point inside the same page, not to a file
    [ -z "$lookup" ] && continue
    lookup="$(printf '%s' "$lookup" | tr '[:upper:]' '[:lower:]')"
    if ! grep -Fxq -- "$lookup" "$BASENAME_INDEX"; then
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
find "$WIKI_DIR" -name "*.md" ! -name "log.md" -exec awk -v wiki_dir="$WIKI_DIR" '
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
' {} +
echo ""
# Known limitation: wikilinks containing https:// or # (URL/anchor targets)
# cannot be resolved to files by any classification above
echo "  NOTE: wikilinks containing https:// or # are not resolvable here — manual check at review is fine"
echo ""

# Check that raw/ files referenced from wiki/ actually exist
# Inline code and fenced code blocks are stripped first (quoted design
# examples in analyses pages are not raw references).
# Quoted paths may contain spaces (raw: "raw/my paper.pdf"); unquoted paths
# stop at whitespace so "raw/a.md と raw/b.md" stays two refs. Any known
# attachment extension is accepted, not just .md.
RAW_EXTENSIONS='md|pdf|txt|csv|tsv|json|ya?ml|html|epub|png|jpe?g|svg|webp|docx?|pptx?|xlsx?'
echo "--- Missing raw files referenced from wiki/ ---"
RAW_SCAN="$(mktemp "${TMPDIR:-/tmp}/llm-wiki-rawscan.XXXXXX")" || exit 1
trap 'rm -f "$BASENAME_INDEX" "$RAW_SCAN"' EXIT
find "$WIKI_DIR" -name "*.md" -exec awk '
  /^```/ { inblock = !inblock; next }
  !inblock { gsub(/`[^`]*`/, "", $0); print }
' {} + > "$RAW_SCAN"
{
  # Double-quoted path (may contain spaces)
  grep -oiE "\"raw/[^\"]+\.(${RAW_EXTENSIONS})\"" "$RAW_SCAN" | sed 's/^"//; s/"$//' || true
  # Single-quoted path (may contain spaces)
  grep -oiE "'raw/[^']+\.(${RAW_EXTENSIONS})'" "$RAW_SCAN" | sed "s/^'//; s/'\$//" || true
  # Unquoted path (no whitespace)
  grep -oiE "raw/[^][()\"'\`<>。、「」（）、→[:space:]]+\.(${RAW_EXTENSIONS})" "$RAW_SCAN" || true
} | sort -u \
  | while IFS= read -r ref; do
    [ -n "$ref" ] || continue
    if [ ! -f "$(dirname "$WIKI_DIR")/$ref" ]; then
      echo "  MISSING RAW: $ref"
    fi
  done
echo ""

# Check image links resolve, and no asset is unused
echo "--- Image links / unused assets ---"
find "$WIKI_DIR" -name "*.md" ! -name "log.md" -exec awk '
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
' {} + | while IFS=$'\t' read -r md img; do
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
total=$(find "$WIKI_DIR" -name "*.md" ! -name "log.md" | wc -l)
echo "Total wiki pages: $total"
echo "=== Done ==="
