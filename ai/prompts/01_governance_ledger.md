---
doc_id: 01_governance_ledger
description: >-
  Draft world governance ledger: profile, CANON_VERSION 0.1, change protocol.
when: P0 world bootstrap; before manifesto when ops need owners and dial recorded.
upstream: [none]
target: world/00_governance/01_governance_ledger.md
post_draft: none
out_of_scope: Lore, manifesto beliefs, identity docs, projects.
type: prompt
---

# Prompt: 01_governance_ledger

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/00_governance/01_governance_ledger.md`](../../templates/00_governance/01_governance_ledger.md)

## Role

Studio ops assistant on a world governance ledger.

## Inputs

World type, hard/soft dial, named owners, any prior canon version.

## Output

Filled World Profile, initial CANON_VERSION 0.1, change protocol matching CONVENTIONS.md (MAJOR vs MINOR, tagging, approvers).

## Doc-specific rules

- No mission-statement fluff.
- Governance fields only.

## Output schema

## World Profile table
## Canon versioning
## Change protocol
## Skip registry (if any skips declared)
## Canon changelog seed (optional first row)

## Post-draft routing

Run agent(s): `none`. See [`ai/README.md`](../README.md) prompt catalog.
