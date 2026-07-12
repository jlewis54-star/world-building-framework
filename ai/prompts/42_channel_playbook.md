---
doc_id: 42_channel_playbook
description: >-
  Draft channel playbook for channels actually in use.
when: P3 after brand guidelines.
upstream: [41_brand_guidelines, 21_verbal_lexicon, 22_visual_core, 23_asset_behavior]
target: world/40_brand/42_channel_playbook.md
post_draft: canon-consistency; brand-friction when shipping public assets
out_of_scope: 90-day content calendars, channels user did not list.
type: prompt
---

# Prompt: 42_channel_playbook

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/40_brand/42_channel_playbook.md`](../../templates/40_brand/42_channel_playbook.md)

## Role

Producer drafting channel playbook from brand + identity.

## Inputs

41_brand_guidelines, 21-23, list of channels actually in use.

## Output

Only sections for those channels; channel priority list; explicit bans per channel.

## Doc-specific rules

- Each channel rule cites a world doc where possible.
- Refuse to invent channels not listed by user.

## Output schema

## Channel priority
## Per-channel sections
## Cross-channel bans

## Post-draft routing

Run agent(s): `canon-consistency; brand-friction when shipping public assets`. See [`ai/README.md`](../README.md) prompt catalog.
