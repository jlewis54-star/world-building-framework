---
type: changelog
title: AI Engineer Agent Changelog
description: Version history of the AI Engineer agent. Source-only, excluded on deploy.
timestamp: 2026-07-07
---

# Changelog

All notable changes to the AI Engineer agent. Newest first. Semantic versioning. The version here mirrors the `version` field in `AGENT.md`.

## [1.0.1] - 2026-07-08

### Changed
- Replaced Windows Kiro paths with library paths (`ai/agents/ai-engineer/reference/`).
- Made canonical source runtime-neutral; library is source of truth.
- Documented Cursor surfaces (subagent + invoke skill) in AGENT.md.

### Notes
- Full Cursor install: sync `.cursor/agents/ai-engineer.md`, add `.cursor/skills/ai-engineer/SKILL.md`.

## [1.0.0] - 2026-07-07

### Added
- Initial snapshot of the live AI Engineer agent into the library as the source of truth. Copied from `~/.kiro/agents/ai-engineer.md` and its reference folder; the live agent was not modified.
- `AGENT.md` (the definition: role, reference-load table, operating principles, voice).
- Reference library, 12 docs: `00-index`, `agents-md-and-folder-structures`, `prompt-engineering-methods`, `claude-code-reference`, `delegation-patterns`, `techniques-quick-reference`, `reasoning-model-prompting`, `context-engineering`, `multi-agent-orchestration`, `open-knowledge-format`, `skill-creation-best-practices`, `agent-setup-practitioner-guide`.

### Notes
- This snapshot captures the state after adding OKF, skill-creation, and practitioner-guide references and wiring them into the load table and operating principles.
- From here, improve the agent in this library copy, bump the version, log the change here, then deploy to the runtime.
