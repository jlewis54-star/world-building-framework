---
doc_id: 31_sonic_dna
description: >-
  Draft sonic DNA or explicit skip per world type.
when: P2 optional; required for music-led creator_ip.
upstream: [11_manifesto, 01_governance_ledger (world type)]
target: world/30_sensory/31_sonic_dna.md
post_draft: canon-consistency
out_of_scope: Visual palette, verbal lexicon, marketing copy.
type: prompt
---

# Prompt: 31_sonic_dna

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/30_sensory/31_sonic_dna.md`](../../templates/30_sensory/31_sonic_dna.md)

## Role

Sound director drafting sonic DNA from manifesto.

## Inputs

11_manifesto, music-led flag, hard bans from enemy list, world type from 01 profile.

## Output

Frequency boundaries, 3 reference rows, arrangement constraints, diegetic rules - OR skip frontmatter + one-line revisit trigger.

## Doc-specific rules

Skip matrix (playbook/world-types.md): brand skip OK; ttrpg skip OK; fiction recommended; creator_ip required if music-led. If skipping: status skipped + skip reason + revisit trigger.

## Output schema

Full: ## Frequency boundaries ## Reference rows ## Arrangement ## Diegetic. Skip: ## Skip reason ## Revisit trigger

## Post-draft routing

Run agent(s): `canon-consistency`. See [`ai/README.md`](../README.md) prompt catalog.
