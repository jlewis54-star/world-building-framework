# Getting Started

Guided build for small teams. Prescribed order. Skip only where marked. Checkpoints block advancing with broken coherence.

Theory background: [`theory/Creative-World-Building-Research-Framework.md`](theory/Creative-World-Building-Research-Framework.md). Process detail: [`playbook/`](playbook/).

**Fiction or TTRPG?** Read [`playbook/fiction-ttrpg-tracks.md`](playbook/fiction-ttrpg-tracks.md) for playtest-first and prose-only paths.

`world/` files are thin stubs (frontmatter + fill sections). Scaffolding, prompts, and checklists live under `templates/` and `ai/`.

**Public repo note:** This framework ships empty stubs on public `main`. If you are building real canon you do not want public, use a private fork and [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md) before filling `world/`.

---

## P0: World profile (before writing lore)

This clone starts with empty stubs in root `world/`. Harbor Line under [`examples/demo-world/`](examples/demo-world/) is sample-only. Do not copy its prose into `world/`. Read [`examples/demo-world/README.md`](examples/demo-world/README.md) for fill density, then write your own canon into the stubs.

**Do**

1. Open [`playbook/world-types.md`](playbook/world-types.md). Pick one primary type: `fiction | brand | creator_ip | ttrpg`.
2. Set hard/soft dial (Falmouth split: exhaustive rules vs evocative gaps).
3. Record choices in `world/00_governance/01_governance_ledger.md` under World Profile and Skip Registry (if any docs deferred).

**Checkpoint**

- [ ] World type named
- [ ] Hard/soft stance named in one sentence
- [ ] Named owners for manifesto and lore (same person OK for solo work)

---

## P1: Foundations (weeks 1-2)

**Do**

1. Fill thin stub `world/10_foundations/11_manifesto.md`: friction, founding myth, five beliefs, enemy.
2. Fill thin stub `world/10_foundations/12_lore_canon.md`: architecture, reality rules, timeline skeleton, archetype stubs.
3. Optional: run `ai/prompts/11_manifesto.md` then post-draft agents from prompt frontmatter (`canon-consistency` for identity/lore docs). Load [`ai/prompts/_shared_constraints.md`](ai/prompts/_shared_constraints.md) with every prompt. Write into fill sections only.

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
2. Fill `world/20_identity/22_visual_core.md`: type, color, grid, marks (+ Figma link if used). Fiction/TTRPG: see [`playbook/fiction-prose-fill.md`](playbook/fiction-prose-fill.md).
3. Fill `world/20_identity/23_asset_behavior.md`: camera, motion, texture (or skip with reason).
4. Optional: `world/30_sensory/31_sonic_dna.md`. Mark skipped in Skip Registry + frontmatter `status: skipped` if silent/print-first.

**Checkpoint**

- [ ] Voice matrix complete (three poles + "what it is not")
- [ ] Palette or prose mood palette locked (hex/Pantone or narrative equivalent)
- [ ] One silhouette / shape-language rule (or prose shape rule)
- [ ] Sign-off: lead writer + lead designer (solo: same owner twice is OK)

---

## P3: Brand + channels (weeks 6-8)

**Studio track (`brand`, `creator_ip`):** complete this phase before first **public** ship.

**Fiction / TTRPG track:** skip `41` and `42` until partners or public publish. Record in Skip Registry. You may run **P4 playtest** first (see fiction-ttrpg-tracks).

**Do**

1. Fill `world/40_brand/41_brand_guidelines.md`: partner-safe extraction of identity.
2. Fill `world/40_brand/42_channel_playbook.md`: digital, physical, social, spatial rules.
3. Seed vaults: [`world/50_vault/51_mood_vault.md`](world/50_vault/51_mood_vault.md), [`world/50_vault/52_anti_library.md`](world/50_vault/52_anti_library.md) (can stay thin).

**Checkpoint**

- [ ] Partner one-pager exists when external partners involved (skip if fiction/TTRPG private-only)
- [ ] At least two channels specified when shipping to audiences (skip if private playtest only)
- [ ] Sign-off: producer / brand ops (solo: owner name)

---

## P4: First ship

**Do**

1. Copy project scaffold (templates stay thick; this copies into `projects/`, not `world/`):

```bash
cp -R templates/projects/_project_scaffold "projects/$(date +%Y-%m)-first-ship"
```

Examples: [`examples/demo-project/story-novel-pitch/`](examples/demo-project/story-novel-pitch/), [`examples/demo-project/game-playtest/`](examples/demo-project/game-playtest/).

2. Fill `PROJECT.md`, `asset_matrix.md`, and `shipping_checklist.md`. Cite `world/` paths. Do not paste lore.
3. Run shipping audit:
   - **Visual / partner ship:** [`playbook/shipping-ledger.md`](playbook/shipping-ledger.md) or `ai/agents/brand-friction.md`
   - **Prose / playtest / text-only:** [`playbook/shipping-ledger-prose.md`](playbook/shipping-ledger-prose.md)

**Checkpoint**

- [ ] Project type set (`story | product | game | marketing | film`)
- [ ] Narrative hook cites `12_lore_canon`
- [ ] Asset matrix rows point at world rule sources
- [ ] Shipping checklist complete (full or prose ledger; N/A rows justified)

---

## P5: Governance harden (ongoing)

**Do**

1. Complete change protocol, Canon Changelog, and `CANON_VERSION` in `01_governance_ledger.md`.
2. Tag git when canon bumps: `canon/vX.Y` (see `CONVENTIONS.md`).
3. Keep anti-library current; refuse trend-chasing into manifesto.
4. Before MAJOR bumps: [`playbook/playtest-to-canon.md`](playbook/playtest-to-canon.md).

**Checkpoint**

- [ ] Change protocol written
- [ ] Canon version set; changelog row added
- [ ] `./scripts/check_canon_version.sh` passes (or warnings resolved)
- [ ] Spinoff / Legends rule understood by team

---

## Notes into canon

Research captures and meeting notes do not land straight in `world/`. See [`playbook/notes-to-canon.md`](playbook/notes-to-canon.md). Use [`ai/skills/low-ambiguity-notes`](ai/skills/low-ambiguity-notes/SKILL.md) for intake.

---

## Dependency reminder

**Studio:** manifesto → lore → verbal/visual → asset behavior → brand → channel → **public** project.

**Fiction / TTRPG:** manifesto → lore → verbal (+ visual if needed) → project. Brand/channel before **first public** ship, not before playtest or private draft project.

Sonic and vaults may lag. Governance stub early; harden late.

Full map: [`playbook/sequencing.md`](playbook/sequencing.md).

Validation: [`VALIDATION.md`](VALIDATION.md) (`make validate`, `make validate-canon`).
