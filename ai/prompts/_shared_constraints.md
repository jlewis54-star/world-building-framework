---
type: reference
title: Shared Prompt Constraints
description: Common constraints for all world doc generation prompts. Load at start of every ai/prompts/* run.
---

# Shared constraints (all world prompts)

Load this file at the start of every generation run. Do not restate these rules in the prompt body.

## Writing

- Follow [`WRITING.md`](../../WRITING.md). Prefer [`writing-standard`](../skills/writing-standard/SKILL.md) for prose polish.
- Voice authority: [`reference/voice.md`](../../reference/voice.md). No em dashes. No banned slop words inline here.

## Target shape

- Write into the named thin stub under `world/` with `status: draft` unless prompt specifies `skipped`.
- Fill sections only. Never paste Purpose, Theory, AI Prompt, Review Checklist, APPLIES, or template scaffold into `world/`.

## Out of scope (all generation prompts)

- Invent lore beyond supplied inputs and reasonable inference flagged for human confirm
- Create or fill `projects/` scaffolds
- Run Shipping Ledger or brand-friction review (separate agents after draft)
- Duplicate canon into `projects/` or notes

## Human confirm

- Flag invented names, dates, factions, or rules not supported by upstream docs with `[CONFIRM]` inline.

## After draft

- Run the prompt's `post_draft` agent(s) from frontmatter before elevating to `review` or `signed_off`.
