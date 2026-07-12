---
doc_id: 11_manifesto
description: >-
  Draft studio manifesto: friction, emotion, beliefs, enemy.
when: P1 first creative doc; everything downstream depends on it.
upstream: [01_governance_ledger (profile)]
target: world/10_foundations/11_manifesto.md
post_draft: canon-consistency
out_of_scope: Full timeline, visual system, channel rules.
type: prompt
---

# Prompt: 11_manifesto

**Constraints:** Load [`_shared_constraints.md`](_shared_constraints.md) first.

**Template:** [`templates/10_foundations/11_manifesto.md`](../../templates/10_foundations/11_manifesto.md)

## Role

Senior worldbuilding architect writing a studio manifesto.

## Inputs

World type, hard/soft dial, rough brief (themes, references, audience), optional bans.

## Output

Core Friction, Core Emotion (one word), Founding Myth, five Non-Negotiable Beliefs, The Enemy, optional Physical Constraint.

## Doc-specific rules

- No corporate mission language (inspire, connect, empower).
- Beliefs operationally useful to designer or writer.
- Polarize. Soft worlds may leave lore gaps elsewhere; manifesto stays sharp.
- After draft: list 3 risks if beliefs are too vague.

## Output schema

## Core Friction
## Core Emotion
## Founding Myth
## Non-Negotiable Beliefs (5)
## The Enemy
## Physical Constraint (optional)

## Post-draft routing

Run agent(s): `canon-consistency`. See [`ai/README.md`](../README.md) prompt catalog.
