# World (your bible)

Where filled canon will live. This clone ships thin stubs: frontmatter plus `_fill_` sections you replace. Once filled, these docs are the source of truth for lore, identity, brand, and sensory rules.

## Start

Thin stubs already committed. Replace `_fill_` sections. Follow [`GETTING_STARTED.md`](../GETTING_STARTED.md).

Do **not** copy prose from [`examples/demo-world/`](../examples/demo-world/) (Harbor Line) into `world/`. Read the demo for fill density only.

**Public repo:** Filled canon is IP. Keep real fills on a private fork; public `main` stays stub-only. See [`playbook/private-world-workflow.md`](../playbook/private-world-workflow.md).

Do **not** copy thick `templates/` into `world/` to reset. Reset = restore the committed thin stub (`git checkout -- world/path/to/doc.md`).

Generation: use [`ai/prompts/`](../ai/prompts/) or the prompt link on the matching template. Write results into these fill sections only. Do not paste Purpose, Theory, AI Prompt, or Review Checklist into `world/`.

Writing: [`WRITING.md`](../WRITING.md) and [`ai/skills/writing-standard`](../ai/skills/writing-standard/SKILL.md).

## Doc triad

Each world stub pairs with a thick process template and a generation prompt.

| World stub | Process (template) | Generation prompt |
| --- | --- | --- |
| `00_governance/01_governance_ledger.md` | `templates/00_governance/01_governance_ledger.md` | `ai/prompts/01_governance_ledger.md` |
| `10_foundations/11_manifesto.md` | `templates/10_foundations/11_manifesto.md` | `ai/prompts/11_manifesto.md` |
| `10_foundations/12_lore_canon.md` | `templates/10_foundations/12_lore_canon.md` | `ai/prompts/12_lore_canon.md` |
| `20_identity/21_verbal_lexicon.md` | `templates/20_identity/21_verbal_lexicon.md` | `ai/prompts/21_verbal_lexicon.md` |
| `20_identity/22_visual_core.md` | `templates/20_identity/22_visual_core.md` | `ai/prompts/22_visual_core.md` |
| `20_identity/23_asset_behavior.md` | `templates/20_identity/23_asset_behavior.md` | `ai/prompts/23_asset_behavior.md` |
| `30_sensory/31_sonic_dna.md` | `templates/30_sensory/31_sonic_dna.md` | `ai/prompts/31_sonic_dna.md` |
| `40_brand/41_brand_guidelines.md` | `templates/40_brand/41_brand_guidelines.md` | `ai/prompts/41_brand_guidelines.md` |
| `40_brand/42_channel_playbook.md` | `templates/40_brand/42_channel_playbook.md` | `ai/prompts/42_channel_playbook.md` |
| `50_vault/51_mood_vault.md` | `templates/50_vault/51_mood_vault.md` | `ai/prompts/51_mood_vault.md` |
| `50_vault/52_anti_library.md` | `templates/50_vault/52_anti_library.md` | `ai/prompts/52_anti_library.md` |

Non-authoritative filled example: [`examples/demo-world/`](../examples/demo-world/).

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
- World-type applicability matrices live on templates as APPLIES fields, not here.
