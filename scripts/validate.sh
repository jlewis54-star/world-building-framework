#!/usr/bin/env bash
# Markdown validation for the worldbuilding framework repo.
# Usage: ./scripts/validate.sh [--changed]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v rg >/dev/null 2>&1; then
  echo "ERROR: ripgrep (rg) is required. Install via package manager or https://github.com/BurntSushi/ripgrep" >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "ERROR: python3 is required for link checking." >&2
  exit 1
fi

CHANGED_ONLY=0
if [[ "${1:-}" == "--changed" ]]; then
  CHANGED_ONLY=1
fi

SCAN_DIRS="world playbook ai templates examples projects"
ROOT_DOCS="README.md GETTING_STARTED.md CONVENTIONS.md WRITING.md AGENTS.md VALIDATION.md"
BANNED_SCAN_DIRS="world playbook templates examples projects"

errors=0

fail() {
  echo "ERROR: $1" >&2
  errors=$((errors + 1))
}

should_scan() {
  local f="$1"
  case "$f" in
    theory/*) return 1 ;;
  esac
  local dir
  for dir in $SCAN_DIRS; do
    case "$f" in
      "$dir"/*) return 0 ;;
    esac
  done
  local doc
  for doc in $ROOT_DOCS; do
    [[ "$f" == "$doc" ]] && return 0
  done
  return 1
}

should_banned_scan() {
  local f="$1"
  case "$f" in
    theory/*|ai/*) return 1 ;;
  esac
  local dir
  for dir in $BANNED_SCAN_DIRS; do
    case "$f" in
      "$dir"/*) return 0 ;;
    esac
  done
  local doc
  for doc in $ROOT_DOCS; do
    [[ "$f" == "$doc" ]] && return 0
  done
  return 1
}

collect_files() {
  if [[ "$CHANGED_ONLY" -eq 1 ]]; then
    {
      git diff --name-only HEAD 2>/dev/null || true
      git diff --cached --name-only 2>/dev/null || true
      git ls-files --others --exclude-standard 2>/dev/null || true
    } | sort -u | while IFS= read -r f; do
      [[ -n "$f" && "$f" == *.md && -f "$f" ]] && echo "$f"
    done
  else
    local dir
    for dir in $SCAN_DIRS; do
      [[ -d "$dir" ]] && find "$dir" -name '*.md' -type f 2>/dev/null
    done
    local doc
    for doc in $ROOT_DOCS; do
      [[ -f "$doc" ]] && echo "$doc"
    done
  fi
}

check_em_dash() {
  local f="$1" line
  while IFS= read -r line; do
    fail "$f: em/en dash: $line"
  done < <(rg -n '[—–]' "$f" 2>/dev/null || true)
}

check_scaffold_leak() {
  local f="$1" line
  [[ "$f" != world/* ]] && return 0
  for pat in '^## Purpose' '^## Theory' '^## AI Prompt' '^## Review Checklist' '^\*\*APPLIES:\*\*'; do
    while IFS= read -r line; do
      fail "$f: scaffold leak ($pat): $line"
    done < <(rg -n "$pat" "$f" 2>/dev/null || true)
  done
}

check_banned_words() {
  local f="$1" word phrase line
  for word in leverage synergy robust seamless holistic utilize ensure delve; do
    while IFS= read -r line; do
      fail "$f: banned word ($word): $line"
    done < <(rg -ni "\\b${word}\\b" "$f" 2>/dev/null || true)
  done
  for phrase in 'circle back' 'touch base' 'low-hanging fruit' 'moving forward' 'at the end of the day' 'in conclusion' 'world-class' 'best-in-class' 'cutting-edge' 'game-changer' 'paradigm shift'; do
    while IFS= read -r line; do
      fail "$f: banned phrase ($phrase): $line"
    done < <(rg -ni "$phrase" "$f" 2>/dev/null || true)
  done
}

FILES=()
while IFS= read -r f; do
  [[ -n "$f" ]] && FILES+=("$f")
done < <(collect_files | sort -u)

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "No markdown files to validate."
  exit 0
fi

echo "Validating ${#FILES[@]} markdown file(s)..."

for f in "${FILES[@]}"; do
  should_scan "$f" || continue
  check_em_dash "$f"
  check_scaffold_leak "$f"
  should_banned_scan "$f" && check_banned_words "$f"
done

LINK_FILES=()
for f in "${FILES[@]}"; do
  should_scan "$f" && LINK_FILES+=("$f")
done

if [[ ${#LINK_FILES[@]} -gt 0 ]]; then
  if ! python3 "$ROOT/scripts/check_links.py" "${LINK_FILES[@]}"; then
    errors=$((errors + 1))
  fi
fi

if [[ "$errors" -gt 0 ]]; then
  echo ""
  echo "Validation failed with $errors error(s)."
  exit 1
fi

echo "Validation passed."
