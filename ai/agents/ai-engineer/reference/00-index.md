---
type: index
title: AI Engineer Reference Library
description: Source-of-truth reference docs for the ai-engineer Kiro agent. Covers AGENTS.md standard, 2026 project folder structures, Claude prompt engineering, Claude Code, delegation patterns, reasoning-model prompting, context engineering, and multi-agent orchestration.
tags: [agents-md, folder-structure, prompt-engineering, claude-code, delegation, reasoning-models, context-engineering, multi-agent]
timestamp: 2026-07-07
---

# AI Engineer Reference Library

These are the canonical references the `ai-engineer` agent reads on demand. They are packaged inside the agent's own folder so they never get moved by vault reorganization. Edit at the source here; do not scatter copies elsewhere.

## Files

| File | Topic | Load when |
|------|-------|-----------|
| `agents-md-and-folder-structures.md` | AGENTS.md standard, .agents protocol, 2026 file hierarchy, project charter scaffold | Designing repo/agent file layout, writing AGENTS.md or CLAUDE.md, scaffolding an initiative |
| `prompt-engineering-methods.md` | Claude prompting: clarity, XML, few-shot, CoT, roles, prefill, chaining, agentic | Writing or improving any prompt |
| `claude-code-reference.md` | Claude Code capabilities, subagents, CLAUDE.md, MCP, skills, hooks | Delegating coding/automation, configuring Claude Code |
| `delegation-patterns.md` | Six delegation patterns, handoff protocol, QC checklist, failure modes | Structuring how work is handed to agents |
| `techniques-quick-reference.md` | Compact lookup tables of all methods + templates | Fast lookup, picking a technique |
| `reasoning-model-prompting.md` | DeepSeek R1, Kimi K2.5/K2.6, OpenAI o-series prompting | Prompting a reasoning/thinking model |
| `context-engineering.md` | 5-layer context stack, token budgets, patterns, anti-patterns, context rot | Designing what context an agent gets |
| `multi-agent-orchestration.md` | OpenAI Agents SDK primitives, orchestration patterns, guardrails, sessions | Building multi-agent systems |
| `open-knowledge-format.md` | OKF v0.1: markdown + YAML frontmatter knowledge bundles, required `type`, index/log files, conformance | Producing or enriching a knowledge corpus (research folders, account/topic bundles, reference libraries) |
| `skill-creation-best-practices.md` | Authoring skills (SKILL.md): scoping, progressive disclosure, calibrating control, instruction patterns, description triggering, eval-driven quality, bundling scripts | Writing, scoping, testing, or improving an agent skill |
| `agent-setup-practitioner-guide.md` | Durable practices for a personal agent setup: building blocks and where each instruction belongs, config-vs-workspace split, rules over resumes, context engineering, feedback loop, Managed AI Framework, knowledge base pattern | Structuring or improving an agent/skill setup |
| `ai/reference/cursor-subagents-practitioner.md` | Cursor subagent paths, frontmatter, built-ins, delegation; canonical folder vs flat invoke file | Configuring or spawning Cursor subagents in this repo |

## Priority order when instructions conflict

1. User's live chat prompt
2. Nearest AGENTS.md to the file being edited
3. Root AGENTS.md
4. Tool-specific file (CLAUDE.md, .cursorrules)
5. Memory / context files
