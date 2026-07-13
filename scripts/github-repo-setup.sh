#!/usr/bin/env bash
# GitHub repo hardening helper.
#
# Usage:
#   ./scripts/github-repo-setup.sh                    # print help / checklist
#   ./scripts/github-repo-setup.sh --apply-settings   # merge, security, Actions, light main protection
#   ./scripts/github-repo-setup.sh --protect-main-light  # block force-push/delete only; direct push OK
#   ./scripts/github-repo-setup.sh --protect-main     # PR + validate gate (teams)
#   ./scripts/github-repo-setup.sh --remove-protection
#   ./scripts/github-repo-setup.sh --dry-run --apply-settings
#
# Requires: gh auth login, repo admin for apply flags.
# Docs: playbook/public-repo-governance.md
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

DRY_RUN=0
APPLY_SETTINGS=0
PROTECT_MAIN=0
PROTECT_MAIN_LIGHT=0
REMOVE_PROTECTION=0

usage() {
  echo "Usage: $0 [--dry-run] [--apply-settings | --protect-main-light | --protect-main | --remove-protection]" >&2
  exit 1
}

for arg in "${@:-}"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --apply-settings) APPLY_SETTINGS=1 ;;
    --protect-main-light) PROTECT_MAIN_LIGHT=1 ;;
    --protect-main) PROTECT_MAIN=1 ;;
    --remove-protection) REMOVE_PROTECTION=1 ;;
    -h|--help) usage ;;
    *) echo "ERROR: unknown arg: $arg" >&2; usage ;;
  esac
done

FLAGS=$((APPLY_SETTINGS + PROTECT_MAIN + PROTECT_MAIN_LIGHT + REMOVE_PROTECTION))
if [[ "$FLAGS" -gt 1 ]]; then
  echo "ERROR: use only one of --apply-settings, --protect-main-light, --protect-main, --remove-protection" >&2
  exit 1
fi

echo "GitHub repo setup for world-building-framework"
echo "Root: $ROOT"
echo ""

need_gh() {
  if ! command -v gh >/dev/null 2>&1; then
    echo "ERROR: gh CLI not found. Install: https://cli.github.com/" >&2
    exit 1
  fi
  if [[ "$DRY_RUN" -eq 0 ]] && ! gh auth status >/dev/null 2>&1; then
    echo "ERROR: gh not authenticated. Run: gh auth login" >&2
    exit 1
  fi
}

resolve_repo() {
  need_gh
  REPO_JSON="$(gh repo view --json nameWithOwner,defaultBranchRef 2>/dev/null || true)"
  if [[ -z "$REPO_JSON" ]]; then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      REPO="OWNER/world-building-framework"
      BRANCH="main"
      echo "WARN: dry-run without gh auth; using placeholder $REPO"
      return 0
    fi
    echo "ERROR: could not resolve repo. Run from repo root with gh auth." >&2
    exit 1
  fi
  REPO="$(echo "$REPO_JSON" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["nameWithOwner"])')"
  BRANCH="$(echo "$REPO_JSON" | python3 -c 'import json,sys; d=json.load(sys.stdin); print(d["defaultBranchRef"]["name"])')"
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
}

apply_settings() {
  resolve_repo

  SETTINGS_JSON="$(cat <<'EOF'
{
  "allow_squash_merge": true,
  "allow_merge_commit": false,
  "allow_rebase_merge": false,
  "delete_branch_on_merge": true,
  "has_wiki": false,
  "has_discussions": false,
  "has_issues": true,
  "security_and_analysis": {
    "secret_scanning": { "status": "enabled" },
    "secret_scanning_push_protection": { "status": "enabled" },
    "dependabot_security_updates": { "status": "enabled" }
  }
}
EOF
)"

  echo "== Repository settings (merge, features, security) =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PATCH repos/$REPO --input - <<JSON"
    echo "$SETTINGS_JSON"
    echo "JSON"
  else
    echo "$SETTINGS_JSON" | gh api -X PATCH "repos/$REPO" --input -
    echo "Patched merge strategy, features, secret scanning, push protection, Dependabot security updates."
  fi
  echo ""

  echo "== Dependabot alerts (vulnerability alerts) =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PUT repos/$REPO/vulnerability-alerts"
  else
    gh api -X PUT "repos/$REPO/vulnerability-alerts" 2>/dev/null || true
    echo "Dependabot alerts enabled (or already on)."
  fi
  echo ""

  echo "== Actions workflow permissions (read-only) =="
  WORKFLOW_JSON='{"default_workflow_permissions":"read","can_approve_pull_request_reviews":false}'
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PUT repos/$REPO/actions/permissions/workflow --input -"
    echo "$WORKFLOW_JSON"
  else
    echo "$WORKFLOW_JSON" | gh api -X PUT "repos/$REPO/actions/permissions/workflow" --input -
    echo "Workflow permissions: read-only."
  fi
  echo ""

  echo "== Fork PR workflow approval (first-time contributors) =="
  FORK_JSON='{"approval_policy":"first_time_contributors"}'
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PUT repos/$REPO/actions/permissions/fork-pr-contributor-approval --input -"
    echo "$FORK_JSON"
  else
    echo "$FORK_JSON" | gh api -X PUT "repos/$REPO/actions/permissions/fork-pr-contributor-approval" --input -
    echo "Fork PR approval policy: first_time_contributors."
  fi
  echo ""

  if [[ "$DRY_RUN" -eq 0 ]]; then
    echo "== Verify =="
    gh api "repos/$REPO" --jq '{
      allow_squash_merge,
      allow_merge_commit,
      allow_rebase_merge,
      delete_branch_on_merge,
      has_wiki,
      has_discussions,
      has_issues,
      security_and_analysis
    }'
    gh api "repos/$REPO/actions/permissions/workflow"
    gh api "repos/$REPO/actions/permissions/fork-pr-contributor-approval"
    echo ""
  fi
}

apply_light_protection() {
  LIGHT_JSON="$(cat <<'EOF'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": null,
  "restrictions": null,
  "required_linear_history": false,
  "allow_force_pushes": false,
  "allow_deletions": false,
  "block_creations": false,
  "required_conversation_resolution": false
}
EOF
)"
  echo "== Light branch protection (force-push + delete block; direct push OK) =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PUT repos/$REPO/branches/$BRANCH/protection --input -"
    echo "$LIGHT_JSON"
  else
    echo "$LIGHT_JSON" | gh api -X PUT "repos/$REPO/branches/$BRANCH/protection" --input -
    echo "Light protection on $BRANCH: force-push and branch delete blocked."
  fi
  echo ""
}

apply_full_protection() {
  PROTECTION_JSON="$(cat <<'EOF'
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
  echo "== Full branch protection (PR + validate; force-push blocked) =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X PUT repos/$REPO/branches/$BRANCH/protection --input -"
    echo "$PROTECTION_JSON"
  else
    echo "$PROTECTION_JSON" | gh api -X PUT "repos/$REPO/branches/$BRANCH/protection" --input -
    echo "Full protection on $BRANCH: PR required, validate check required, force-push blocked."
  fi
  echo ""
}

if [[ "$APPLY_SETTINGS" -eq 1 ]]; then
  apply_settings
  resolve_repo
  apply_full_protection
  echo "All changes to main go through a PR (including owner). Self-merge OK when CI is green."
  echo "Lighter option: $0 --protect-main-light"
  echo "Done."
  exit 0
fi

if [[ "$PROTECT_MAIN" -eq 1 || "$PROTECT_MAIN_LIGHT" -eq 1 || "$REMOVE_PROTECTION" -eq 1 ]]; then
  resolve_repo
fi

if [[ "$REMOVE_PROTECTION" -eq 1 ]]; then
  echo "== Remove branch protection =="
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] gh api -X DELETE repos/$REPO/branches/$BRANCH/protection"
  else
    gh api -X DELETE "repos/$REPO/branches/$BRANCH/protection" 2>/dev/null || echo "No branch protection on $BRANCH."
    echo "Branch protection removed on $BRANCH (if it existed)."
  fi
  echo ""
fi

if [[ "$PROTECT_MAIN_LIGHT" -eq 1 ]]; then
  apply_light_protection
  echo "Direct push to main still works. Force-push and branch delete blocked for all write access holders."
  echo "Done."
  exit 0
fi

if [[ "$PROTECT_MAIN" -eq 1 ]]; then
  apply_full_protection
  echo "All changes to main go through a PR. Self-merge OK when CI is green."
  echo "Done."
  exit 0
fi

echo "No apply flag given. Common commands:"
echo "  $0 --apply-settings       # full public-repo setup (includes full main protection)"
echo "  $0 --protect-main         # PR + validate gate on main"
echo "  $0 --protect-main-light   # force-push + delete block only (direct push OK)"
echo "  $0 --remove-protection    # remove all branch rules"
echo ""
echo "Full reference: playbook/public-repo-governance.md"
echo "Done."
