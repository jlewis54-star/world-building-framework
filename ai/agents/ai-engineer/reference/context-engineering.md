---
type: guide
title: Context Engineering (2026 Paradigm)
description: The successor to prompt engineering. Designing dynamic systems that provide the right information and tools, in the right format, at the right time. Covers the 5-layer context stack, token budgeting, patterns, and anti-patterns.
tags: [context-engineering, token-budgeting, memory, retrieval, state, production, agents]
timestamp: 2026-07-07
sources:
  - https://www.taskade.com/blog/context-engineering
  - https://activewizards.com/blog/context-engineering-for-production-agents/
  - https://www.digitalapplied.com/blog/context-engineering-agent-reliability-playbook-2026
---

# Context Engineering (2026 Paradigm)

## The Shift

Prompt engineering asks: "What words make the model do what I want?"
Context engineering asks: "What information does the model need, in what format, at what time?"

Modern models (Claude 4.6, GPT-5, Gemini 2.5) understand intent well. The bottleneck moved from "how to ask" to "what to provide." Context overload degrades performance. Context starvation produces hallucination.

---

## The 5-Layer Context Stack

Every LLM call assembles context from these layers. Each has different persistence, cost, and failure modes.

### Layer 1: System Prompt (Static Instructions)
- **What:** role, rules, output format, constraints
- **Persistence:** fixed per session or deployment
- **Failure mode:** bloat (too many rules) causes selective compliance
- **Budget:** 500-2000 tokens for most agents

### Layer 2: Tools (Capability Definitions)
- **What:** function schemas, when-to-use descriptions, parameter specs
- **Persistence:** fixed per agent configuration
- **Failure mode:** too many tools causes selection confusion
- **Budget:** 200-500 tokens per tool, 10-20 tools max before degradation

### Layer 3: Memory (Persistent Knowledge)
- **What:** user preferences, past decisions, learned facts, project state
- **Persistence:** cross-session, decays over time
- **Failure mode:** stale entries override current reality
- **Budget:** 500-2000 tokens, curated and compressed

### Layer 4: Retrieval (Dynamic Knowledge)
- **What:** documents, code, data fetched for the current task
- **Persistence:** per-query, discarded after use
- **Failure mode:** irrelevant retrieval pollutes context, overwhelming signal
- **Budget:** 2000-8000 tokens, relevance-ranked

### Layer 5: State (Conversation + Tool Outputs)
- **What:** message history, tool call results, intermediate outputs
- **Persistence:** within session, grows each turn
- **Failure mode:** unbounded growth causes truncation of early context
- **Budget:** grows dynamically, must be compacted or summarized

---

## Token Budget Framework

For a model with 128K context window, a production agent might allocate:

```
System prompt:       1,500 tokens  (fixed)
Tool definitions:    3,000 tokens  (fixed)
Memory:              1,500 tokens  (semi-fixed)
Retrieved docs:      6,000 tokens  (per-query)
Conversation:        8,000 tokens  (growing, compacted at threshold)
Reserved for output: 4,000 tokens  (generation budget)
─────────────────────────────────
Total allocated:    24,000 tokens
Headroom:          104,000 tokens (for complex queries, long docs)
```

**Rule:** never let total context exceed 75% of window for complex reasoning tasks. Models reason worse when stuffed to capacity.

---

## Five Context Engineering Patterns

### Pattern 1: Persistent Context Restoration
Save critical context between sessions. On session start, inject:
- User identity and preferences
- Active project state
- Recent decisions and their rationale
- Unresolved items

Implementation: memory layer with eviction rules (staleness, relevance score).

### Pattern 2: Tool Gating
Don't load all tools into every call. Gate tool availability based on:
- Current task type
- Conversation phase (planning vs. execution)
- User permissions

Why: 20 tools in context = decision paralysis. 5 relevant tools = clean execution.

### Pattern 3: Context Compression
As conversation grows, compress older turns into summaries. Keep:
- Decisions made
- Constraints established
- Key facts
- Current state

Discard:
- Exploratory back-and-forth
- Superseded information
- Verbose tool outputs (keep conclusions only)

### Pattern 4: Retrieval Budgeting
For RAG systems, allocate fixed token budgets per retrieval call:
- Rank by relevance
- Truncate at budget limit
- Re-rank after retrieval (cross-encoder)
- Prefer fewer, higher-quality chunks over many fragments

### Pattern 5: Multi-Agent Context Sharing
When agents hand off to each other:
- Pass structured state, not raw conversation
- Include: what was decided, what's pending, what constraints apply
- Exclude: how decisions were reached (unless debugging)
- Use the Handoff Protocol from delegation-patterns.md

---

## Five Anti-Patterns

### Anti-Pattern 1: Context Stuffing
Loading everything "just in case." Every irrelevant token dilutes attention on what matters.
Fix: retrieve on demand. Inject only what the current step needs.

### Anti-Pattern 2: Immortal Memory
Never expiring old context. A preference from 6 months ago may contradict today's reality.
Fix: timestamp all memory. Evict entries older than threshold. Flag conflicts for human resolution.

### Anti-Pattern 3: Monolithic System Prompts
3000-token system prompts with every rule the agent might ever need.
Fix: modular system prompts. Load rule sets based on current task type. Core rules (200 tokens) + task-specific rules (loaded dynamically).

### Anti-Pattern 4: Retrieval Without Reranking
Embedding search returns "similar" documents but not necessarily "relevant to the current question." Semantic similarity is not task relevance.
Fix: cross-encoder reranking. Query reformulation. Chunk scoring against the actual user question.

### Anti-Pattern 5: Ignoring Token Economics
Not tracking how much context each layer consumes. Silent truncation when budget overflows.
Fix: instrument context assembly. Log token counts per layer. Alert when any layer exceeds its budget. Fail visibly rather than silently truncating.

---

## Context Rot

Research confirms model performance degrades as input token count grows, across all major models. This is "context rot": the model pays less attention to information in the middle of long contexts.

**Mitigations:**
- Put critical instructions at START and END of context (primacy + recency effect)
- Keep total context as small as effective (not as large as allowed)
- Use XML tags to create structural landmarks the model can anchor to
- Summarize and compress aggressively for older context
- Test: does adding this context actually improve output? If not, remove it.

---

## Context vs. Prompt: When to Use What

| Problem | Solution Layer |
|---------|---------------|
| Model doesn't follow format | System prompt (Layer 1) |
| Model doesn't know about your tools | Tool definitions (Layer 2) |
| Model forgets user preferences | Memory (Layer 3) |
| Model lacks domain knowledge | Retrieval (Layer 4) |
| Model loses track of conversation | State management (Layer 5) |
| Model hallucinates facts | Better retrieval + grounding instructions |
| Model ignores constraints | Move constraints to start AND end of context |
| Model performance degrades over time | Context compression + eviction |
