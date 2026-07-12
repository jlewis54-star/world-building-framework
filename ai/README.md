# AI Kit

First-class generation and review helpers. Human owns canon. AI proposes. Checklists gate `signed_off`.

Drafted output must follow [`../WRITING.md`](../WRITING.md). Prefer [`skills/writing-standard`](skills/writing-standard/SKILL.md).

## Layout

| Path | Role |
| --- | --- |
| `skills/` | Vendored skills (portable in-repo) |
| `prompts/` | Per-doc generation prompts (mirror template `## AI Prompt` blocks; runnable standalone) |
| `agents/` | Review / expand agents for Cursor and similar |

## Skills

| Skill | When |
| --- | --- |
| [`writing-standard`](skills/writing-standard/SKILL.md) | Prose pass on any drafted doc; AI-slop removal; studio writing checklist |
| [`low-ambiguity-notes`](skills/low-ambiguity-notes/SKILL.md) | Meeting/transcript/raw capture → notes; not for filling bible templates directly |

## Usage

1. Open matching prompt under `prompts/` or template embedded prompt.
2. Paste signed upstream docs as context.
3. Write draft into `world/` with `status: draft`.
4. Run `writing-standard` on the draft when polishing.
5. Run an agent from `agents/` before elevating to `review` / `signed_off`.

## Agents

| Agent | When |
| --- | --- |
| [`canon-consistency`](agents/canon-consistency.md) | After lore/identity drafts; before sign-off |
| [`brand-friction`](agents/brand-friction.md) | Before shipping any public asset (Shipping Ledger) |
| [`project-brief-expander`](agents/project-brief-expander.md) | When spinning a new `projects/` instance |

## Bloat excluded

No multi-agent orchestration frameworks, auto-commit bots, trend scrapers, competitor market analyses, or rigid content calendars.
