#!/usr/bin/env bash
# GitHub repo hardening helper. Prints manual UI checklist by default.
# Optional branch protection for teams: --protect-main
#
# Manual UI steps: playbook/public-repo-governance.md
# Requires: gh auth login, repo admin (only for --protect-main).
#
# Usage:
#   ./scripts/github-repo-setup.sh              # checklist only
#   ./scripts/github-repo-setup.sh --protect-main   # apply PR + validate gate (teams)
#   ./scripts/github-repo-setup.sh --remove-protection  # delete branch protection on main
#   ./scripts/github-repo-setup.sh --dry-run [--protect-main|--remove-protection]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DRY_RUN=0
PROTECT_MAIN=0
REMOVE_PROTECTION=0

for arg in "${@:-}"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --protect-main) PROTECT_MAIN=1 ;;
    --remove-protection) REMOVE_PROTECTION=1 ;;
    *)
      echo "ERROR: unknown arg: $arg" >&2
      echo "Usage: $0 [--dry-run] [--protect-main | --remove-protection]" >&2
      exit 1
      ;;
  esac
done

if [[ "$PROTECT_MAIN" -eq 1 && "$REMOVE_PROTECTION" -eq 1 ]]; then
  echo "ERROR: use only one of --protect-main or --remove-protection" >&2
  exit 1
fi

echo "GitHub repo setup for world-building-framework"
echo "Root: $ROOT"
echo ""

if [[ "$PROTECT_MAIN" -eq 1 || "$REMOVE_PROTECTION" -eq 1 ]]; then
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
      echo "ERROR: gh user lacks admin on $REPO." >&2
      exit 1
    fi
  fi
fi

if [[ "$REMOVE_PROTECTION" -eq 1 ]]; then
  echo "== Remove branch protection =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X DELETE repos/$REPO/branches/$BRANCH/protection"
  else
    gh api -X DELETE "repos/$REPO/branches/$BRANCH/protection"
    echo "Branch protection removed on $BRANCH."
  fi
  echo ""
fi

if [[ "$PROTECT_MAIN" -eq 1 ]]; then
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
  echo "== Branch protection (PR required; for teams) =="
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
fi

echo "== Manual steps (GitHub UI) =="
echo "Full checklist: playbook/public-repo-governance.md"
echo ""
echo "Solo owner default: push directly to main. Skip branch protection unless you want PR gates."
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
echo "   - Squash merge: on (optional)"
echo "   - Delete head branches on merge: on (optional)"
echo ""
if [[ "$PROTECT_MAIN" -eq 0 && "$REMOVE_PROTECTION" -eq 0 ]]; then
  echo "Optional CLI:"
  echo "  $0 --remove-protection   # unblock direct push to main"
  echo "  $0 --protect-main        # require PR + validate check (teams)"
  echo ""
fi
echo "Done."
