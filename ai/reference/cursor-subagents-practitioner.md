---
type: reference
title: Cursor Subagents Practitioner Guide
description: Cursor subagent paths, frontmatter, delegation for this worldbuilding repo.
timestamp: 2026-07-12
---

# Cursor Subagents Practitioner Guide

Practitioner reference for Cursor subagents in this repo.

## Where agents live

| Layer | Path | Role |
| --- | --- | --- |
| **Canonical (portable)** | `ai/agents/<name>.md` | World kit agents; cite from AGENTS.md |
| **Rich agent + refs** | `ai/agents/ai-engineer/AGENT.md` + `reference/` | Authoring reviewer with on-demand docs |
| **Cursor mirror (optional)** | `.cursor/agents/ai-engineer.md` | Native picker discovery for ai-engineer |

Cursor reads flat `.md` with YAML frontmatter + body as system prompt.

## Frontmatter (Cursor)

```yaml
---
name: kebab-name
description: Imperative when-to-spawn; include exclusions
tools: Read, Write, Grep, Glob, Shell
model: inherit
---
```

## Agents in this repo

| Agent | When |
| --- | --- |
| `canon-consistency` | After identity/lore drafts |
| `brand-friction` | Before public ship |
| `project-brief-expander` | New `projects/` instance |
| `ai-engineer` | Agent/skill/prompt design review |
| `instruction-refiner` | Compress bloated prompt or SKILL.md body |

Skills live under `ai/skills/` (not `.cursor/skills/` unless mirrored).

## Delegation

Spawn subagents when:

- Task matches a specialist table above
- Main thread context is crowded
- Review gate required (PASS/FAIL)

Do not spawn for work covered by a loaded skill in the same turn unless user asks for agent review.

## Anti-patterns

| Mistake | Fix |
| --- | --- |
| Inline full prompt boilerplate × N files | Link `ai/prompts/_shared_constraints.md` |
| Agent with no out-of-scope | Add false-work boundaries |
| Load all ai-engineer reference docs at once | Use load-when table in AGENT.md |

## Related

| Doc | Role |
| --- | --- |
| `ai/agents/ai-engineer/reference/delegation-patterns.md` | Handoffs, verification |
| `ai/reference/context-engineering-principles.md` | Token budget, DRY |
| `ai/README.md` | Prompt catalog |
