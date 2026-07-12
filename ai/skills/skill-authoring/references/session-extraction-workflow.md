---
type: reference
title: Session Extraction Workflow
description: Extract a reusable SKILL.md from a completed multi-step workflow session. Load when the user wants to save a workflow as a skill or after a successful complex task.
timestamp: 2026-07-08
sources:
---

# Session Extraction Workflow

Load when converting a completed chat workflow into a reusable skill. Platform-specific extract/save tools live in `references/adapters.md`.

## When to offer

After a multi-step workflow, offer to save it as a skill. Good moments:

- Workflow involved 2+ tool calls and produced a concrete deliverable
- User says "thanks", "perfect", or similar after complex work
- User says "I'll need to do this again" or "can you do this for X too?"
- Workflow is general enough to reuse (not one-off)

Keep the offer casual. If declined, do not repeat in the same session.

## Workflow

### Step 1: Gather context

- **Mode**: `agentic`
- **Input**: Completed workflow in conversation history
- **Output**: Trigger phrase, input names, display name, icon
- **Validate**: User confirms trigger and inputs
- **On failure**: Suggest defaults from conversation context

If trigger/inputs unspecified, suggest from the workflow. One message, not a quiz.

### Step 2: Extract session data

- **Mode**: `deterministic`
- **Tool**: see `references/adapters.md` (Quick: `extract_session_data`)
- **Input**: `skill_name`, `trigger`, `inputs`, `display_name`, `icon` from Step 1
- **Output**: Skeleton with frontmatter and session tools list
- **Validate**: Valid frontmatter with `---` delimiters and tools list
- **On failure**: Check arguments; retry once

**Cursor/Claude omit path:** Manually build skeleton from conversation. List tools actually used in the session. Do not invent tool names.

### Step 3: Write SKILL.md

- **Mode**: `agentic`
- **Input**: Skeleton + full conversation context
- **Output**: Complete SKILL.md

Complete these sections:

**3a. `description` field** - slightly pushy; name activation situations.

**3b. `inputs` block** - only inputs that vary between invocations. Hardcode constants in the workflow.

```yaml
inputs:
  - name: repo_url
    description: "GitHub repository URL to analyze"
    type: url
    required: true
  - name: output_format
    description: "Format for the report"
    type: string
    default: markdown
```

**3c. Overview** - 2-3 sentences on what and when.

**3d. Workflow** - structured steps per `references/instruction-architecture.md`.

**3e. Output** - final deliverable shape.

**3f. Lessons learned** - sub-sections:
- `### Do` - best practices from this session
- `### Don't` - mistakes to avoid
- `### Common Failures` - error modes and handling
- `### When to Ask the User` - human judgment gates

Reflect on what was tricky, what failed and was retried, what needed user input. Repeated helper code signals a bundled script.

**Rules:**
- Only reference tools from the session tools list
- Use `{{input_name}}` for every frontmatter input
- Repeated `run_python` logic → `scripts/` + frontmatter `scripts:` list
- Workflow depends on another skill → `depends-on: [skill_name]`
- Parameterize session-specific URLs, paths, channel names as inputs
- Keep body under 500 lines; overflow to `references/`

### Step 4: Present for review

- **Mode**: `deterministic`
- **Input**: Complete SKILL.md
- **Output**: Artifact for user review

Present the full SKILL.md and ask: Save, Edit, or Regenerate.

**Cursor omit path:** Show SKILL.md in chat or write to a temp path for review.

### Step 5: Handle user decision

- **Save** - call save adapter (see `references/adapters.md`). Offer eval generation after save.
- **Edit** - discuss changes, rewrite sections, return to Step 4.
- **Regenerate** - return to Step 1.

## Post-save testing

After save, offer a quick test. Generate evals from the skill (see `references/adapters.md` and `evals/` in this skill folder). Run at least one happy-path invocation.
