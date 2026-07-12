---
type: guide
title: AI Agent Delegation Patterns
description: Patterns and methods for delegating tasks to Claude Code, subagents, and external AI agents. Covers orchestration, handoff protocols, and quality control.
tags: [delegation, orchestration, subagents, multi-agent, handoff, patterns]
timestamp: 2026-07-07
---

# AI Agent Delegation Patterns

## Core Principle

Delegation to AI agents works like delegation to humans: clear scope, defined output, explicit constraints, and a verification step.

---

## Pattern 1: Single-Shot Delegation

Hand off a complete, self-contained task. Agent returns the result.

```
[You] -> Define task with full context -> [Agent]
[Agent] -> Does work -> Returns result -> [You]
[You] -> Verify and accept/reject
```

**When to use:** task is well-defined, low risk, doesn't need iterative feedback.

**Prompt template:**
```xml
<task>[Specific deliverable]</task>
<context>[Background the agent needs]</context>
<constraints>[Boundaries and rules]</constraints>
<output_format>[Exact format expected]</output_format>
<success_criteria>[How to verify the output is correct]</success_criteria>
```

---

## Pattern 2: Plan-Then-Execute

Agent plans first, you approve, then it executes.

```
[You] -> Request plan -> [Agent]
[Agent] -> Returns plan -> [You]
[You] -> Approve/modify plan -> [Agent]
[Agent] -> Executes plan -> Returns result
```

**When to use:** complex tasks, high-stakes changes, unfamiliar codebases.

**Prompt template:**
```
First, analyze this task and produce a plan. Do NOT execute yet.

Task: [description]
Context: [what you know]

Plan should include:
- Files you'll modify
- Order of operations
- Risks and mitigations
- How you'll verify success
```

---

## Pattern 3: Parallel Subagent Fan-Out

Split work across multiple agents running concurrently, then merge results.

```
[Orchestrator] -> Spawns Agent A (subtask 1)
                -> Spawns Agent B (subtask 2)
                -> Spawns Agent C (subtask 3)
[Agent A, B, C] -> Return results
[Orchestrator] -> Merges and validates
```

**When to use:** independent subtasks, large codebases, time-sensitive work.

**Example:**
```
Orchestrator prompt:
"Split this refactoring into 3 independent tasks:
 1. Agent A: Migrate database queries (src/db/)
 2. Agent B: Update API routes (src/routes/)
 3. Agent C: Update tests (tests/)
 Each agent works in isolation. I'll merge the results."
```

---

## Pattern 4: Iterative Refinement Loop

Agent produces draft, you give feedback, agent revises. Repeat until done.

```
[You] -> Initial request -> [Agent]
[Agent] -> Draft v1 -> [You]
[You] -> Feedback -> [Agent]
[Agent] -> Draft v2 -> [You]
[You] -> Accept
```

**When to use:** creative work, writing, design decisions, ambiguous requirements.

**Feedback format:**
```
What's working: [specific positives to preserve]
What to change: [specific issues with concrete direction]
Priority: [if multiple changes, which matters most]
```

---

## Pattern 5: Chain of Specialists

Route a task through multiple specialized agents in sequence.

```
[Agent 1: Research] -> findings
[Agent 2: Analysis] -> findings + analysis
[Agent 3: Writing] -> findings + analysis + final document
```

**When to use:** tasks requiring multiple skill sets (research + code + docs).

**Implementation:**
```
Step 1 prompt: "Research [topic]. Output: structured findings as bullet points."
Step 2 prompt: "Given these findings: [step 1 output]. Analyze implications. Output: ranked recommendations."
Step 3 prompt: "Given these recommendations: [step 2 output]. Write the implementation plan. Output: actionable document."
```

---

## Pattern 6: Guardian + Worker

One agent does work, another validates it.

```
[Worker Agent] -> Produces output
[Guardian Agent] -> Reviews output against criteria
[Guardian] -> Approves or sends back with issues
```

**When to use:** high-stakes outputs, security-sensitive code, compliance requirements.

**Guardian prompt:**
```xml
<role>You are a code reviewer. Your ONLY job is to find problems.</role>
<criteria>
- Security vulnerabilities (injection, auth bypass, data exposure)
- Logic errors
- Missing error handling
- Violations of: [project conventions]
</criteria>
<input>{{WORKER_OUTPUT}}</input>
<instructions>
List every issue found. For each: severity, location, description, fix suggestion.
If no issues: respond "APPROVED".
</instructions>
```

---

## Handoff Protocol

When passing work between agents or between you and an agent, include:

- **State:** what has been done so far
- **Objective:** what needs to happen next
- **Context:** relevant decisions already made
- **Constraints:** what must not change
- **Artifacts:** files, outputs, or references the next agent needs

---

## Quality Control Checklist

Before accepting agent output:

- Output matches requested format
- Constraints were respected
- No hallucinated information (check facts)
- Code compiles/runs (if applicable)
- Tests pass (if applicable)
- No unintended side effects
- Matches project conventions

---

## Common Failure Modes

| Failure | Cause | Fix |
|---------|-------|-----|
| Agent goes off-scope | Vague boundaries | Add explicit "do NOT" constraints |
| Output format wrong | Missing format spec | Provide example output |
| Hallucinated facts | No source material given | Provide source docs in context |
| Partial completion | Task too large for context | Break into subtasks |
| Conflicting changes | Parallel agents edited same file | Assign non-overlapping file ownership |
| Stale context | Agent working from outdated info | Refresh context before execution |
