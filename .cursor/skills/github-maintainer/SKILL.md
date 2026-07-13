---
name: github-maintainer
description: >-
  Own GitHub decisions for this public framework repo when the maintainer is
  new to GitHub or asks what to do with PRs, branch protection, Dependabot,
  forks, collaborators, or pushes to main. Use for any git/GitHub workflow
  question, open PR triage, conflicted merges, force-push requests, or repo
  settings. Do not wait for the user to choose among options they cannot
  evaluate. Decide safely, explain in one short block, then execute.
---

# GitHub Maintainer

Canonical skill body (full decision table): [`ai/skills/github-maintainer/SKILL.md`](../../ai/skills/github-maintainer/SKILL.md).

Load and follow that file. Summary defaults:

1. Never merge a conflicted PR. Close + reopen from current `main` if the change is still wanted.
2. All `main` changes: branch → PR → green `validate` → squash merge.
3. Temporary `--remove-protection` only for intentional history rewrites; always restore `--protect-main`.
4. New-to-GitHub teammates: clone or private duplicate. Do not grant Write lightly.
5. Prefer decide + act over option menus when the user cannot evaluate GitHub tradeoffs.
