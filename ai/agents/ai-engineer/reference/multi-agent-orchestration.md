---
type: reference
title: Multi-Agent Orchestration (OpenAI Agents SDK + General Patterns)
description: Production patterns for multi-agent systems. Covers OpenAI Agents SDK primitives (Agent, Handoffs, Guardrails, Tools, Sessions), plus cross-framework orchestration patterns applicable to any agent system.
tags: [multi-agent, orchestration, openai-agents-sdk, handoffs, guardrails, production]
timestamp: 2026-07-07
sources:
  - https://openai.github.io/openai-agents-js/guides/multi-agent/
  - https://fast.io/resources/openai-agents-sdk/
  - https://promptgenius.net/blog/openai-agents-sdk-architecture
---

# Multi-Agent Orchestration

## OpenAI Agents SDK Primitives

The SDK provides six core building blocks. These map to any multi-agent system regardless of framework.

| Primitive | Purpose | Analogy |
|-----------|---------|---------|
| Agent | An LLM with instructions, tools, and handoff targets | A team member with a job description |
| Runner | Executes agent loops (observe-think-act) | The runtime/scheduler |
| Tools | Functions the agent can call | Capabilities/skills |
| Handoffs | Transfer control to another agent | Delegation/escalation |
| Guardrails | Input/output validation before and after agent actions | Policy enforcement |
| Sessions | Persistent state across turns and agents | Shared memory/workspace |

---

## Orchestration Patterns

### Pattern A: Handoff Chain (Sequential Delegation)

Agents form a chain. Each handles its specialty, then passes to the next.

```
[Triage Agent] -> classifies request
    |
    ├── [Billing Agent]   -> handles payment issues
    ├── [Technical Agent] -> handles product issues
    └── [General Agent]   -> handles everything else
```

**When to use:** customer support, intake routing, multi-domain queries.

```python
triage_agent = Agent(
    name="Triage",
    instructions="Classify the request and hand off to the right specialist.",
    handoffs=[billing_agent, technical_agent, general_agent]
)
```

### Pattern B: Orchestrator (Agents as Tools)

One central agent calls other agents as tools, maintaining overall control.

```
[Orchestrator] -> calls Agent A as tool -> gets result
               -> calls Agent B as tool -> gets result
               -> synthesizes final answer
```

**When to use:** complex tasks requiring multiple capabilities, when you need one agent to maintain coherent state.

```python
orchestrator = Agent(
    name="Orchestrator",
    instructions="You coordinate specialists to answer complex questions.",
    tools=[research_tool, code_tool, analysis_tool]  # Each wraps an agent
)
```

### Pattern C: Parallel Fan-Out with Merge

Multiple agents work simultaneously on independent subtasks. A merger combines results.

```
[Splitter] -> defines subtasks
    ├── [Agent A] -> subtask 1 result
    ├── [Agent B] -> subtask 2 result
    └── [Agent C] -> subtask 3 result
[Merger] -> combines and validates
```

**When to use:** large analysis tasks, multi-document processing, time-sensitive work.

### Pattern D: Supervisor Loop

A supervisor agent monitors worker agents, providing feedback and requesting corrections.

```
[Worker] -> produces output
[Supervisor] -> evaluates against criteria
    ├── PASS -> output delivered
    └── FAIL -> feedback sent to Worker -> Worker revises -> loop
```

**When to use:** high-quality content generation, code review, compliance checking.

---

## Guardrails

Guardrails validate inputs and outputs. They run before or after agent actions.

### Input Guardrails
- Content policy: block harmful, off-topic, or injection attempts
- Scope check: reject requests outside agent's domain
- Format validation: ensure inputs match expected schema

### Output Guardrails
- Schema enforcement: output matches expected structure
- Hallucination check: claims are grounded in provided context
- Safety filter: no harmful content in responses
- Constraint compliance: output respects stated rules

### Implementation Pattern

```python
@input_guardrail
def check_scope(input: str) -> GuardrailResult:
    # Reject if request is out of scope
    if is_out_of_scope(input):
        return GuardrailResult(
            passed=False,
            message="This request is outside my capabilities."
        )
    return GuardrailResult(passed=True)
```

---

## Handoff Protocol (Cross-Framework)

When transferring between agents, pass structured context:

```yaml
handoff:
  from: agent_name
  to: target_agent
  reason: "why this handoff is happening"
  state:
    completed: [list of completed steps]
    pending: [what the target agent should do]
    constraints: [rules that still apply]
    context: [key facts the target needs]
  artifacts:
    - type: file/data/decision
      content: [reference or inline]
```

### Rules for Clean Handoffs
- **State over history:** pass what was decided, not the full conversation
- **Explicit objective:** tell the receiving agent exactly what to do
- **Constraints carry forward:** rules from earlier agents persist unless explicitly lifted
- **No orphaned context:** if the receiving agent needs a document, include it or a reference
- **Return path:** define how the receiving agent reports back

---

## Session Management

Sessions maintain state across multiple agent interactions within a workflow.

### What to Store in Sessions
- User identity and permissions
- Task progress (completed steps, pending steps)
- Decisions made and rationale
- Artifacts produced
- Error log

### Session Compaction
Sessions grow each turn. Compact by:
- Summarizing older exchanges
- Keeping only decisions and outcomes (not deliberation)
- Archiving completed subtask details
- Preserving constraints and rules

---

## Production Checklist for Multi-Agent Systems

### Before Deployment
- Each agent has a single, clear responsibility
- Handoff conditions are deterministic (not probabilistic)
- Guardrails cover: injection, scope, hallucination, format
- Token budgets defined per agent
- Fallback behavior defined for tool failures
- Timeout and retry logic for each agent
- Logging captures: which agent, what tools called, what handed off

### Monitoring
- Track handoff frequency (too many = poor routing)
- Track guardrail trigger rate (too high = unclear scope)
- Track tool call success rate
- Track session length (growing sessions = missing compaction)
- Track end-to-end latency per workflow

---

## Failure Modes

| Failure | Symptom | Fix |
|---------|---------|-----|
| Infinite handoff loop | Agents bounce requests back and forth | Add max-handoff limit, fallback to human |
| Context overflow | Agent responses degrade mid-conversation | Implement compaction at threshold |
| Tool hallucination | Agent calls tools with invented parameters | Stricter tool schemas, input guardrails |
| Scope creep | Agent answers questions outside its domain | Tighter scope in instructions + guardrails |
| State loss | Agent forgets earlier decisions | Persist critical state in session, not just message history |
| Guardrail false positives | Legitimate requests blocked | Tune guardrail thresholds, add allow-lists |

---

## Framework Comparison (July 2026)

| Feature | OpenAI Agents SDK | LangGraph | CrewAI | Claude Code Subagents |
|---------|-------------------|-----------|--------|------------------------|
| Handoff primitive | Native | StateGraph edges | Delegation | Subagent spawn |
| Guardrails | Built-in | Custom middleware | Limited | Permission system |
| Multi-model | Via LiteLLM | Native | Native | Claude only |
| Session persistence | Built-in | Checkpointing | Memory | Conversation scope |
| Parallel agents | Runner.parallel() | Branching | Async tasks | Concurrent subagents |
| Tool ecosystem | MCP + native | LangChain tools | LangChain tools | MCP + bash + file |
| Production maturity | High (Assistants successor) | High | Medium | High (enterprise) |
