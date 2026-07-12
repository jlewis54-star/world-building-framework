---
type: reference
title: Claude Code Reference
description: Capabilities, subagents, CLAUDE.md conventions, MCP integration, and skills for Claude Code. Use this to delegate coding and automation tasks.
tags: [claude-code, agents, subagents, mcp, skills, automation, terminal]
timestamp: 2026-07-07
source: https://docs.anthropic.com/en/docs/claude-code
---

# Claude Code Reference

## What It Is

Claude Code is an agentic coding tool that operates in your terminal, IDE, desktop app, or browser. It reads your codebase, edits files, runs shell commands, and integrates with development tools via natural language.

---

## Core Capabilities

- **Read files** across a codebase (any language, any structure)
- **Edit files** with precise diffs or full rewrites
- **Run shell commands** (build, test, deploy, git, package managers)
- **Search codebases** with grep, find, and semantic search
- **Web fetch** for documentation lookups
- **Multi-file refactoring** across large projects
- **Git operations** (commit, branch, PR creation, conflict resolution)

---

## Subagents

Subagents run in isolated context windows with their own system prompts, tool access, and permissions. They return a result summary, not the full internal reasoning.

**Cursor-specific guide:** `ai/reference/cursor-subagents-practitioner.md` (paths, frontmatter, built-ins, delegation gates for this library).

### Built-in subagent types (Claude Code)

| Subagent | Purpose | When to Use |
|----------|---------|-------------|
| Plan | Analyze a task and produce a step-by-step plan | Before complex multi-file changes |
| Explore | Navigate codebase, find relevant files and patterns | When you don't know where something lives |
| Task | Execute a focused subtask in isolation | For parallel work or cost control |

### Built-in subagent types (Cursor)

| Subagent | Purpose | When to Use |
|----------|---------|-------------|
| Explore | Repo navigation and context without polluting main thread | Unknown file locations, large codebase scout |
| Bash | Shell commands in isolation | Long-running or noisy terminal output |
| Browser | Filter DOM/MCP browser noise | Web automation, UI verification |

Cursor custom agents live in `.cursor/agents/*.md`. Library canonical folders live in `agents/<name>/`. See practitioner guide above.

### Subagent Pattern

```
Main session delegates to subagent:
- Subagent gets its own context window
- Subagent does focused work
- Subagent returns summary result
- Main session continues with the summary

Benefit: keeps main context clean, reduces cost
```

### When to Use Subagents

- Task is expensive and you want to keep the main context small
- Work can be parallelized (multiple subagents run concurrently)
- A subtask needs different permissions or tool access
- You want to isolate potentially risky operations

---

## CLAUDE.md

The `CLAUDE.md` file is project-level context that Claude Code reads automatically. Place it at the project root.

### Structure

```markdown
# Project: [Name]

## Overview
[What this project does, key architecture decisions]

## Tech Stack
[Languages, frameworks, key dependencies]

## Conventions
- [Code style rules]
- [Naming conventions]
- [File organization patterns]

## Commands
- Build: `[command]`
- Test: `[command]`
- Lint: `[command]`
- Deploy: `[command]`

## Important Files
- [path] - [what it does]
- [path] - [what it does]

## Rules
- [Things Claude should always do]
- [Things Claude should never do]
```

### Best Practices for CLAUDE.md

- Keep it under 2000 tokens for fast loading
- Update it when conventions change
- Include the commands Claude needs most often (build, test, lint)
- List files that are critical or fragile
- State what NOT to modify (config files, generated code, etc.)

---

## MCP (Model Context Protocol)

MCP connects Claude Code to external tools and data sources through a standardized protocol.

### What MCP Provides

- Tool definitions: external capabilities Claude Code can invoke
- Resource access: databases, APIs, file systems, services
- Context injection: relevant information fetched on demand

### MCP Server Setup

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@org/mcp-server"],
      "env": {
        "API_KEY": "..."
      }
    }
  }
}
```

### Common MCP Servers

- Filesystem: read/write files outside the project
- Database: query PostgreSQL, SQLite, etc.
- GitHub: PRs, issues, repository operations
- Slack: send messages, read channels
- Web Search: fetch live information

---

## Skills

Skills are reusable prompt templates stored in `.claude/skills/` that Claude Code can invoke for recurring tasks.

### Skill File Structure

```markdown
---
name: [skill-name]
description: [when to use this skill]
---

# [Skill Name]

[Instructions for the task, including format, constraints, and output expectations]
```

### Example Skill

```markdown
---
name: write-test
description: Generate a unit test for a given function
---

# Write Test

Given a function, write a comprehensive unit test that covers:
- Happy path
- Edge cases (null, empty, boundary values)
- Error conditions

Use the project's existing test framework and conventions.
Match the naming pattern of existing tests in the same directory.
```

---

## Automations and Hooks

### Automations

Scheduled or triggered Claude Code sessions that run without user input.

Use cases:
- Nightly code review of new PRs
- Auto-fix lint errors on commit
- Generate documentation after file changes

### Hooks

Event-driven actions that fire before or after Claude Code operations.

Hook points:
- Pre-edit: validate before changes are applied
- Post-edit: run linter or tests after changes
- Pre-command: security check before shell execution
- Post-command: capture output for context

---

## Delegation Prompts for Claude Code

When asking Claude Code to do work, structure your request:

```
Task: [What you want done]
Context: [Why, and any constraints]
Files: [Specific files if known, or "find the relevant ones"]
Output: [What success looks like]
Constraints: [What not to do, what to preserve]
```

### Good Delegation Examples

```
Task: Refactor the authentication module to use JWT instead of sessions.
Context: We're moving to a stateless architecture. The auth module is in src/auth/.
Files: src/auth/*, src/middleware/auth.ts
Output: All tests pass, existing API contracts unchanged.
Constraints: Don't modify the user model schema. Keep backward compatibility for 2 weeks.
```

```
Task: Find and fix the memory leak in the WebSocket handler.
Context: Production shows RSS growing 50MB/hour under load.
Files: Start with src/ws/ and follow the connection lifecycle.
Output: Identified leak source, applied fix, added a regression test.
Constraints: Don't refactor unrelated code.
```
