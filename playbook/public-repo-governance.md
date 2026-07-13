# Public repo governance

One-time GitHub Settings checklist for maintainers of this public framework repo. Run after clone or when hardening a new public remote.

Automated setup: `./scripts/github-repo-setup.sh --apply-settings` (merge, security, Actions, **full** `main` protection).

Most UI steps below are applied by `--apply-settings`. Use the UI only to verify or if an API call fails on your plan.

---

## Prerequisites

1. You are repo **Admin** on GitHub.
2. Install [GitHub CLI](https://cli.github.com/) and run `gh auth login`.
3. Default branch is `main`.
4. CI workflow exists: `.github/workflows/validate.yml` (job name: `validate`).

---

## 1. Branch protection on `main`

**Default (public framework):** `./scripts/github-repo-setup.sh --protect-main` or included in `--apply-settings`.

Requires a PR and green `validate` CI before merge. Blocks force-push and branch delete. Applies to owner and collaborators (`enforce_admins: on`). Zero approvals required: self-merge when CI passes.

| Setting | Full (default) | Light (optional) |
| --- | --- | --- |
| Require pull request | On | Off |
| Require status checks | On (`validate`) | Off |
| Allow force pushes | Off | Off |
| Allow deletions | Off | Off |
| Enforce for admins | On | On |

**Light option:** `./scripts/github-repo-setup.sh --protect-main-light` if you need direct push to `main`.

**Remove all rules:** `./scripts/github-repo-setup.sh --remove-protection`

**Path (verify):** Repo → **Settings** → **Branches** → rule for `main`.

---

## 2. Merge strategy

**Automate:** included in `./scripts/github-repo-setup.sh --apply-settings`

**Path (verify):** Repo → **Settings** → **General** → **Pull Requests**.

| Setting | Value |
| --- | --- |
| Allow squash merging | On |
| Allow merge commits | Off (optional; squash keeps history clean) |
| Allow rebase merging | Off (optional) |
| Always suggest updating pull request branches | On |
| Automatically delete head branches | On |

**Verify:** After merging a test PR, the source branch is gone and the merge commit (if squash) is a single commit on `main`.

---

## 3. GitHub Actions permissions

**Automate:** included in `./scripts/github-repo-setup.sh --apply-settings`

**Path (verify):** Repo → **Settings** → **Actions** → **General**.

| Setting | Value |
| --- | --- |
| Actions permissions | Allow all actions and reusable workflows (or restrict to verified creators if you prefer) |
| Fork pull request workflows | Require approval for first-time contributors |
| Fork pull request workflows in private repos | Read-only (N/A for public forks; leave default) |
| Workflow permissions | Read repository contents and packages permissions |
| Allow GitHub Actions to create and approve pull requests | Off |

**Verify:** Open a PR from a fork by a new account (or simulate). First workflow run should wait for maintainer approval.

---

## 4. Code security and secret scanning

**Automate:** included in `./scripts/github-repo-setup.sh --apply-settings`

**Path (verify):** Repo → **Settings** → **Code security and analysis** (or **Security** → **Configure**).

Enable every toggle available on your plan:

| Feature | Value |
| --- | --- |
| Dependency graph | On |
| Dependabot alerts | On |
| Dependabot security updates | On (optional) |
| Secret scanning | On |
| Push protection | On |

**Verify:** Settings page shows each feature as **Enabled**. Push protection blocks commits containing known secret patterns at push time.

**Note:** Some features require GitHub Advanced Security on private repos. Public repos get secret scanning on supported plans. Enable what your account tier exposes.

---

## 5. Dependabot version updates

**Path:** Repo file `.github/dependabot.yml` (committed in this repo).

Covers `github-actions` dependency bumps weekly. No npm/pip in this repo.

**Verify:** Repo → **Insights** → **Dependency graph** → **Dependabot** shows open or historical update PRs within a week.

---

## 6. Repository features

**Automate:** included in `./scripts/github-repo-setup.sh --apply-settings` (Issues on, Wiki and Discussions off)

**Path (verify):** Repo → **Settings** → **General** → **Features**.

| Feature | Recommended |
| --- | --- |
| Wikis | Off (docs live in repo) |
| Issues | On |
| Sponsorships | Your choice |
| Discussions | Off unless you want community Q&A |
| Projects | Your choice |

**Verify:** **Issues** tab visible on repo home. No empty Wiki tab unless you enabled it.

---

## 7. CODEOWNERS and review routing

**Path:** Committed file `CODEOWNERS` at repo root.

GitHub auto-requests review from listed owners on PRs that touch owned paths.

**Verify:** Open a test PR that edits `playbook/`. You should see a review request for `@jlewis54-star` (update handle if ownership changes).

---

## 8. Post-setup smoke test

1. Create branch `test/governance-check`.
2. Edit a markdown file under `playbook/`.
3. Run `make validate-changed` locally.
4. Push and open PR to `main`.
5. Confirm **validate** job runs and passes.
6. Merge via squash.
7. Confirm branch auto-deletes.

Delete or revert the test change if it has no lasting value.

---

## Maintenance cadence

| Task | Frequency |
| --- | --- |
| Review Dependabot PRs for Actions bumps | Weekly |
| Confirm branch protection still on `main` | After any Settings change |
| Audit collaborators | When team changes |
| Rotate credentials if secret scan alerts | Immediately |

---

## Related docs

| Doc | Role |
| --- | --- |
| `CONTRIBUTING.md` | PR workflow for contributors |
| `playbook/private-world-workflow.md` | Keep filled canon off public `main` |
| `SECURITY.md` | Vulnerability reporting |
