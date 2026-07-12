# Fiction and TTRPG Tracks

Alternate paths when the default studio sequence (P3 brand/channel before every ship) does not fit.

Default track: [`GETTING_STARTED.md`](../GETTING_STARTED.md). World-type rules: [`world-types.md`](world-types.md).

---

## When to use which track

| Track | World types | First ship target |
| --- | --- | --- |
| **Studio** (default) | `brand`, `creator_ip` | Partner PDF, merch, social, film |
| **Fiction** | `fiction` | Query letter, sample chapters, synopsis |
| **TTRPG** | `ttrpg` | Playtest arc, then zine/VTT on publish |

---

## Fiction track

### P0 to P1

Same as default. Hard dial: lock reality rules in `12_lore_canon` before drafting prose.

### P2 (prose-native)

| Doc | Fiction fill focus |
| --- | --- |
| `21_verbal_lexicon` | **Required.** Voice poles, dictionary, bans, dialogue vs narration examples |
| `22_visual_core` | **Recommended.** Map to prose imagery: palette as mood words, typography as register (formal vs vernacular), shape language as institution vs intimacy. Hex/Figma optional; write `n/a` with prose equivalents |
| `23_asset_behavior` | **Optional** unless film cover art. Fill scene texture, POV distance, sensory palette; or `status: skipped` with reason |
| `31_sonic_dna` | Skip OK for print-first |

See [`fiction-prose-fill.md`](fiction-prose-fill.md) for field substitutions.

**Solo sign-off:** one owner may sign all P2 rows in governance Sign-Off Matrix.

### P3 (defer until public/partner ship)

Skip `41` and `42` with frontmatter `status: skipped` + reason in Skip Registry (`01_governance_ledger`) when:

- No merch, partners, or public marketing yet
- First ship is manuscript or query materials only

Still seed `51_mood_vault` and `52_anti_library` (thin OK).

### P4 (first ship)

Copy scaffold → `projects/YYYY-MM-novel-pitch`. Set `project_type: story`.

Use [`shipping-ledger-prose.md`](shipping-ledger-prose.md), not full five-check ledger.

Example: [`examples/demo-project/story-novel-pitch/`](../examples/demo-project/story-novel-pitch/).

---

## TTRPG track

### P0 to P2

Same as fiction for `11`, `12`, `21`. `22` recommended for maps/sigils; `23` skip OK until streamed play or cover art.

Record skips in Skip Registry.

### P3

Skip `41` and `42` until publish intent (itch.io zine, Foundry module, public setting book).

**Playtest-first:** P4 may be a **private** `project_type: game` before P3 completes.

Example: [`examples/demo-project/game-playtest/`](../examples/demo-project/game-playtest/).

### P4 playtest (private)

- No public Shipping Ledger required
- Session prep, NPC notes, table rulings stay in `projects/` or [`examples/scratch/`](../examples/scratch/)
- Promote world rules via [`playtest-to-canon.md`](playtest-to-canon.md) before MAJOR bumps

### P4 public publish

Un-skip or fill `41`/`42` as needed. Run full or prose ledger depending on asset (text zine → prose ledger).

---

## Dependency reminder (by track)

**Studio:** manifesto → lore → verbal/visual → asset behavior → brand → channel → **public** project.

**Fiction / TTRPG (private):** manifesto → lore → verbal (+ visual if needed) → **playtest or draft project**. Channel/brand before **first public** ship, not before first project folder.

---

## Checklist: am I ready to ship?

| Question | Studio | Fiction (private) | TTRPG playtest | Public publish |
| --- | --- | --- | --- | --- |
| P0 profile set | yes | yes | yes | yes |
| P1 friction + beliefs | yes | yes | yes | yes |
| `21` signed or draft-stable | yes | yes | yes | yes |
| `41`/`42` filled | yes | defer OK | defer OK | yes if partners/channels |
| Shipping ledger | full 5 checks | prose 3 checks | optional | prose or full |
| `inherits_canon` set | yes | yes | yes | yes |
