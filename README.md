# World-Building Treatise and Playbook

Cloneable studio bible. Build a world once. Ship from the same repo.

Covers fictional universes, brand worlds, creator IP, and tabletop settings. Same canon feeds stories, scripts, products, merch, marketing, social, games, and interactive work.

Primary user: small creative team / studio ops. Tone: dense reference docs. See [`WRITING.md`](WRITING.md) (prefer [`ai/skills/writing-standard`](ai/skills/writing-standard/SKILL.md)).

Validation: [`VALIDATION.md`](VALIDATION.md) (`make validate` or `./scripts/validate.sh`).

## Prerequisites

- bash, python3, ripgrep (`rg`), make (optional; for `make validate`)

## Five-minute start

1. Clone this repo.
2. Read [`GETTING_STARTED.md`](GETTING_STARTED.md). Follow phases P0 through P5.
3. Thin stubs already sit in `world/`. Replace `_fill_` sections. Do **not** copy thick `templates/` into `world/` to reset.
4. **P0:** Set world profile in [`world/00_governance/01_governance_ledger.md`](world/00_governance/01_governance_ledger.md) (type, hard/soft dial, owners).
5. **P1:** Fill [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md) and [`world/10_foundations/12_lore_canon.md`](world/10_foundations/12_lore_canon.md).
6. **P2 to P3:** Identity systems, then brand and channel (fiction/TTRPG may defer P3: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)).
7. **P4:** Copy scaffold to `projects/YYYY-MM-slug/`. Examples: [`examples/demo-project/`](examples/demo-project/).

Doc triad (stub, template, prompt): [`world/README.md`](world/README.md).

### Reset a world doc

Restore the committed thin stub (git checkout / discard local changes). Templates stay thick for process. World stays thin for canon.

AI workflows: [`AGENTS.md`](AGENTS.md) and [`ai/`](ai/).

## What lives where

| Path | Role |
| --- | --- |
| `theory/` | Research treatise. Cite. Not your canon. |
| `playbook/` | Process: world types, sequencing, shipping audit, notes→canon. |
| `templates/` | Thick scaffolding: Purpose, APPLIES, Theory, Example, prompt links, Review Checklist. Never fill as lasting canon. |
| `world/` | Thin filled bible. Frontmatter + fill sections only. Source of truth. |
| `projects/` | Shipping outputs. Inherit from `world/`. Do not duplicate lore. |
| `ai/` | Prompts, agents, vendored skills. |
| `examples/` | Demo world and notes scratch (non-authoritative). |
| `WRITING.md` | Writing standard entry point. |
| `reference/voice.md` | Shared prose rules (interaction + drafting). |
| `CONVENTIONS.md` | Naming, canon versioning, contribution, spinoffs. |
| `VALIDATION.md` | Markdown validation before merge. |

## Reading track (new collaborators)

1. [`GETTING_STARTED.md`](GETTING_STARTED.md) and [`playbook/world-types.md`](playbook/world-types.md)
2. [`examples/demo-world/`](examples/demo-world/) for fill density
3. [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md)
4. Fiction/TTRPG: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)
5. Theory: [`theory/`](theory/) when playbook cites it (not day one)

Orientation lives here and in `GETTING_STARTED.md`. Not duplicated into each world doc.

## Golden rule

Never create a new document if an edit to an existing one works. New docs only for distinct shipping outputs under `projects/`.
