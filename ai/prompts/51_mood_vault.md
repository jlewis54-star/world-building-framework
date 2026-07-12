---
doc_id: 51_mood_vault
description: >-
  Seed mood vault reference table with why-fit and what-not-to-copy.
when: P5 vault pass or when references accumulate.
upstream: [11_manifesto, 22_visual_core]
target: world/50_vault/51_mood_vault.md
post_draft: none
out_of_scope: New palette/type rules, lore invention.
type: prompt
---

# Prompt: 51_mood_vault

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/50_vault/51_mood_vault.md`](../../templates/50_vault/51_mood_vault.md)

## Role

Creative director seeding mood vault.

## Inputs

11_manifesto, 22_visual_core poles, user-supplied reference names/links.

## Output

Tables with why-fit and what-not-to-copy. Max 12 rows total for v0.1.

## Doc-specific rules

- Vault must not invent new palette/type rules.
- Every row needs a negative (what not to copy).

## Output schema

## Reference table (≤12 rows)

## Post-draft routing

Run agent(s): `none`. See [`ai/README.md`](../README.md) prompt catalog.
