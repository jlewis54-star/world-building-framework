# AI Kit

First-class generation and review helpers. Human owns canon. AI proposes. Checklists gate `signed_off`.

Drafted output must follow [`../WRITING.md`](../WRITING.md). Prefer [`skills/writing-standard`](skills/writing-standard/SKILL.md). Validate before merge: [`../VALIDATION.md`](../VALIDATION.md).

Prompt ↔ world stub pairing: [`../world/README.md`](../world/README.md) (Doc triad table).

Shared generation constraints: [`prompts/_shared_constraints.md`](prompts/_shared_constraints.md). Every prompt links it; do not duplicate boilerplate.

Vendored authoring toolchain provenance: [`VENDORED.md`](VENDORED.md).

## Layout

| Path | Role |
| --- | --- |
| `skills/` | Portable skills (native + vendored) |
| `prompts/` | Per-doc generation prompts with YAML frontmatter |
| `agents/` | Review, expand, and authoring agents |
| `reference/` | Context-engineering and quality exemplar docs |

## Native vs vendored

| Kind | Items |
| --- | --- |
| **Native (world kit)** | Prompts 01-52, `canon-consistency`, `brand-friction`, `project-brief-expander`, `writing-standard`, `low-ambiguity-notes`, `github-maintainer` |
| **Vendored (authoring)** | `skill-authoring`, `ai-engineer`, `instruction-refiner`, `reference/context-engineering-principles.md` |

## Skills

| Skill | When |
| --- | --- |
| [`writing-standard`](skills/writing-standard/SKILL.md) | Prose pass on any drafted doc; AI-slop removal; studio checklist |
| [`low-ambiguity-notes`](skills/low-ambiguity-notes/SKILL.md) | Transcript/capture → notes; not for filling bible templates directly |
| [`github-maintainer`](skills/github-maintainer/SKILL.md) | PRs, Dependabot, branch protection, push/merge decisions for this public repo |
| [`skill-authoring`](skills/skill-authoring/SKILL.md) | New or improved SKILL.md; evals; structure review |

## Agents

| Agent | When |
| --- | --- |
| [`canon-consistency`](agents/canon-consistency.md) | After lore/identity drafts; before sign-off |
| [`brand-friction`](agents/brand-friction.md) | Before shipping any public asset |
| [`project-brief-expander`](agents/project-brief-expander.md) | When spinning a new `projects/` instance |
| [`ai-engineer`](agents/ai-engineer.md) | Agent/skill/prompt design review; load [`ai-engineer/AGENT.md`](agents/ai-engineer/AGENT.md) + reference/ |
| [`instruction-refiner`](agents/instruction-refiner.md) | Compress bloated prompt or SKILL.md body |

Cursor mirror (optional): [`.cursor/agents/ai-engineer.md`](../.cursor/agents/ai-engineer.md).

## Authoring toolchain (when to use which)

| Need | Tool |
| --- | --- |
| New skill folder, evals, adapters | `skill-authoring` |
| Dedupe/tighten existing prompt or SKILL body | `instruction-refiner` |
| Exemplar-gap review, OKF, context budget | `ai-engineer` |
| Prose polish on drafted doc | `writing-standard` |

## Prompt catalog

Load [`prompts/_shared_constraints.md`](prompts/_shared_constraints.md) first for every generation run.

| Prompt | Phase | Upstream | Target | Post-draft |
| --- | --- | --- | --- | --- |
| [`01_governance_ledger`](prompts/01_governance_ledger.md) | P0 | - | `world/00_governance/01_governance_ledger.md` | none |
| [`11_manifesto`](prompts/11_manifesto.md) | P1 | 01 profile | `world/10_foundations/11_manifesto.md` | canon-consistency |
| [`12_lore_canon`](prompts/12_lore_canon.md) | P1 | 11, 01 dial | `world/10_foundations/12_lore_canon.md` | canon-consistency |
| [`21_verbal_lexicon`](prompts/21_verbal_lexicon.md) | P2 | 11, 12 | `world/20_identity/21_verbal_lexicon.md` | canon-consistency |
| [`22_visual_core`](prompts/22_visual_core.md) | P2 | 11, 12 | `world/20_identity/22_visual_core.md` | canon-consistency |
| [`23_asset_behavior`](prompts/23_asset_behavior.md) | P2 | 22, 11 | `world/20_identity/23_asset_behavior.md` | canon-consistency |
| [`31_sonic_dna`](prompts/31_sonic_dna.md) | P2 opt | 11, 01 type | `world/30_sensory/31_sonic_dna.md` | canon-consistency |
| [`41_brand_guidelines`](prompts/41_brand_guidelines.md) | P3 | 21-23, 11 | `world/40_brand/41_brand_guidelines.md` | canon-consistency; brand-friction at ship |
| [`42_channel_playbook`](prompts/42_channel_playbook.md) | P3 | 41, 21-23 | `world/40_brand/42_channel_playbook.md` | canon-consistency; brand-friction at ship |
| [`51_mood_vault`](prompts/51_mood_vault.md) | P5 | 11, 22 | `world/50_vault/51_mood_vault.md` | none |
| [`52_anti_library`](prompts/52_anti_library.md) | P5 | 11, 21, 22 | `world/50_vault/52_anti_library.md` | none |

## Dependency graph (generation order)

Aligned with [`playbook/sequencing.md`](../playbook/sequencing.md):

```text
01_governance
      |
11_manifesto ----+----+
      |          |    |
12_lore_canon    |    |
      |          |    |
      +----+-----+    |
           |          |
    21_verbal  22_visual
           |          |
           +----+-----+
                |
         23_asset_behavior
                |
      31_sonic (optional / skip per world-types)
                |
      41_brand_guidelines
                |
      42_channel_playbook
                |
         projects/*  --> brand-friction at ship
                |
      51_mood_vault / 52_anti_library
```

## Usage

1. Open matching prompt under `prompts/` (check frontmatter `when` and `upstream`).
2. Load `_shared_constraints.md`. Paste signed upstream docs as context.
3. Write draft into `world/` with `status: draft`.
4. Run `writing-standard` when polishing prose.
5. Run post-draft agent(s) from prompt frontmatter before `review` / `signed_off`.

## Bloat excluded

No multi-agent orchestration frameworks, auto-commit bots, trend scrapers, competitor market analyses, or rigid content calendars.

## Porting note

Canonical agents and skills live under `ai/`. Optional Cursor mirrors under `.cursor/agents/` or `.cursor/skills/` for native picker discovery. Do not fork content; link to canonical paths.
