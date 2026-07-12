---
type: reference
title: Skill Authoring Platform Adapters
description: Platform-specific skill formats. Load when authoring for a specific runtime.
timestamp: 2026-07-12
---

# Platform Adapters

Core procedure in `SKILL.md` is runtime-neutral.

## External runtime (omit path)

Some skill platforms expose session-extract or save-skill tools. This repo authors file-first under `ai/skills/`. If those tools are absent, manual draft from conversation history per Step 3 in `SKILL.md`.

## Cursor

**Skill path:** `.cursor/skills/<name>/SKILL.md` (optional mirror) or canonical `ai/skills/<name>/SKILL.md`

**Agent/subagent:** `.cursor/agents/<name>.md` or canonical `ai/agents/<name>.md`

**Rules:** `.cursor/rules/*.mdc` with `globs:`

**Omit path:** author in `ai/skills/` only; reference from `AGENTS.md` and `ai/README.md`

## Claude Code

**Skill path:** `.claude/skills/<name>/SKILL.md` (optional mirror)

**Subagent path:** `.claude/agents/<name>.md`

## Library (this repo)

**Canonical home:** `ai/skills/<name>/`

**Reviewer:** `ai-engineer` agent (`ai/agents/ai-engineer/AGENT.md`)

**Context-as-code:** `CONVENTIONS.md`
