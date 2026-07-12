#!/usr/bin/env bash
# One-time GitHub repo hardening via gh CLI (branch protection on main).
# Manual UI steps: playbook/public-repo-governance.md
#
# Requires: gh auth login, repo admin on target repo.
#
# Usage:
#   ./scripts/github-repo-setup.sh           # apply settings
#   ./scripts/github-repo-setup.sh --dry-run # print payload only (no API call)
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DRY_RUN=0
if [[ "${1:-}" == "--dry-run" ]]; then
  DRY_RUN=1
fi

echo "GitHub repo setup for world-building-framework"
echo "Root: $ROOT"
echo ""

if ! command -v gh >/dev/null 2>&1; then
  echo "ERROR: gh CLI not found. Install: https://cli.github.com/" >&2
  exit 1
fi

if [[ "$DRY_RUN" -eq 0 ]]; then
  if ! gh auth status >/dev/null 2>&1; then
    echo "ERROR: gh not authenticated. Run: gh auth login" >&2
    exit 1
  fi
fi

REPO_JSON="$(gh repo view --json nameWithOwner,defaultBranchRef 2>/dev/null || true)"
if [[ -z "$REPO_JSON" ]]; then
  if [[ "$DRY_RUN" -eq 1 ]]; then
    REPO="OWNER/world-building-framework"
    BRANCH="main"
    echo "WARN: dry-run without gh auth; using placeholder $REPO"
  else
    echo "ERROR: could not resolve repo from current directory. Run from repo root with gh auth." >&2
    exit 1
  fi
else
  REPO="$(echo "$REPO_JSON" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["nameWithOwner"])')"
  BRANCH="$(echo "$REPO_JSON" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["defaultBranchRef"]["name"])')"
fi

echo "Target repo: $REPO"
echo "Default branch: $BRANCH"
echo ""

if [[ "$DRY_RUN" -eq 0 ]]; then
  ADMIN="$(gh api "repos/$REPO" --jq '.permissions.admin // false' 2>/dev/null || echo false)"
  if [[ "$ADMIN" != "true" ]]; then
    echo "ERROR: gh user lacks admin on $REPO. Branch protection PUT requires admin." >&2
    exit 1
  fi
fi

# Solo maintainer: require PR before merge, zero approvals, validate check required.
PROTECTION_JSON="$(cat <<EOF
{
  "required_status_checks": {
    "strict": true,
    "checks": [
      { "context": "validate" }
    ]
  },
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 0,
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false
  },
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false
}
EOF
)"

echo "== Branch protection =="
if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "[dry-run] gh api -X PUT repos/$REPO/branches/$BRANCH/protection --input - <<JSON"
  echo "$PROTECTION_JSON"
  echo "JSON"
else
  echo "$PROTECTION_JSON" | gh api \
    -X PUT \
    "repos/$REPO/branches/$BRANCH/protection" \
    --input -
  echo "Branch protection applied on $BRANCH."
fi

echo ""
echo "== Manual steps (UI only) =="
echo "Complete these in GitHub Settings. Full checklist:"
echo "  playbook/public-repo-governance.md"
echo ""
echo "1. Settings → Actions → General"
echo "   - Fork PRs: require approval for first-time contributors"
echo "   - Workflow permissions: read-only"
echo ""
echo "2. Settings → Code security and analysis"
echo "   - Secret scanning: enable"
echo "   - Push protection: enable"
echo "   - Dependabot alerts: enable"
echo ""
echo "3. Settings → General → Pull Requests"
echo "   - Squash merge: on"
echo "   - Delete head branches on merge: on"
echo ""
echo "4. Smoke test: open a PR from a branch; confirm 'validate' runs and direct push to $BRANCH is blocked."
echo ""
echo "Done."
