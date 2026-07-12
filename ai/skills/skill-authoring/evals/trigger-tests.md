---
type: eval
title: Skill Authoring Trigger Tests
description: should_trigger and should_not_trigger queries for the skill-authoring description field.
timestamp: 2026-07-08
---

# Trigger Tests

Tune `description` in SKILL.md against these. Pass: should_trigger >50% activation on 3 runs; should_not_trigger <50%.

## should_trigger

1. "Help me author a new skill from this runbook"
2. "Write a SKILL.md for harvesting intake items"
3. "Improve this skill's description so it triggers correctly"
4. "Review my skill structure before I promote it"
5. "Add evals to this skill folder"
6. "How do I bundle a script in a skill?"
7. "Harvest this intake folder into skills/"
8. "The skill keeps firing on the wrong tasks, fix the description"
9. "Create a rich skill folder with references and evals"
10. "What goes in references/ vs SKILL.md?"

## should_not_trigger

1. "Write a prompt for my email outreach" (prompt task, not skill structure)
2. "Design an agent persona for my coding assistant" (agent, not skill)
3. "Fix this Python bug" (code, not skill authoring)
4. "Summarize this PDF" (domain task)
5. "Configure MCP servers in Cursor settings" (setup, not skill authoring)
6. "Review this pull request" (code review)
7. "What is the weather today?" (unrelated)
8. "Help me write a blog post" (writing, not skill)
9. "Run lead-engine triage on my inbox" (domain skill execution)
10. "Explain what machine learning is" (general knowledge)

## Near-miss negatives (hardest)

- "Help me write better prompts for my skill" → prompt engineering, not skill folder authoring
- "Create a Cursor rule for my project" → rules, not skills
