---
type: reference
title: Reasoning Model Prompting
description: How to prompt reasoning/thinking models (DeepSeek R1, Kimi K2.5/K2.6, OpenAI o-series). Different rules than standard LLMs because these models run internal chain-of-thought before answering.
tags: [reasoning-models, deepseek, kimi, openai-o-series, thinking, chain-of-thought]
timestamp: 2026-07-07
sources:
  - https://api-docs.deepseek.com/guides/thinking_mode
  - https://platform.kimi.ai/docs/guide/use-kimi-k2-thinking-model
  - https://developers.openai.com/docs/reasoning
---

# Reasoning Model Prompting

## Core Difference

Standard LLMs (GPT-5, Claude Sonnet) follow your instructions linearly. Reasoning models (DeepSeek R1, Kimi K2.5/K2.6, OpenAI o3/o4) run an internal thinking phase first, then produce a final answer. This changes what works.

**Key insight:** these models deprioritize heavy persona or constraint instructions once they enter thinking mode. They reason through the problem on their own terms, then format the answer.

---

## General Rules for All Reasoning Models

| Do | Don't |
|----|-------|
| Ask specific, well-scoped questions | Ask vague open-ended questions (produces hedging) |
| Provide the problem clearly upfront | Bury the actual question in context |
| Give concrete success criteria | Rely on persona/role to shape reasoning |
| Supply source material and constraints | Assume the model will search for context |
| Let the model think (don't rush with "be brief") | Add "think step by step" (redundant, already built-in) |
| Use structured output format specs | Over-constrain the thinking process |

---

## DeepSeek R1

### How It Works
Before outputting the final answer, R1 generates an internal chain-of-thought reasoning trace. This trace is visible in the API response as a separate field.

### Prompting Guidelines

- **Skip CoT instructions:** "Think step by step" is redundant. R1 already does this internally.
- **Direct questions win:** vague questions produce long, hedging answers. R1 reasons through every edge case it can imagine without a clear target.
- **System prompt limits:** heavy persona instructions get deprioritized during thinking. Keep system prompts short and factual.
- **Format at the end:** specify output format requirements after the problem statement, not before.
- **Language consistency:** R1 can mix languages during reasoning. Add "Respond entirely in English" if needed.

### Optimal R1 Prompt Structure

```
[Short system context if needed - under 100 words]

Problem: [Clear, specific problem statement]

Constraints:
- [Hard constraint 1]
- [Hard constraint 2]

Output format: [Exact structure expected in final answer]
```

### Best Use Cases for R1
- Multi-step math and logic
- Code debugging (follow the chain of state)
- Complex analysis with multiple variables
- Problems requiring backtracking or considering alternatives

---

## Kimi K2.5 / K2.6 (Moonshot AI)

### How It Works
Kimi uses an "Agent Swarm" system that dynamically decomposes tasks into sub-agents for reasoning and execution. K2.5 uses ~100 sub-agents, K2.6 uses ~300, giving K2.6 better task coordination.

### Key Features
- **Thinking mode:** on by default, can be disabled
- **Preserved Thinking** (K2.6 only): reasoning carries across turns
- **1T parameter MoE**, 32B active: efficient but powerful
- **Multimodal:** vision and language understanding

### Prompting Guidelines

- **Decomposable tasks shine:** give tasks that can be split into independent sub-problems. The swarm architecture handles these best.
- **Agentic prompts work:** Kimi is optimized for multi-step execution, not just Q&A.
- **Context window:** 128K-256K tokens. Use it. Long documents are fine.
- **Disable thinking for simple tasks:** turn off thinking mode when speed matters more than depth.

### Kimi Prompt Structure

```
Task: [What to accomplish]

Sub-goals (if complex):
- [Independent sub-task 1]
- [Independent sub-task 2]
- [Integration step]

Context: [Relevant background]
Format: [Output specification]
```

### Best Use Cases for Kimi
- Coding tasks (K2.7 Code model is state-of-art for open source)
- Multi-file analysis
- Research with many sources
- Tasks that decompose into parallel sub-problems

---

## OpenAI o-Series (o3, o4-mini)

### How It Works
Models trained with large-scale RL to refine their own chain-of-thought. Accuracy rises with more "thinking time." Configurable via `reasoning_effort` parameter (low/medium/high).

### Prompting Guidelines

- **Reasoning effort control:** use `reasoning_effort: "low"` for simple queries, `"high"` for complex ones. This controls how many internal reasoning tokens the model uses.
- **No CoT scaffolding needed:** like R1, these models reason internally. Don't add "think step by step."
- **Function calling works differently:** o-series models plan tool use as part of their reasoning. Provide clear tool schemas with explicit when-to-use descriptions.
- **Structured outputs:** use the `response_format` parameter for JSON schema enforcement rather than prompting for format.

### o-Series Prompt Structure

```json
{
  "model": "o3",
  "reasoning_effort": "high",
  "messages": [
    {"role": "system", "content": "[Brief role + constraints]"},
    {"role": "user", "content": "[Clear problem statement with all needed context]"}
  ],
  "response_format": {"type": "json_schema", "json_schema": {}}
}
```

### Best Use Cases for o-Series
- Complex multi-step reasoning
- Math and science problems
- Strategic planning with tradeoffs
- Code generation with correctness requirements

---

## Model Selection Matrix

| Scenario | Best Model | Why |
|----------|-----------|-----|
| Multi-step math/logic | DeepSeek R1 or o3 | Deep reasoning traces |
| Code debugging | R1 or Kimi K2.7 Code | State-tracking through execution |
| Parallel sub-tasks | Kimi K2.6 | Agent swarm decomposes naturally |
| Fast reasoning with cost control | o4-mini (low effort) | Configurable compute |
| Long document analysis | Kimi K2.5 (128K-256K) | Large native context |
| Tool-heavy agentic work | o3 with function calling | Integrated tool planning |
| Research with many sources | Kimi K2.6 or o3 Deep Research | Multi-agent coordination |

---

## Anti-Patterns for Reasoning Models

- **"Think step by step":** redundant. Wastes tokens in the prompt.
- **Long system prompts with personality:** gets ignored during reasoning phase.
- **"Be brief":** conflicts with the model's need to reason fully. Specify output length separately from reasoning.
- **Multiple questions in one prompt:** the model may over-reason on one and under-reason on others. One problem per prompt.
- **Providing the answer approach:** let the model find its own path. Constraining the reasoning method often produces worse results than constraining the output format.
