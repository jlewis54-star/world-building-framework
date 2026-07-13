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
4. Root `world/` is **your** empty stubs. Do **not** copy prose from [`examples/demo-world/`](examples/demo-world/) (Harbor Line) into `world/`. Read the demo for fill density only.
5. **P0:** Set world profile in [`world/00_governance/01_governance_ledger.md`](world/00_governance/01_governance_ledger.md) (type, hard/soft dial, owners).
6. **P1:** Fill [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md) and [`world/10_foundations/12_lore_canon.md`](world/10_foundations/12_lore_canon.md).
7. **P2 to P3:** Identity systems, then brand and channel (fiction/TTRPG may defer P3: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)).
8. **P4:** Copy scaffold to `projects/YYYY-MM-slug/`. Examples: [`examples/demo-project/`](examples/demo-project/).

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
| `world/` | Thin stubs you fill. Where filled canon will live. Frontmatter + fill sections only. |
| `projects/` | Shipping outputs. Inherit from `world/`. Do not duplicate lore. |
| `ai/` | Prompts, agents, vendored skills. |
| `examples/` | Demo world and notes scratch (non-authoritative). |
| `WRITING.md` | Writing standard entry point. |
| `reference/voice.md` | Shared prose rules (interaction + drafting). |
| `CONVENTIONS.md` | Naming, canon versioning, contribution, spinoffs. |
| `VALIDATION.md` | Markdown validation before merge. |
| `CONTRIBUTING.md` | How to PR; keep your world IP private. |
| `SECURITY.md` | Vulnerability reporting. |
| `playbook/public-repo-governance.md` | GitHub Settings checklist for maintainers. |
| `playbook/private-world-workflow.md` | Keep filled canon off public `main`. |

## Reading track (new collaborators)

1. [`GETTING_STARTED.md`](GETTING_STARTED.md) and [`playbook/world-types.md`](playbook/world-types.md)
2. [`world/README.md`](world/README.md): empty stubs; do not paste demo prose into `world/`
3. [`examples/demo-world/README.md`](examples/demo-world/README.md), then [`examples/demo-world/`](examples/demo-world/) for fill density only (Harbor Line is sample-only)
4. [`world/10_foundations/11_manifesto.md`](world/10_foundations/11_manifesto.md) (your stub to fill)
5. Fiction/TTRPG: [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md)
6. Theory: [`theory/`](theory/) when playbook cites it (not day one)

Orientation lives here and in `GETTING_STARTED.md`. Not duplicated into each world doc.

## Golden rule

Never create a new document if an edit to an existing one works. New docs only for distinct shipping outputs under `projects/`.

## Clone, fork, or collaborator?

Three ways people interact with this repo. Pick the right one before inviting a friend or accepting outside changes.

| Method | What it is | Who uses it | Can they change this repo's `main`? |
| --- | --- | --- | --- |
| **Clone** | Copy to your machine (`git clone`). Work locally. | You, a friend learning the framework, anyone building a private world | Only if you gave them **Write** access (not recommended for beginners) |
| **Fork** | Your own copy on GitHub, linked to upstream. | Open-source contributors, strangers | No. They push to **their** fork and open a **pull request** to you |
| **Collaborator** | You invite their GitHub account in Settings → Collaborators. | Trusted friend with Write access | Yes, but only through a **PR** (branch protection). Force-push to `main` is blocked |

**Recommended for a friend who does not know GitHub:** they **clone** (or duplicate into a **private repo** per [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md)). Do **not** add them as Write collaborator on the public framework repo unless they need to merge framework changes.

**Recommended for you (owner):** branch → PR → merge when `validate` CI is green. Same gate as everyone else. Keeps `main` stable for all cloners.

**Strangers on the internet:** fork → PR. You review and merge. Fork PR workflows from first-time contributors require your approval before Actions run.

Details: [`CONTRIBUTING.md`](CONTRIBUTING.md) and [`playbook/public-repo-governance.md`](playbook/public-repo-governance.md).
