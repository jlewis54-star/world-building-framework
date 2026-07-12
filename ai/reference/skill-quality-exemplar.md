---
type: reference
title: Skill Quality Exemplar
description: What a gold-standard rich skill looks like in this repo. Canonical example is writing-standard.
timestamp: 2026-07-12
---

# Skill Quality Exemplar

**Canonical example:** `ai/skills/writing-standard/`

When authoring or reviewing a skill, compare against this pattern. Cite gaps by name, not vague "make it better."

`ai/skills/skill-authoring/examples/minimal-skill/` teaches folder skeleton. `writing-standard` teaches quality at full depth.

## What good looks like

### 1. Lean core, real references

| Bar | Exemplar |
| --- | --- |
| `SKILL.md` under ~500 lines | Yes |
| Broken load-when links | None |
| Topic detail in core | Pushed to `references/` with load-when table |
| Platform names in core | Adapters file when needed |

### 2. Coherent unit

One job per skill. Pass/fail: "Would loading only this skill complete the request?"

### 3. Grounded expertise

Worldbuilding-specific conventions, not generic LLM filler.

### 4. Evals

`evals/trigger-tests.md`, `evals/quality-checks.md`, `evals/evals.json` with traceable assertions.

### 5. Voice

No em dashes. Link `reference/voice.md`; do not restate banned words.

## Review checklist

| Check | Pass |
| --- | --- |
| Description triggers on realistic phrasing | Yes |
| Out-of-scope section present | Yes |
| Workflow has validate / on-failure where needed | Yes |
| CHANGELOG semver matches frontmatter | Yes |
| Exemplar gap named | Top 1-3 diffs vs writing-standard |

## Pointers

- Procedure: `ai/skills/skill-authoring/SKILL.md`
- Deep rules: `ai/agents/ai-engineer/reference/skill-creation-best-practices.md`
- Skeleton: `ai/skills/skill-authoring/examples/minimal-skill/`
