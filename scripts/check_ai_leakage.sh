#!/usr/bin/env bash
# Block identity and employer leakage in ai/ kit.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v rg >/dev/null 2>&1; then
  echo "ERROR: ripgrep (rg) required" >&2
  exit 1
fi

ALLOWLIST="$ROOT/scripts/leakage-allowlist.txt"
errors=0

fail() {
  echo "LEAKAGE: $1" >&2
  errors=$((errors + 1))
}

is_allowlisted() {
  local file="$1" line="$2"
  [[ -f "$ALLOWLIST" ]] || return 1
  while IFS= read -r pat; do
    [[ -z "$pat" || "$pat" == \#* ]] && continue
    if [[ "$file" == *"$pat"* ]] || [[ "$line" == *"$pat"* ]]; then
      return 0
    fi
  done < "$ALLOWLIST"
  return 1
}

PATTERNS=(
  'Josh'
  'joshlewis'
  'jlewis'
  '/Users/joshlewis'
  '\bAmazon\b'
  '\bAWS\b'
  'SFDC'
  'Salesforce'
  'Leadership Principles'
  'CoWork'
  'MEDDPICC'
  '_staging/'
  'intake/thinking'
  '~/.quickwork'
  'quick-local'
  'w\.amazon\.com'
  'oneillor'
  'ui-ux-master'
  'marketplace-shop'
)

echo "Checking ai/ for leakage patterns..."

while IFS= read -r f; do
  [[ -z "$f" ]] && continue
  for pat in "${PATTERNS[@]}"; do
    while IFS= read -r line; do
      is_allowlisted "$f" "$line" && continue
      fail "$f ($pat): $line"
    done < <(rg -n "$pat" "$f" 2>/dev/null || true)
  done
done < <(find ai -type f \( -name '*.md' -o -name '*.json' \) 2>/dev/null | sort)

if [[ "$errors" -gt 0 ]]; then
  echo ""
  echo "Leakage check failed with $errors hit(s)."
  exit 1
fi

echo "Leakage check passed."
