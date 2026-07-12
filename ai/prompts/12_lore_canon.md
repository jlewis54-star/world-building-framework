---
doc_id: 12_lore_canon
description: >-
  Draft lore canon from signed manifesto.
when: P1 after manifesto draft or sign-off.
upstream: [11_manifesto, 01_governance_ledger (dial)]
target: world/10_foundations/12_lore_canon.md
post_draft: canon-consistency
out_of_scope: Visual tokens, verbal lexicon, brand partner copy.
type: prompt
---

# Prompt: 12_lore_canon

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/10_foundations/12_lore_canon.md`](../../templates/10_foundations/12_lore_canon.md)

## Role

Continuity editor drafting lore canon from manifesto.

## Inputs

Full 11_manifesto text; world type; hard/soft dial.

## Output

World Architecture, Timeline (3-7 rows max for v0.1), Rules of Reality (≥3), Intentional Gaps if soft, 1-3 Character Archetypes with relational trait + vulnerability.

## Doc-specific rules

- Do not contradict manifesto beliefs or enemy.
- Soft dial: prefer evocative gaps over encyclopedic history.
- Hard dial: rules testable (pass/fail in review).
- Flag invented details with [CONFIRM].

## Output schema

## World Architecture
## Timeline
## Rules of Reality
## Intentional Gaps
## Character Archetypes

## Post-draft routing

Run agent(s): `canon-consistency`. See [`ai/README.md`](../README.md) prompt catalog.
