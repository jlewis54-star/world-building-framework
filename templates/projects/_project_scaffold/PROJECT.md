---
project_code: YYYY-MM-slug
project_type: story | product | game | marketing | film
status: draft
inherits_canon: 0.1
canon: true
owners: []
updated: YYYY-MM-DD
---

# Project

## Purpose

Single shipping instance. Inherits world bible by link. Do not duplicate lore. Cite `world/` paths.

## How to create

```bash
cp -R templates/projects/_project_scaffold "projects/YYYY-MM-slug"
```

Edit this file, `asset_matrix.md`, and `shipping_checklist.md`.

---

## Narrative Hook

How this release moves the overarching world story (or brand chapter) forward.

Must cite: `world/10_foundations/12_lore_canon.md`

_fill_

## Inheritance Table

| World doc | Binding | Notes |
| --- | --- | --- |
| `11_manifesto` | required | |
| `12_lore_canon` | required | |
| `21_verbal_lexicon` | required if copy | |
| `22_visual_core` | required if visual | |
| `23_asset_behavior` | required if motion/photo | |
| `31_sonic_dna` | if AV | |
| `41_brand_guidelines` | if external partners | |
| `42_channel_playbook` | required for channel work | |

## Success Criteria

_Measurable or critiqueable outcomes, not vanity metrics alone._

1. _fill_
2. _fill_
3. _fill_

## Non-Goals

_fill_

## Example (studio density)

> Type: film. Hook: Registrar opens the burned ledger’s blank final page. First public glimpse of Intentional Gap #1 without filling it (`12` gaps). Inherits canon 0.4. Non-goal: explain Archive Fire.

---

## AI Prompt

Use agent [`ai/agents/project-brief-expander.md`](../../../ai/agents/project-brief-expander.md). Do not duplicate the prompt body here.


## Review Checklist

- [ ] `project_type` set
- [ ] Hook cites `12_lore_canon`
- [ ] Inheritance table filled
- [ ] No lore duplication
- [ ] `inherits_canon` matches governance
