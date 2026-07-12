# Getting Started

Guided build for small teams. Prescribed order. Skip only where marked. Checkpoints block advancing with broken coherence.

Theory background: [`theory/Creative-World-Building-Research-Framework.md`](theory/Creative-World-Building-Research-Framework.md). Process detail: [`playbook/`](playbook/).

`world/` files are thin stubs (frontmatter + fill sections). Scaffolding, prompts, and checklists live under `templates/` and `ai/`.

---

## P0: World profile (before writing lore)

**Do**

1. Open [`playbook/world-types.md`](playbook/world-types.md). Pick one primary type: `fiction | brand | creator_ip | ttrpg`.
2. Set hard/soft dial (Falmouth split: exhaustive rules vs evocative gaps).
3. Record choices in `world/00_governance/01_governance_ledger.md` under World Profile.

**Checkpoint**

- [ ] World type named
- [ ] Hard/soft stance named in one sentence
- [ ] Named owners for manifesto and lore (even if same person)

---

## P1: Foundations (weeks 1-2)

**Do**

1. Fill thin stub `world/10_foundations/11_manifesto.md`: friction, founding myth, five beliefs, enemy.
2. Fill thin stub `world/10_foundations/12_lore_canon.md`: architecture, reality rules, timeline skeleton, archetype stubs.
3. Optional: run `ai/prompts/11_manifesto.md` then `ai/agents/canon-consistency.md` on drafts. Write into fill sections only.

**Checkpoint**

- [ ] Core friction stated in one line
- [ ] Five non-negotiable beliefs
- [ ] At least three reality rules (or explicit soft-world gaps)
- [ ] Sign-off: primary creative owner

**Do not advance** until friction + beliefs exist. Visual and verbal work without them drifts.

---

## P2: Identity systems (weeks 3-5)

**Do**

1. Fill `world/20_identity/21_verbal_lexicon.md`: voice matrix, dictionary, bans, copy examples.
2. Fill `world/20_identity/22_visual_core.md`: type, color, grid, marks (+ Figma link if used).
3. Fill `world/20_identity/23_asset_behavior.md`: camera, motion, texture.
4. Optional: `world/30_sensory/31_sonic_dna.md`. Mark skipped in the skip declaration (and frontmatter `status: skipped`) if silent/print-first.

**Checkpoint**

- [ ] Voice matrix complete (three poles + “what it is not”)
- [ ] Palette locked with hex/Pantone or material equivalents
- [ ] One silhouette / shape-language rule
- [ ] Sign-off: lead writer + lead designer

---

## P3: Brand + channels (weeks 6-8)

**Do**

1. Fill `world/40_brand/41_brand_guidelines.md`: partner-safe extraction of identity.
2. Fill `world/40_brand/42_channel_playbook.md`: digital, physical, social, spatial rules.
3. Seed vaults: `51_mood_vault.md`, `52_anti_library.md` (can stay thin).

**Checkpoint**

- [ ] Partner one-pager exists (brand guidelines passes vendor-safe test: no secret lore spoilers unless marked public)
- [ ] At least two channels specified
- [ ] Sign-off: producer / brand ops

---

## P4: First ship

**Do**

1. Copy project scaffold (templates stay thick; this copies into `projects/`, not `world/`):

```bash
cp -R templates/projects/_project_scaffold "projects/$(date +%Y-%m)-first-ship"
```

2. Fill `PROJECT.md`, `asset_matrix.md`, and `shipping_checklist.md`. Cite `world/` paths. Do not paste lore.
3. Run [`playbook/shipping-ledger.md`](playbook/shipping-ledger.md) or `ai/agents/brand-friction.md`.

**Checkpoint**

- [ ] Project type set (`story | product | game | marketing | film`)
- [ ] Narrative hook cites `12_lore_canon`
- [ ] Asset matrix rows point at world rule sources
- [ ] Shipping Ledger: all five checks pass

---

## P5: Governance harden (ongoing)

**Do**

1. Complete change protocol and `CANON_VERSION` in `01_governance_ledger.md`.
2. Tag git when canon bumps: `canon/vX.Y` (see `CONVENTIONS.md`).
3. Keep anti-library current; refuse trend-chasing into manifesto.

**Checkpoint**

- [ ] Change protocol written
- [ ] Canon version set
- [ ] Spinoff / Legends rule understood by team

---

## Notes into canon

Research captures and meeting notes do not land straight in `world/`. See [`playbook/notes-to-canon.md`](playbook/notes-to-canon.md). Use [`ai/skills/low-ambiguity-notes`](ai/skills/low-ambiguity-notes/SKILL.md) for intake.

---

## Dependency reminder

Manifesto → lore → verbal/visual → asset behavior → brand → channel → project.

Sonic and vaults may lag. Channel before first project. Governance stub early; harden late.

Full map: [`playbook/sequencing.md`](playbook/sequencing.md).

Validation before merge: [`VALIDATION.md`](VALIDATION.md) (`./scripts/validate.sh`).
