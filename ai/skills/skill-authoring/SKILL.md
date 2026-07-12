---
type: skill
name: skill-authoring
title: Skill Authoring
description: >-
  Author, test, and improve agent skills end to end. Use when creating a new
  SKILL.md, refining skill descriptions for triggering, writing evals, bundling
  scripts, or reviewing skill structure, even if the user does not name
  SKILL.md or agentskills format. Invoke for author a skill, skill evals, or
  improve this skill.
version: "1.0.3"
timestamp: 2026-07-12
---

# Skill Authoring

One job: take real expertise and shape it into a rich skill folder under `ai/skills/` that triggers correctly and improves output when it runs.

**In scope:** new skills, description tuning, evals, scripts, structure review.

**Out of scope:** general prompt writing (use `ai/prompts/`), agent persona design (use `ai/agents/`), world lore drafting.

## Standards (load on demand)

| Reference | Load when |
| --- | --- |
| `ai/agents/ai-engineer/reference/skill-creation-best-practices.md` | Any authoring or review pass |
| `ai/reference/skill-quality-exemplar.md` | Review bar; compare to `ai/skills/writing-standard/` |
| `references/instruction-architecture.md` | Workflow steps, error handling, branches |
| `references/adapters.md` | Cursor, Claude Code, external runtime |
| `references/sop-to-skill.md` | Draft from SOP or runbook |
| `examples/minimal-skill/SKILL.md` | Folder skeleton only |
| `ai/skills/writing-standard/` | Gold-standard rich skill in this repo |

## Target folder shape

```
ai/skills/<skill-name>/
  SKILL.md
  CHANGELOG.md
  references/
  scripts/          (optional)
  examples/         (optional)
  evals/
  assets/           (optional)
```

OKF: every non-reserved `.md` gets non-empty `type` in frontmatter. Kebab-case folder name.

## Workflow

### 1. Ground in real expertise

**Mode:** gather.

- **Extract:** do the task once with an agent; capture corrections; distill.
- **Synthesize:** feed runbooks, existing SKILL.md, session logs.

**Validate:** material is project-specific, not generic LLM filler.

**On failure:** stop; get real inputs.

### 2. Scope the coherent unit

**Mode:** scope.

Pass/fail: "Would loading only this skill complete the request without unrelated skills?"

### 3. Draft SKILL.md

**Mode:** draft.

1. Frontmatter: `name`, imperative `description`, `type: skill`, `version`.
2. Purpose and out-of-scope (2-3 sentences each).
3. Load-when reference table.
4. Numbered workflow with Mode / Validate / On failure where steps branch.
5. Output format and gotchas.

Push overflow to `references/`. Adapters in `references/adapters.md`.

### 4. Bundle support files

**Mode:** bundle.

- `evals/`: trigger-tests.md, quality-checks.md, evals.json
- `examples/` when tone or format is non-obvious
- `scripts/` when traces show repeated reinvention

### 5. Test triggering

**Mode:** validate triggers.

~8-10 should_trigger and ~8-10 should_not_trigger in `evals/trigger-tests.md`. Tune description.

**On failure:** rewrite description; re-run holdout queries.

### 6. Test output quality

**Mode:** validate output.

Run 2-3 realistic tasks with and without the skill. Record in `evals/quality-checks.md`.

### 7. Review before promotion

**Mode:** review.

Compare to `ai/reference/skill-quality-exemplar.md` and `ai/skills/writing-standard/`. Invoke `ai-engineer` for gap review if needed.

### 8. Place and record

**Mode:** ship.

- Home: `ai/skills/<name>/`
- Update `CHANGELOG.md` and `ai/README.md` skills table
- Update `ai/VENDORED.md` if vendored from external library

## Gotchas

- Vague triggers cause false activations. Write triggers like API descriptions.
- Point to `reference/voice.md`; do not restate banned words.
- Quick-specific tools may be absent on Cursor; use omit paths in `references/adapters.md`.

## Voice

Direct. No em dashes. Banned words per `reference/voice.md`.
