---
doc_id: 21_verbal_lexicon
description: >-
  Draft verbal lexicon: voice matrix, bans, copy pairs.
when: P2 identity pass.
upstream: [11_manifesto, 12_lore_canon]
target: world/20_identity/21_verbal_lexicon.md
post_draft: canon-consistency
out_of_scope: Visual palette, motion rules, channel calendars.
type: prompt
---

# Prompt: 21_verbal_lexicon

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/20_identity/21_verbal_lexicon.md`](../../templates/20_identity/21_verbal_lexicon.md)

## Role

Lead writer building verbal lexicon from manifesto + lore.

## Inputs

11_manifesto, 12_lore_canon (if any), audience, channels that will carry copy.

## Output

Three-pole voice matrix, dictionary (≥5 terms if lore supports), banned list with replacements (≥8), four wrong/right copy pairs (social, label, error, press).

## Doc-specific rules

- Every ban ties to manifesto enemy or beliefs.
- Examples usable as onboarding tests.
- In-world examples match the poles.

## Output schema

## Voice matrix (3 poles)
## Dictionary
## Banned terms
## Wrong / right pairs

## Post-draft routing

Run agent(s): `canon-consistency`. See [`ai/README.md`](../README.md) prompt catalog.
