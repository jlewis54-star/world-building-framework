# World-Building Treatise and Playbook

Cloneable studio bible. Build a world once. Ship from the same repo.

Covers fictional universes, brand worlds, creator IP, and tabletop settings. Same canon feeds stories, scripts, products, merch, marketing, social, games, and interactive work.

Primary user: small creative team / studio ops. Tone: dense reference docs. See [`WRITING.md`](WRITING.md) (prefer [`ai/skills/writing-standard`](ai/skills/writing-standard/SKILL.md)).

## Five-minute start

1. Clone this repo.
2. Read [`GETTING_STARTED.md`](GETTING_STARTED.md). Follow phases P0 through P5.
3. Thin stubs already sit in `world/`. Replace `_fill_` sections. Do **not** copy thick `templates/` into `world/` to reset.
4. Fill `world/10_foundations/11_manifesto.md` first. Everything else depends on it.
5. After identity sign-off, copy `templates/projects/_project_scaffold/` to `projects/YYYY-MM-slug/`.

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
| `WRITING.md` | Writing standard entry point. |
| `reference/voice.md` | Shared prose rules (interaction + drafting). |
| `CONVENTIONS.md` | Naming, canon versioning, contribution, spinoffs. |

## Reading track (new collaborators)

1. `world/10_foundations/11_manifesto.md`
2. `world/20_identity/21_verbal_lexicon.md`
3. Designers: `world/20_identity/22_visual_core.md`
4. Producers: `world/00_governance/01_governance_ledger.md` and `world/40_brand/`

Orientation lives here and in `GETTING_STARTED.md`. Not duplicated into each world doc.

## Golden rule

Never create a new document if an edit to an existing one works. New docs only for distinct shipping outputs under `projects/`.
