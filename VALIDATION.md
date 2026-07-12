# Validation

One command to verify markdown docs before merge or sign-off.

## Prerequisites

- bash
- python3
- ripgrep (`rg`)

## Run

Full repo:

```bash
./scripts/validate.sh
```

Changed files only (PR speed):

```bash
./scripts/validate.sh --changed
```

## Checks

| Check | Scope |
| --- | --- |
| Em/en dashes | All scanned markdown |
| Scaffold leak | `world/**` only (Purpose, Theory, AI Prompt, Review Checklist, APPLIES) |
| Banned slop words | Per [`reference/voice.md`](reference/voice.md) |
| Internal links | Relative markdown link targets must resolve inside repo |

Scanned paths: `world/`, `playbook/`, `ai/`, `templates/`, `examples/`, root docs. `theory/` excluded.

## CI

Pull requests touching scanned paths run the same script via [`.github/workflows/validate.yml`](.github/workflows/validate.yml).
