---
type: skill
name: example-minimal-skill
title: Example Minimal Skill
description: >-
  Scaffold showing the library rich-skill shape. Use as a starting template when
  authoring a new skill folder. Triggers: example skill, skill template, minimal scaffold.
version: "1.0.0"
timestamp: 2026-07-08
sources:
---

# Example Minimal Skill

One sentence: what this skill does and when it activates.

## Overview

2-3 sentences on purpose, audience, and problem solved. Delete this scaffold content when authoring a real skill.

## Prerequisites

List skills to load first, tools required, or connections needed.

- Load `other-skill` before rendering (if dependent)
- Requires email connection (if email) - see `references/adapters.md` in parent skill
- Omit path: draft to file if connector absent

## Workflow

### Step 1: Gather input
- **Mode**: `agentic`
- **Input**: User request + `{{primary_input}}`
- **Output**: Validated parameters
- **Validate**: Required fields present
- **On failure**: Ask user for missing values

### Step 2: Execute core action
- **Mode**: `deterministic`
- **Tool**: `lookup_contact` (adapter: see parent `references/adapters.md`)
- **Input**: Validated parameters from Step 1
- **Output**: Raw data for rendering
- **On failure**: Fall back to file search; if empty, inform user

### Step 3: Render output
- **Mode**: `agentic`
- **Input**: Raw data from Step 2
- **Output**: Final deliverable per `assets/output-template.html` (if HTML)

For detailed scoring criteria, load `references/extended-reference.md` in a real skill (this example omits that file).

## Error Handling

- If lookup fails: try file search, then stop with clear message
- If one section unavailable: note in output, continue other sections
- Never crash the entire workflow because one step failed

## Output

- Format: Markdown (or HTML from template)
- Location: artifacts/ or user-specified path
- Structure: H1 title, H2 sections per spec

## Notes for authors

- Keep SKILL.md under ~500 lines. Overflow → `references/`.
- Reusable code → `scripts/`. Agent runs via Shell or platform script runner.
- Output templates → `assets/`. Agent reads and fills placeholders at render time.
- Delete this file's placeholder content before shipping.
