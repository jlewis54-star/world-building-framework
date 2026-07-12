---
type: eval
title: Low-Ambiguity Notes Trigger Tests
description: should_trigger and should_not_trigger queries for low-ambiguity-notes description field.
timestamp: 2026-07-12
---

# Trigger Tests

## should_trigger

1. "Turn this meeting transcript into structured notes"
2. "Extract atomic notes from this creative critique"
3. "Format these call notes with low ambiguity"
4. "I have raw lore research bullets to store before canon"
5. "Meeting notes from this recording summary"
6. "Single-interpretation note from this excerpt"
7. "Parse this transcript for action items without inventing owners"
8. "Atomic note for this finding"
9. "Research capture destined for mood vault later"
10. "Quality pass on these notes, they are ambiguous"

## should_not_trigger

1. "Fill world/11_manifesto.md" (world prompt, not notes)
2. "Run canon-consistency review" (agent)
3. "Write a novel chapter" (creative fiction)
4. "Improve prose with writing-standard" (different skill)
5. "Create a new skill folder" (skill-authoring)
6. "Summarize this for fun" (no structure requirement)
7. "Schedule a calendar invite" (adapter-only)
8. "Promote this note to canon now" (notes-to-canon playbook, not raw capture)
9. "Translate transcript to French" (translation)
10. "Log this to external CRM" (external adapter)

## Near-miss negatives

- "Notes from the lore meeting" → trigger (meeting mode)
- "Clean up my world doc" → may trigger only if input is notes file, not world/ stub
