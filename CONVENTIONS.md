# Conventions

Enforced norms for this framework. Studio ops reference.

Writing standard: [`WRITING.md`](WRITING.md). Prefer [`ai/skills/writing-standard`](ai/skills/writing-standard/SKILL.md). Zero em dashes. Zero banned slop words. Direct reference prose.

## Naming

| Asset | Pattern | Example |
| --- | --- | --- |
| World docs | `NN_snake_name.md` | `11_manifesto.md` |
| Folders (layers) | `NN_layer_name/` | `10_foundations/` |
| Projects | `YYYY-MM-slug/` | `2026-07-pilot-trailer/` |
| AI prompts | match doc id | `ai/prompts/11_manifesto.md` |
| Agents | kebab-case | `canon-consistency.md` |

Number prefixes are load-bearing. Do not rename without updating `playbook/sequencing.md` and all cross-links.

## Guide vs artifact

| Location | Shape | Rule |
| --- | --- | --- |
| `templates/` | Thick | Purpose, APPLIES, Theory, Example, prompt link, Review Checklist. Process home. Never lasting canon. |
| `world/` | Thin | Frontmatter + H1 + fill sections only. Filled bible. Source of truth. |
| `projects/` | Instance | Outputs inherit via links. No lore duplication. Instantiated projects strip scaffold the same way as world. |
| `playbook/`, `theory/`, `ai/` | Framework | Process and tooling. |

**Thin vs thick:** World stubs are thin. Templates are thick. Never `cp` templates into `world/` for reset. Reset = restore the committed thin baseline.

**Status tokens:**

| Token | Where | Meaning |
| --- | --- | --- |
| Frontmatter `status:` | `world/`, drafts | `draft` / `review` / `signed_off` / `skipped` |
| `**APPLIES:**` | `templates/` only | Which world types need this doc |

Do not put `**STATUS:**` or `**APPLIES:**` on world docs.

**Golden Rule:** Never create a new document if an edit to an existing one suffices. Update core `world/` docs when a fundamental rule changes. Create under `projects/` only for distinct standalone outputs.

## Canon versioning

1. `world/00_governance/01_governance_ledger.md` holds `CANON_VERSION` (semver: `MAJOR.MINOR`).
2. **MAJOR:** breaking lore, visual, or verbal rule change that invalidates prior shipped assets.
3. **MINOR:** additive timeline, characters, channel rules that do not contradict prior canon.
4. On MAJOR or meaningful MINOR: git tag `canon/vX.Y`.
5. Project frontmatter records `inherits_canon: X.Y` at kickoff.

### Frontmatter (recommended)

```yaml
---
doc_id: 11_manifesto
status: draft | review | signed_off | skipped
canon: true
canon_version: 0.1
owners: [name]
updated: YYYY-MM-DD
---
```

Spinoffs / non-canon experiments:

```yaml
canon: false
canon_label: legends
```

Pattern mirrors Lucasfilm 2014 Legends split: one continuity authority; explicit non-canon label for forks.

## Contribution / PR rules

1. PRs that change `11_manifesto` or `12_lore_canon` require named owner approval listed in governance.
2. Public-facing assets under `projects/` require a completed Shipping Ledger (`playbook/shipping-ledger.md`) in the PR description or attached checklist.
3. Do not commit competitor market analyses into `world/`. Anti-library only (`52_anti_library.md`).
4. Do not add rigid multi-month social calendars; use project blueprints.
5. Binary design files (`.fig`, fonts, audio) may live beside markdown with a relative path recorded in the matching doc. Prefer links to cloud sources of truth when binaries are large.
6. Do not reintroduce Purpose / Theory / AI Prompt / Review Checklist into `world/`.

## Forks and spinoffs

| Intent | Method |
| --- | --- |
| Team working copy | Clone; fill `world/` |
| Alternate timeline / what-if | Branch `spinoff/<name>` or folder under `projects/` with `canon: false` |
| Separate commercial IP | Fork repo; reset `CANON_VERSION` to `0.1`; rewrite governance owners |
| Soft archive of old continuity | Tag `canon/vX.Y`; mark superseded docs `status: archived` |

Spinoffs must not silently rewrite mainline `world/` on `main`. Merge lore upstream only through owned review.

## AI usage

- Canonical prompts live in `ai/prompts/`. Templates link to them. Do not inline-duplicate prompt bodies.
- Generate into thin `world/` fill sections (`status: draft`). Never paste scaffold into world.
- Run `ai/agents/canon-consistency.md` and `ai/agents/brand-friction.md` before `signed_off`.
- Humans own final canon. AI output is proposal, not authority.
- Drafted prose follows [`WRITING.md`](WRITING.md).
- Notes → canon: [`playbook/notes-to-canon.md`](playbook/notes-to-canon.md).
