---
type: reference
title: Context Engineering Principles
description: Core operating principles for multi-agent workspaces. Token budget, delegation, handoffs, scope discipline. Load when designing orchestrators or steering files.
timestamp: 2026-07-12
tags: [context-engineering, orchestration, delegation, scope, agents]
---

# Context Engineering Principles

Session-level decisions for how agents share context. What enters the prompt window matters more than raw model capability.

Pair with `ai/agents/ai-engineer/reference/context-engineering.md` for practitioner depth (five-layer stack, token budgets).

## Decisions (stable)

| Principle | Rule |
| --- | --- |
| **Context engineering first** | Optimize what the agent sees, not only which model runs |
| **Delegation over monolith** | Orchestrator decomposes and synthesizes; it does not do specialist work |
| **Handoff relay** | Multi-agent chains use one handoff file. Cleared at start, updated between agents, cleared at end |
| **Scope discipline** | Answer what was asked. No extras. Forbidden-pattern lists are enforced |
| **DRY prompts** | Shared constraints live in one file (`ai/prompts/_shared_constraints.md`); prompts link, do not duplicate |

## Artifacts to maintain

| Artifact | Purpose |
| --- | --- |
| `AGENTS.md` | Lean persona + paths; under ~2000 tokens |
| `ai/prompts/_shared_constraints.md` | Shared generation rules |
| `ai/README.md` | Prompt catalog + dependency graph |
| Per-agent out-of-scope | False-work reduction |

Paths vary by runtime (Cursor rules, Claude agents). Canonical copies live under `ai/agents/` and `ai/reference/`.

## Principles established

- **Start with one agent; split when you feel pain.** No preemptive specialists.
- **Link, do not duplicate lore.** Golden Rule: edit `world/` once; `projects/` cite paths.
- **Retrieve on demand.** Load-when tables beat monolithic instructions.
- **Verify before done.** Review agents output PASS/FAIL gates.

## Related paths (this repo)

| Path | Role |
| --- | --- |
| `ai/agents/ai-engineer/` | Agent and skill design reviewer |
| `ai/reference/cursor-subagents-practitioner.md` | Cursor subagent wiring |
| `playbook/notes-to-canon.md` | Notes → canon promotion |
| `CONVENTIONS.md` | Repo norms |
