---
type: reference
title: Techniques Quick Reference
description: Compact lookup table of all Claude prompting and delegation methods with when-to-use signals and example snippets.
tags: [quick-reference, lookup, techniques, methods, patterns]
timestamp: 2026-07-07
---

# Techniques Quick Reference

## Prompting Methods

| Method | When to Use | Key Move |
|--------|-------------|----------|
| Be clear and direct | Always (baseline) | State exactly what you want, no hedging |
| XML tags | Separating instructions from data, complex prompts | Wrap sections in semantic tags |
| Few-shot examples | Output format matters, task is ambiguous | 2-5 input/output pairs |
| Chain of thought | Math, logic, multi-step reasoning | "Think step by step in tags" |
| Extended thinking | Complex analysis, research, hard problems | Enable model feature, guide focus |
| Role assignment | Need domain expertise, consistent persona | System prompt with specific role + priorities |
| Prefill response | Force format, skip preamble | Start assistant message with desired prefix |
| Prompt chaining | Multi-phase tasks, validation needed | Pipeline of single-purpose prompts |
| Long context tips | Large documents, many files | Put key instructions at start AND end |

---

## Delegation Methods

| Pattern | When to Use | Key Move |
|---------|-------------|----------|
| Single-shot | Simple, well-defined task | Full context in one prompt, verify result |
| Plan-then-execute | Complex or risky changes | Get plan first, approve, then execute |
| Parallel fan-out | Independent subtasks | Spawn multiple agents, merge results |
| Iterative refinement | Ambiguous or creative work | Draft, feedback, revise cycle |
| Chain of specialists | Multi-skill pipeline | Sequential handoff between role-specific agents |
| Guardian + worker | High-stakes outputs | Separate creation from validation |

---

## Claude Code Commands

| Command | Purpose |
|---------|---------|
| `/plan` | Generate a plan before executing |
| `/compact` | Summarize conversation to free context |
| `/clear` | Reset conversation |
| `/cost` | Show token usage and cost |
| `/doctor` | Diagnose configuration issues |
| `/init` | Create CLAUDE.md for current project |
| `/memory` | View or edit persistent memory |
| `/review` | Review code changes or PRs |

---

## Context Engineering Checklist

Use this before sending any complex prompt:

1. **Role:** did you define who the agent is?
2. **Task:** is the objective unambiguous?
3. **Context:** does the agent have all background it needs?
4. **Format:** did you specify exact output structure?
5. **Examples:** did you show (not just tell) what good looks like?
6. **Constraints:** did you list what NOT to do?
7. **Verification:** can you check if the output is correct?

---

## XML Tag Library

```xml
<!-- Structure -->
<instructions>...</instructions>
<context>...</context>
<task>...</task>
<output>...</output>

<!-- Data -->
<document>...</document>
<data>...</data>
<input>...</input>
<examples>...</examples>

<!-- Reasoning -->
<thinking>...</thinking>
<plan>...</plan>
<analysis>...</analysis>

<!-- Control -->
<rules>...</rules>
<constraints>...</constraints>
<format>...</format>
<criteria>...</criteria>
```

---

## Prompt Templates

### Task Delegation (General)
```xml
<role>[Who the agent is]</role>
<task>[What to accomplish]</task>
<context>[Background and constraints]</context>
<rules>
- [Must do]
- [Must not do]
</rules>
<output_format>[Expected structure]</output_format>
```

### Code Change Request
```
Task: [specific change]
Why: [motivation]
Files: [scope]
Tests: [how to verify]
Don't touch: [protected areas]
```

### Analysis Request
```xml
<instructions>
Analyze [subject] and produce [deliverable].
Consider: [factors]
Ignore: [out of scope]
Format: [structure]
</instructions>
<source_material>
[data or documents]
</source_material>
```

### Review Request
```xml
<role>Critical reviewer focused on [dimension]</role>
<criteria>
- [criterion 1]
- [criterion 2]
</criteria>
<material>
[content to review]
</material>
<output_format>
For each issue: severity | location | problem | suggested fix
If clean: "APPROVED: [brief rationale]"
</output_format>
```

---

## Error Recovery

| Situation | Action |
|-----------|--------|
| Agent output is wrong format | Prefill the response with format start |
| Agent hallucinating facts | Add source docs to context, ask it to cite |
| Agent going off-scope | Add explicit "STOP if you find yourself doing X" |
| Output too long | Add word/token limit in instructions |
| Agent stuck in loop | Break into smaller subtask, provide worked example |
| Context window exceeded | Use /compact, split into subagent tasks |
