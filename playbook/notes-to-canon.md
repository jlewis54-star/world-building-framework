# Notes to Canon

How research captures become `world/` entries. Intake skill: [`ai/skills/low-ambiguity-notes`](../ai/skills/low-ambiguity-notes/SKILL.md).

## Rule

Notes are not canon. Canon is `world/` after human promotion.

## Flow

1. Capture (transcript, call, research dump) → run `low-ambiguity-notes` (meeting or atomic mode).
2. Land notes in [`examples/scratch/`](../examples/scratch/) (default), a local notes vault, or a private branch. Do not invent a second bible.
3. Owner picks claims that change a world rule or fill a `_fill_` slot.
4. Edit the matching thin `world/` doc. Frontmatter `status: draft`.
5. Run `ai/agents/canon-consistency.md` (and brand-friction if public-facing).
6. Owner sets `status: review` then `signed_off`. Bump `CANON_VERSION` if MAJOR/MINOR per `CONVENTIONS.md`.

## Promotion gate

| Question | Fail action |
| --- | --- |
| Does the note invent facts not in source? | Do not promote. Flag `[DATA NEEDED]`. |
| Does it contradict `11` / `12`? | Resolve via governance owners first. |
| Is it a channel tactic or a world rule? | Tactic → `projects/`. Rule → `world/`. |
| Would pasting create lore duplication in a project? | Cite path instead. |

## Out of scope for notes skill

Filling bible templates end-to-end. Writing Purpose/Theory into world. Shipping Ledger (use `brand-friction`).
