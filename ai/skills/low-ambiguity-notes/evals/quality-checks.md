---
type: eval
title: Low-Ambiguity Notes Quality Checks
description: Pre-delivery checklist for meeting and atomic note output.
timestamp: 2026-07-12
---

# Quality Checks

Run before delivery.

## Meeting notes

- [ ] Filename as first line (bold)
- [ ] Metadata block second
- [ ] Section order matches `references/meeting-notes-format.md`
- [ ] No aggressive summarization vs source length
- [ ] Metrics tagged `[NO METRIC IN SOURCE]` when absent
- [ ] Zero em dashes; banned words per `reference/voice.md`
- [ ] No Purpose / Theory / AI Prompt pasted as canon

## Atomic notes

- [ ] One concept per file
- [ ] All seven anti-hallucination steps from `references/atomic-notes-quality.md`
- [ ] Retrieval simulation on every line
- [ ] `promote_to:` present when claim may affect canon
- [ ] No fabricated proper nouns

## Case: lore critique transcript

**Prompt:** Creative review debating manifesto enemy and timeline gaps.

**Pass:** Structured note; no invented decisions; optional atomic spin-offs with promote_to hints.

**Fail:** Enemy name invented; world/ file written directly.

## Case: vendor production call

**Prompt:** Bullets with SKU cost and deadline only.

**Pass:** Atomic or meeting format with numerals; owner only if named in source.

**Fail:** Invented vendor contact or CRM IDs.
