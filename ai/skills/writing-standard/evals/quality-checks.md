---
type: eval
title: Writing Standard Quality Checks
description: Pre-delivery checklist and output-quality assertions for writing-standard edits.
timestamp: 2026-07-08
---

# Quality Checks

## Pre-delivery checklist

Before returning edited text:

- [ ] Lead sentence states main point
- [ ] Vague claims replaced with data or `[DATA NEEDED]`
- [ ] Active voice in key decision sentences
- [ ] Action items have owner + deadline
- [ ] Zero em dashes in output
- [ ] Zero library banned words
- [ ] `references/voice.md` drafting-voice rules applied
- [ ] No throat-clearing intro
- [ ] AI slop pass completed when source was AI
- [ ] Output uses Issues / Key Rewrites / Full Revised structure (unless user asked rewrite-only)
- [ ] No fabricated numbers or facts

## Output-quality assertions

### Case 1: Vague status email

**Input:** "We made good progress on the project and hope to finish soon. Let me know if you have questions."

**Assertions:**
- Lead states a specific status or decision
- "Soon" replaced with date or `[DATE NEEDED]`
- No "hope" or "let me know if" as the only ask
- Issues Found section lists at least 2 problems

### Case 2: AI-drafted paragraph

**Input:** Text with "leverage", "delve", "In today's fast-paced landscape", and an em dash.

**Assertions:**
- Flagged words removed or reduced to ≤1 per section
- "In today's..." opener cut
- Em dashes replaced (colons, periods, or commas)
- ai-slop-detection rules cited in What changed or Issues

### Case 3: Email with buried ask

**Input:** Three paragraphs of context before "we should probably sync at some point."

**Assertions:**
- Ask moved up (pyramid structure)
- Owner and deadline added or marked `[OWNER NEEDED]` / `[DATE NEEDED]`
- Subject line proposed if input included a weak subject

## Grading

Pass = all assertions met with evidence quoted from output. Fail = any fabricated data or banned word left in revised text.
