---
type: reference
title: Quick Desktop Skill Format
description: External runtime skill frontmatter schema, folder shape, trigger and inputs conventions. Load when authoring or porting skills for Quick desktop.
timestamp: 2026-07-08
sources:
---

# Quick Desktop Skill Format

Load when the target runtime is External runtime desktop, or when harvesting a Quick mirror skill into this library.

## Quick folder shape

```
├── SKILL.md              # Required: frontmatter + instructions
├── scripts/              # Optional: .py or .js executed during skill
└── (no references/ folder - Quick uses inline or file_rag_search)
```

This library uses `references/`, `evals/`, `examples/`, `assets/`. On harvest from Quick, remap `docs/` to `references/` and add `evals/`.

## Frontmatter schema (Quick)

```yaml
---
name: skill-name-here           # kebab-case, must match folder name
display_name: Human Readable    # shown in skill catalog
icon: "🔧"                      # emoji for scanning
description: "One-line trigger description"
trigger: phrase that activates   # space-separated keywords for preloading
interactive: true               # optional; session-extraction skills
tools: [tool_a, tool_b]         # optional; session tools list
inputs:
  - name: input_name
    description: What this input represents
    type: string                # optional: string, url, path, number
    required: true              # optional
    default: value_here         # presence of default = optional
patterns:                       # optional; regex + confidence for fine-grained preload
  - pattern: "\\bjira\\b"
    confidence: 0.95
integration: slack_mcp          # optional; start MCP in parallel with skill load
depends-on: [other_skill]       # optional
scripts: [helper.py]            # optional; bundled script filenames
---
```

## Trigger and description

Both are discovery mechanisms. The agent uses them to decide whether to load the skill.

- **`description`**: One-line, slightly pushy. Names situations where the skill should activate.
- **`trigger`**: Space-separated keywords. System preloads the skill when these appear in user queries. Use domain nouns (product names, feature names), not generic verbs.
- **`patterns`**: Regex entries with confidence when phrase-level matching beats keyword preload.

Write triggers like API endpoint descriptions: specific enough to match intent, general enough for natural phrasing.

## Structured step format (Quick convention)

```markdown
### Step N: Title
- **Mode**: `deterministic` or `agentic`
- **Tool**: `tool_name` (required for deterministic)
- **Input**: what this step receives (`{{input_name}}` placeholders)
- **Output**: what this step produces
- **Validate**: how to verify success
- **On failure**: recovery strategy
```

## Quick-specific frontmatter fields

| Field | Purpose |
|-------|---------|
| `display_name` | Human label in catalog |
| `icon` | Visual scan aid |
| `trigger` | Keyword preload |
| `interactive` | Skill involves user decision cards |
| `tools` | Declared session tools (extraction workflow) |
| `patterns` | Regex preload with confidence |
| `integration` | MCP server to warm in parallel |
| `depends-on` | Other skills to load first |

Cursor and Claude Code skills use `name` and `description` only in frontmatter (agentskills.io spec). Drop Quick-only fields on port unless the target supports them.

## Porting Quick → library

1. Copy SKILL.md body into `skills/<name>/SKILL.md`.
2. Add OKF `type: skill` frontmatter.
3. Move overflow to `references/` with load-when triggers.
4. Extract platform tool bindings to `references/adapters.md`.
5. Add `evals/` (Quick mirror skills often lack these).
6. Leave mirror original untouched.

## Porting library → Quick

1. Flatten cross-links (Quick cannot follow markdown links).
2. Inline or restate `references/` content the skill needs every run.
3. Add Quick frontmatter fields (`display_name`, `icon`, `trigger`, `inputs`).
4. Rename `references/` content into SKILL.md body or Quick `docs/` if keeping Quick shape.
