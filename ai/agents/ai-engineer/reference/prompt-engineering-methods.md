---
type: reference
title: Claude Prompt Engineering Methods
description: Canonical prompting techniques from Anthropic's platform documentation. Covers clarity, XML structuring, examples, thinking, chaining, roles, and prefilling.
tags: [prompt-engineering, techniques, xml, few-shot, chain-of-thought, roles]
timestamp: 2026-07-07
source: https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/overview
---

# Claude Prompt Engineering Methods

## Prerequisites

Before prompt engineering, establish:

1. Clear success criteria for your use case
2. Empirical tests against those criteria
3. A first draft prompt to improve

Not every failure is a prompting problem. Latency and cost are sometimes better solved by selecting a different model.

---

## 1. Be Clear and Direct

Claude responds best to explicit instructions. State exactly what you want rather than hinting.

**Principles:**
- Specify desired output format, length, and style
- If you want "above and beyond" behavior, request it explicitly
- Remove ambiguity: "Make it punchy" means nothing without an example
- One instruction per sentence reduces missed requirements

**Pattern:**
```
You are a [role]. Your task is [specific task].

Rules:
- [constraint 1]
- [constraint 2]

Output format: [exact format specification]
```

---

## 2. Use XML Tags for Structure

XML tags create clear boundaries that Claude parses reliably. They separate instructions from data, mark input/output sections, and prevent prompt injection.

**Common tags:**
- `<instructions>` ... `</instructions>` - wrap directives
- `<context>` ... `</context>` - wrap background information
- `<example>` ... `</example>` - wrap input/output pairs
- `<output>` ... `</output>` - mark where Claude should write
- `<thinking>` ... `</thinking>` - request visible reasoning

**Pattern:**
```xml
<instructions>
Analyze the following document and extract key findings.
Return results as a numbered list.
</instructions>

<document>
{{DOCUMENT_CONTENT}}
</document>
```

Why it works: tags create unambiguous boundaries. Claude knows exactly where instructions end and data begins.

---

## 3. Provide Examples (Few-Shot Prompting)

Examples collapse ambiguity faster than descriptions. One concrete input-output pair beats three paragraphs of explanation.

**Pattern:**
```xml
<examples>
<example>
<input>The product shipped late and the client is upset.</input>
<output>Escalation: delivery SLA breach. Action: account manager call within 24h, root cause report within 48h.</output>
</example>
<example>
<input>Minor UI bug reported, no revenue impact.</input>
<output>Standard: P3 ticket. Action: add to next sprint backlog.</output>
</example>
</examples>

Now process this:
<input>{{NEW_INPUT}}</input>
```

**Guidelines:**
- 2-5 examples is the sweet spot for most tasks
- Include edge cases in your examples
- Show the exact format you want reproduced
- Order matters: put the most representative example first

---

## 4. Let Claude Think (Chain of Thought)

Giving Claude space to reason before answering improves accuracy on complex tasks: math, multi-step analysis, code debugging, strategic decisions.

**Zero-shot CoT:**
```
Before answering, think through this step by step in <thinking> tags.
Then give your final answer.
```

**Structured CoT:**
```
<instructions>
Solve this problem. Show your reasoning in <thinking> tags.
Break the problem into steps. Check your work before answering.
</instructions>
```

**Extended Thinking (model feature):**
For Claude models with extended thinking enabled, the model automatically allocates reasoning tokens. No prompt needed, but you can guide focus:
```
Focus your thinking on [specific aspect]. Consider [constraint].
```

---

## 5. Give Claude a Role (System Prompts)

Role assignment activates relevant knowledge patterns and constrains behavior.

**Pattern:**
```
You are a senior backend engineer reviewing pull requests.
You prioritize: correctness, performance, readability (in that order).
You flag security issues as blockers.
You keep comments concise and actionable.
```

**Tips:**
- Specific roles outperform generic ones ("senior tax attorney" > "helpful assistant")
- Include the role's priorities and constraints
- State what the role would NOT do
- Combine with XML structure for complex personas

---

## 6. Prefill Claude's Response

Start Claude's response to lock format and prevent preamble.

**API pattern (assistant turn prefill):**
```json
{
  "role": "assistant",
  "content": "{\"analysis\":"
}
```

This forces Claude to continue with valid JSON.

**Use cases:**
- Force JSON output by starting with `{`
- Skip pleasantries by starting with the content
- Maintain character by starting in-character
- Lock into a specific format or language

---

## 7. Chain Complex Prompts

Break multi-step tasks into a pipeline of simpler prompts. Each step has one clear objective.

**Principles:**
- Identify subtasks and order them by dependency
- Use XML tags to pass outputs between steps
- Each subtask: single goal, clear input, defined output format
- Iterate: refine individual steps based on performance

**Pattern:**
```
Step 1: Extract key facts from document -> output as structured data
Step 2: Compare facts against criteria -> output as pass/fail list
Step 3: Generate summary report from pass/fail list -> final output
```

**When to chain vs. single prompt:**
- Chain when: task has distinct phases, intermediate outputs need validation, context window is a constraint
- Single prompt when: task is cohesive, all context fits, steps are tightly coupled

---

## 8. Agentic Systems

For building agents that use tools, make decisions, and operate autonomously.

**Key patterns:**
- Tool definitions: describe tools with clear schemas, parameters, and when-to-use guidance
- Decision loops: let the agent observe, think, decide, act, observe again
- Guardrails: define what the agent must NOT do, escalation triggers, scope boundaries
- Memory: pass relevant context from previous turns, summarize long histories

**Agent prompt structure:**
```xml
<role>You are [agent identity and purpose].</role>

<tools>
[Tool definitions with schemas and usage guidelines]
</tools>

<rules>
- [Constraint 1]
- [Constraint 2]
- [Escalation criteria]
</rules>

<task>
[Current objective]
</task>
```

---

## Model-Specific Notes

| Model | Best For | Thinking | Notes |
|-------|----------|----------|-------|
| Opus 4.8 | Complex reasoning, research, code | Extended thinking native | Highest capability, highest cost |
| Sonnet 4.6 | Balanced tasks, most workflows | Extended thinking available | Best cost-performance ratio |
| Haiku 4.5 | Fast tasks, classification, extraction | Standard CoT only | Lowest latency |
| Mythos 5 | Frontier capabilities | Native | Latest release |

---

## Anti-Patterns

- Vague instructions without examples
- Over-prompting simple tasks (wastes tokens, confuses model)
- Mixing multiple unrelated tasks in one prompt
- Not testing: always measure against success criteria
- Relying on implicit knowledge instead of providing context
