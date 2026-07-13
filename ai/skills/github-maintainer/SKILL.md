---
type: skill
name: github-maintainer
title: GitHub Maintainer
description: >-
  Own GitHub decisions for this public framework repo when the maintainer is
  new to GitHub or asks what to do with PRs, branch protection, Dependabot,
  forks, collaborators, or pushes to main. Use for any git/GitHub workflow
  question, open PR triage, conflicted merges, force-push requests, or repo
  settings. Do not wait for the user to choose among options they cannot
  evaluate. Decide safely, explain in one short block, then execute.
version: "1.0.0"
timestamp: 2026-07-12
---

# GitHub Maintainer

One job: keep this public framework repo (and local clones) safe when the human is not a GitHub expert.

**In scope:** PR triage, Dependabot, branch protection, push/merge flow, collaborator advice, history rewrites, setup script, private-world vs public-main decisions.

**Out of scope:** filling `world/` canon; inventing lore; unrelated coding tasks with no git/GitHub impact.

## Authority

| Doc / tool | Role |
| --- | --- |
| [`playbook/public-repo-governance.md`](../../../playbook/public-repo-governance.md) | Settings checklist |
| [`playbook/private-world-workflow.md`](../../../playbook/private-world-workflow.md) | Keep filled canon off public `main` |
| [`CONTRIBUTING.md`](../../../CONTRIBUTING.md) | PR workflow |
| [`scripts/github-repo-setup.sh`](../../../scripts/github-repo-setup.sh) | Apply / remove protection and settings |
| This skill | Decide and act when user cannot |

## Decision defaults (do not ask)

When the user says they do not know GitHub, or asks you to choose:

| Situation | Do this |
| --- | --- |
| Open Dependabot PR, CI green, **no conflicts** | Merge squash, delete branch |
| Open Dependabot PR **with conflicts** | Close it. Open fresh PR from current `main` with the same bump. Never merge a conflicted PR. |
| User wants change on `main` | Branch → push → PR → wait for `validate` green → squash merge. Never direct push while full protection is on. |
| User asks to "just push to main" | Use PR flow. Explain once: protection requires it. |
| Force-push to `main` needed (history rewrite) | `--remove-protection` → force-push with lease → `--protect-main`. Tell user before force-push. |
| Friend / teammate who is also new | Recommend **clone** or **private duplicate**. Do **not** grant Write on public repo unless they must merge framework PRs. |
| Filled world IP | Private remote only. Never commit filled root `world/` to public `main`. |
| Secret in a commit | Stop. Rotate secret. Do not push more. Plan history scrub separately. |

## Hard rules

1. **Never merge a conflicted PR.** Close or rebase onto current `main` first.
2. **Never** `--admin` merge to bypass failing CI. Fix CI.
3. **Never** disable branch protection permanently for convenience. Temporary remove → do the one thing → restore `--protect-main`.
4. **Never** leave the repo with an open conflicted PR "for the user to decide."
5. Prefer **one short explanation + action** over option menus.
6. After git/GitHub mutations: show `git status` / `gh pr list` outcome so the human knows it is done.

## Standard change flow

```bash
git checkout main && git pull
git checkout -b short/description
# edit
make validate
git add -A && git commit -m "Clear why message."
git push -u origin HEAD
gh pr create --fill
# wait for validate
gh pr merge --squash --delete-branch
git checkout main && git pull
```

## Setup script cheat sheet

```bash
./scripts/github-repo-setup.sh --apply-settings   # full defaults (includes --protect-main)
./scripts/github-repo-setup.sh --protect-main     # PR + validate required
./scripts/github-repo-setup.sh --protect-main-light  # force-push/delete block only
./scripts/github-repo-setup.sh --remove-protection   # temporary only
```

Default for this public repo: **full** protection.

## Tone to the user

- Caveman / short OK if they use that mode.
- No guilt. No "you should have known."
- Name the decision you made and why in one sentence.
- Do not invent a second GitHub policy outside this skill + governance playbook.
