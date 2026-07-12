#!/usr/bin/env bash
# List projects and inherits_canon vs governance CANON_VERSION
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

GOV_VER=""
if [[ -f world/00_governance/01_governance_ledger.md ]]; then
  GOV_VER=$(rg -o '^\|\s*CANON_VERSION\s*\|\s*\K[^\|]+' world/00_governance/01_governance_ledger.md 2>/dev/null | head -1 | tr -d ' ' || true)
fi

echo "Governance CANON_VERSION: ${GOV_VER:-unknown}"
echo ""

if [[ ! -d projects ]]; then
  echo "No projects/ directory."
  exit 0
fi

found=0
for f in projects/*/PROJECT.md; do
  [[ -f "$f" ]] || continue
  found=1
  dir=$(dirname "$f")
  inherits=$(rg -o '^inherits_canon:\s*\K.+$' "$f" 2>/dev/null | head -1 | tr -d ' ' || echo "?")
  ptype=$(rg -o '^project_type:\s*\K.+$' "$f" 2>/dev/null | head -1 | tr -d ' ' || echo "?")
  flag=""
  if [[ -n "$GOV_VER" && "$inherits" != "$GOV_VER" && "$inherits" != "?" ]]; then
    flag=" <- STALE (canon is $GOV_VER)"
  fi
  echo "$dir  type=$ptype  inherits_canon=$inherits$flag"
done

if [[ "$found" -eq 0 ]]; then
  echo "No instantiated projects under projects/."
fi
