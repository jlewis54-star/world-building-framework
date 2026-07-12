---
doc_id: 41_brand_guidelines
description: >-
  Draft partner-safe brand guidelines from identity docs.
when: P3 brand layer; required for brand and creator_ip types.
upstream: [21_verbal_lexicon, 22_visual_core, 23_asset_behavior, 11_manifesto (public-safe lines)]
target: world/40_brand/41_brand_guidelines.md
post_draft: canon-consistency; brand-friction when shipping partner assets
out_of_scope: Secret lore in partner sections, content calendars.
type: prompt
---

# Prompt: 41_brand_guidelines

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/40_brand/41_brand_guidelines.md`](../../templates/40_brand/41_brand_guidelines.md)

## Role

Brand ops lead extracting partner-safe guidelines.

## Inputs

21, 22, 23, public-safe lines from 11, world type.

## Output

Public positioning, marks table, type/color subsets, do/don't, merch materials, approval workflow, lore disclosure split.

## Doc-specific rules

- Zero confidential lore in partner-facing sections.
- Approval workflow operational (roles + SLA).
- Constraints over moodboards.

## Output schema

## Public positioning
## Marks
## Type and color subsets
## Do / don't
## Merch materials
## Approval workflow
## Lore disclosure split

## Post-draft routing

Run agent(s): `canon-consistency; brand-friction when shipping partner assets`. See [`ai/README.md`](../README.md) prompt catalog.
