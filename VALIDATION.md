# Validation

One command to verify markdown docs before merge or sign-off.

## Prerequisites

- bash
- python3
- ripgrep (`rg`)
- make (optional)

## Run

Full repo:

```bash
make validate
```

Changed files only (PR speed):

```bash
make validate-changed
```

Canon version and project inheritance:

```bash
make validate-canon
```

World-type status dashboard:

```bash
make world-dashboard
```

List open projects vs canon version:

```bash
make list-projects
```

Or run scripts directly from [`scripts/`](scripts/).

## Checks

| Check | Command | Scope |
| --- | --- | --- |
| Markdown prose | `make validate` | dashes, banned words, links, scaffold leaks |
| Projects | `make validate` | scaffold leak in `projects/*`, checklist gaps |
| Demo-world guard | `make validate-changed` | blocks edits to `examples/demo-world/world/` unless `ALLOW_DEMO_EDIT=1` |
| Canon drift | `make validate-canon` | governance vs frontmatter vs `inherits_canon` |
| World-type fit | `make world-dashboard` | required / recommended / skip_ok by profile |

Scanned paths: `world/`, `playbook/`, `ai/`, `templates/`, `examples/`, `projects/`, root docs. `theory/` excluded.

## CI

Pull requests touching scanned paths run `make validate` via [`.github/workflows/validate.yml`](.github/workflows/validate.yml).

## Pre-commit (optional)

Opt-in local hook before commit:

```bash
git config core.hooksPath .githooks
```

Runs `./scripts/validate.sh --changed` on staged markdown. Disable: `git config --unset core.hooksPath`.
