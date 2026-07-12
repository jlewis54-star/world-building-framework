# World (your bible)

Filled canon lives here. Thin artifact. Source of truth for lore, identity, brand, and sensory rules.

## Start

Thin stubs already committed. Replace `_fill_` sections. Follow [`GETTING_STARTED.md`](../GETTING_STARTED.md).

Do **not** copy thick `templates/` into `world/` to reset. Reset = restore the committed thin stub (`git checkout -- world/path/to/doc.md`).

Generation: use [`ai/prompts/`](../ai/prompts/) or the prompt link on the matching template. Write results into these fill sections only. Do not paste Purpose, Theory, AI Prompt, or Review Checklist into `world/`.

Writing: [`WRITING.md`](../WRITING.md) and [`ai/skills/writing-standard`](../ai/skills/writing-standard/SKILL.md).

## Tree

```text
00_governance/     01_governance_ledger.md
10_foundations/    11_manifesto.md  12_lore_canon.md
20_identity/       21_verbal_lexicon.md  22_visual_core.md  23_asset_behavior.md
30_sensory/        31_sonic_dna.md
40_brand/          41_brand_guidelines.md  42_channel_playbook.md
50_vault/          51_mood_vault.md  52_anti_library.md
```

## Rules

- Golden Rule: edit existing docs before creating new ones.
- Shipping outputs go in `../projects/`, not here.
- Bump `CANON_VERSION` in governance when rules change (`CONVENTIONS.md`).
- Frontmatter `status:` = draft / review / signed_off / skipped. That is the only status token on world docs.
- World-type applicability matrices live on templates as `**APPLIES:**`, not here.
