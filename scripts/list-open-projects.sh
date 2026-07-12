#!/usr/bin/env bash
# List projects and inherits_canon vs governance CANON_VERSION
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

GOV_VER=""
if [[ -f world/00_governance/01_governance_ledger.md ]]; then
  # Portable parse: no \K (unsupported by some rg builds). Table cell = field 3.
  GOV_VER=$(awk -F'|' '
    /^\|[[:space:]]*CANON_VERSION[[:space:]]*\|/ {
      gsub(/^[[:space:]]+|[[:space:]]+$/, "", $3)
      print $3
      exit
    }
  ' world/00_governance/01_governance_ledger.md || true)
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
  inherits=$(awk '/^inherits_canon:/ { sub(/^inherits_canon:[[:space:]]*/, ""); gsub(/[[:space:]]+$/, ""); print; exit }' "$f")
  inherits=${inherits:-?}
  ptype=$(awk '/^project_type:/ { sub(/^project_type:[[:space:]]*/, ""); gsub(/[[:space:]]+$/, ""); print; exit }' "$f")
  ptype=${ptype:-?}
  flag=""
  if [[ -n "$GOV_VER" && "$inherits" != "$GOV_VER" && "$inherits" != "?" ]]; then
    flag=" <- STALE (canon is $GOV_VER)"
  fi
  echo "$dir  type=$ptype  inherits_canon=$inherits$flag"
done

if [[ "$found" -eq 0 ]]; then
  echo "No instantiated projects under projects/."
fi
