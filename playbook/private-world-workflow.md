# Private world workflow

Keep filled canon and shipping instances off the public framework repo while still using this clone for process and tooling.

## Problem

Root [`world/`](../world/) ships empty stubs (`_fill_` placeholders). That shape is correct for a public framework: cloners replace placeholders with their canon.

If you fill `world/` with real IP and push to public `main`, that canon becomes public and permanent in git history. [`projects/`](../projects/) instances are gitignored locally for the same reason.

## Model

| Location | Public `main` | Private fork / remote |
| --- | --- | --- |
| `templates/`, `playbook/`, `ai/`, `examples/` | Framework updates | Pull updates in |
| Root `world/` stubs | Stay empty | Fill with real canon |
| `projects/YYYY-MM-slug/` | Not committed | Commit freely |
| Demo content | [`examples/demo-world/`](../examples/demo-world/) only | Do not copy into root `world/` |

Public repo = framework product. Private fork = your studio bible and ships.

## Setup (first time)

### 1. Create a private duplicate repo

Public-repo forks are usually public. Use a separate private repo:

1. On GitHub, click **New repository**. Name example: `world-building-framework-private`. Set visibility to **Private**.
2. From your local clone, add it as remote `private` (step 2 below) and push `main` once.

**Note:** Private forks of public repos need GitHub Enterprise. Duplicate repo is the default path.

### 2. Configure two remotes (local clone)

From your working clone:

```bash
# Optional: rename default remote for clarity
git remote rename origin public

# Add private remote (SSH or HTTPS)
git remote add private git@github.com:YOUR_HANDLE/world-building-framework-private.git
```

Verify:

```bash
git remote -v
```

### 3. Push private baseline once

```bash
git push -u private main
```

Your private repo now mirrors public stubs. Fill canon on branches pushed to `private` only.

## Daily workflow

### Framework improvements (share publicly)

1. Branch from `public/main`.
2. Edit framework paths only (`playbook/`, `templates/`, `ai/`, validation, docs).
3. Keep root `world/` at stub level.
4. PR → merge to public `main`.

### Canon and shipping work (stay private)

1. Branch from `private/main`.
2. Fill `world/` and create `projects/YYYY-MM-slug/`.
3. Commit and push to `private` only:

```bash
git push private your-branch
```

4. Never open a PR from filled canon to public upstream.

### Sync framework updates into private work

When public `main` gains framework fixes:

```bash
git fetch public
git checkout main
git merge public/main   # or rebase if you prefer linear history
git push private main
```

Resolve conflicts in framework files. Prefer public versions for shared tooling; keep your canon in `world/` and `projects/`.

## Rules

1. **Do not** copy prose from [`examples/demo-world/`](../examples/demo-world/) (Harbor Line) into root `world/`. Read for density; write your own canon.
2. **Do not** paste thick `templates/` sections into `world/` (Purpose, Theory, AI Prompt, Review Checklist).
3. **Do not** commit secrets. See [`.gitignore`](../.gitignore) and [`SECURITY.md`](../SECURITY.md).
4. **Do not** force-push public `main`.
5. Record `inherits_canon` in project frontmatter when shipping. See [`CONVENTIONS.md`](../CONVENTIONS.md).

## Solo maintainer shortcut

If you only work locally and rarely push:

- Treat this directory as private until you push.
- Add `public` remote only when contributing framework changes upstream.
- Before any `git push public`, run `git diff public/main -- world/` and confirm no filled canon.

## Spinoffs and alternate timelines

For non-canon experiments: on public `main`, use branch `spinoff/<name>` only. On your private remote, you may also use `projects/` with `canon: false` frontmatter. See [`CONVENTIONS.md`](../CONVENTIONS.md) (Forks and spinoffs).

Do not merge spinoff lore into public `main` without explicit review.

## Checklist before pushing to public

- [ ] Root `world/` still stub-only (`_fill_` placeholders, no real lore)
- [ ] No files under `projects/` except [`projects/README.md`](../projects/README.md)
- [ ] No `.env`, keys, or tokens in diff
- [ ] `make validate` or `make validate-changed` passed

## Related docs

| Doc | Role |
| --- | --- |
| [`CONTRIBUTING.md`](../CONTRIBUTING.md) | Public PR rules |
| [`playbook/public-repo-governance.md`](public-repo-governance.md) | GitHub Settings |
| [`GETTING_STARTED.md`](../GETTING_STARTED.md) | Build phases P0 through P5 |
| [`world/README.md`](../world/README.md) | Stub shape and doc triad |
