---
type: eval
title: Writing Standard Trigger Tests
description: should_trigger and should_not_trigger queries for the writing-standard description field.
timestamp: 2026-07-08
---

# Trigger Tests

Tune `description` in SKILL.md against these. Pass: should_trigger >50% activation on 3 runs; should_not_trigger <50%.

## should_trigger

1. "Improve this email, make it more concise"
2. "Rewrite this doc to studio writing standards"
3. "Review my writing and fix passive voice"
4. "Make this sound less like AI wrote it"
5. "Humanize this draft"
6. "Check this status update against writing standards"
7. "This paragraph is too vague, add specifics"
8. "Fix the subject line and opening of this email"
9. "Remove weasel words from this text"
10. "Edit this 1-pager for clarity and pyramid structure"

## should_not_trigger

1. "Write a poem about the ocean" (creative fiction)
2. "Author a new skill from this runbook" (skill-authoring)
3. "Fix this Python bug" (code)
4. "Design a marketing campaign with edgy brand voice" (creative marketing)
5. "Summarize this PDF" (summarization, not editing)
6. "Translate this to French" (translation)
7. "What is the weather in Seattle?" (factual lookup, not editing)
8. "Run lead-engine triage" (domain skill)
9. "Create an agent persona" (agent design)
10. "Proofread only for spelling" (narrow spell-check, not standards)

## Near-miss negatives (hardest)

- "Make this email more persuasive" → may trigger; OK if user wants clarity + data, not hype
- "Write my weekly status update from these bullets" → drafting task; trigger only if editing existing text
- "Is this grammatically correct?" → grammar-only, not full standards pass
