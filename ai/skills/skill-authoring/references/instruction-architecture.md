---
type: reference
title: Skill Instruction Architecture
description: Three-layer body structure, deterministic vs agentic steps, decision trees, error handling, few-shot examples, tool patterns, and anti-patterns for SKILL.md authoring.
timestamp: 2026-07-08
sources:
---

# Skill Instruction Architecture

Load when writing or refactoring the body of a SKILL.md. For scoping, triggering, and eval methodology, read `ai/agents/ai-engineer/reference/skill-creation-best-practices.md` first.

## Three layers (always in this order)

### Layer 1: Identity and constraints

Define what the skill does, what it does NOT do, and hard boundaries.

```markdown
## Purpose

This skill generates weekly account summaries from CRM data.
It does NOT make strategic recommendations or modify account records.

## Constraints

- Output under 500 words per account
- Always cite the data source
- Never fabricate metrics; state when data is unavailable
- Maximum 10 accounts per run
```

### Layer 2: Workflow steps

Mark each step `deterministic` or `agentic`. Deterministic steps use a specific tool the same way every run. Agentic steps need judgment.

```markdown
### Step 1: Lookup account
- **Mode**: `deterministic`
- **Tool**: `lookup_contact`
- **Input**: `{{account_name}}`
- **Output**: Account record or empty result
- **Validate**: Record has an ID field
- **On failure**: Fall back to file search; if still empty, inform user

### Step 2: Synthesize summary
- **Mode**: `agentic`
- **Input**: Account record + recent activity
- **Output**: Markdown summary
- Prioritize: revenue changes > 5%, escalations, renewals within 30 days
```

Why mark modes? Prevents drift on the critical path while allowing intelligence on synthesis.

### Layer 3: Output specification

```markdown
## Output

- Format: Markdown saved to artifacts/
- Structure: H1 account name, H2 Key Metrics (table), H2 Notable Activity, H2 Risks, H2 Next Steps
- Length: under 500 words
- After writing: open file in session tab
```

## Decision trees

Encode branching explicitly. Never write "handle appropriately based on context."

```markdown
## Decision Logic

IF {{input_type}} == "new_account":
  → Skip historical analysis
  → Use template: new_account_brief

ELIF {{input_type}} == "renewal":
  → Pull 12-month engagement history
  → Flag accounts with < 3 touchpoints last quarter

ELSE:
  → Ask user to specify: new_account or renewal
```

## Error handling patterns

### Graceful degradation

```markdown
- If lookup returns no results:
  → Fall back to file search with broader query
  → If still empty: "No records found for {{account_name}}. Verify name or check data source."

- If email search times out:
  → Skip email section, note "Email data unavailable"
  → Continue remaining steps
```

### Retry with variation

```markdown
- If web search returns no results:
  → Rephrase query (remove suffixes like Inc, LLC)
  → Try once more
  → If still empty: state "Could not find current information"
  → Do NOT fabricate
```

### Hard stops

```markdown
STOP and ask the user if:
- More than 3 consecutive tool failures
- Required input missing and cannot be inferred
- Task would modify production data without confirmation
```

## Few-shot examples

Include when output format is non-obvious, tone is hard to describe, or edge cases need demonstration. Put long examples in `examples/` and reference them from SKILL.md.

Structure each example as:

```markdown
### Example: Missing data case

**Input**: account_name = "NewCo Industries"

**Expected output**: Summary with explicit "No CRM data available" in metrics section,
no fabricated numbers, guidance to verify account record.
```

## Tool selection and call patterns

Tell the agent WHEN and WHY for each tool, not just what tools exist.

```markdown
## Tool Selection

- **lookup_contact**: People, orgs, relationships. Try first for entity lookups.
- **file_search**: Document content, meeting notes. Better for "what was discussed."
- **web_search**: External/public info only. Never for internal account data.

## Parallel vs sequential

INDEPENDENT (parallel):
- lookup for account entity
- email search for recent threads

DEPENDENT (sequential):
1. lookup person to get team
2. lookup team to find related projects
3. file_search for project docs
```

## Input validation

```markdown
## Input Validation

Before executing:
1. If {{account_name}} has fewer than 2 characters → reject with message
2. If {{format}} not in [md, pdf, xlsx] → default to md, inform user
```

## Tone directives

When the skill produces user-facing content:

```markdown
## Writing Style

- Professional but not stiff
- Data-first: numbers before interpretation
- Active voice, present tense for current state
- When uncertain, state directly: "Data incomplete" not "This might not be complete"
```

## Anti-patterns

| Anti-pattern | Why it fails | Fix |
|---|---|---|
| "Handle appropriately" | No decision criteria | Name branches explicitly |
| Monolithic 5000+ word SKILL.md | Agent loses focus | Numbered steps; push detail to references/ |
| No error handling | Hallucination on tool failure | Fallback for every tool call |
| Overly broad description | False triggers | Match specific user intent |
| No output spec | Format varies every run | Structure, length, location |
| Inline code > 30 lines | Hard to maintain | Move to scripts/ |
| Assuming tools always succeed | Silent wrong outputs | Check empty/null results |
| "Be creative" without bounds | Rambling output | Word limits, required sections, stop conditions |

## Quality checklist (body)

- [ ] Purpose states what skill does NOT do
- [ ] Steps distinguish deterministic from agentic
- [ ] Every tool call has a failure path
- [ ] Output format explicit
- [ ] At least one example for non-obvious output
- [ ] No vague instructions
- [ ] Decision branches named with ELSE
- [ ] Hard stop conditions defined
