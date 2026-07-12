---
type: reference
title: Extended Reference Example
description: Example of on-demand reference content too long for SKILL.md. Load when detailed lookup tables or schemas are needed.
timestamp: 2026-07-08
---

# Extended Reference Example

Use `references/` (in real skills) for content that supports the skill but is too long for SKILL.md.

## When to create a reference file

- Reference tables (lookup data, mapping tables, scoring rubrics)
- Detailed sub-workflow instructions for a specific mode
- API response schemas or field definitions
- Domain knowledge for classification or scoring

## How the agent loads it

SKILL.md must say when to load: "For detailed scoring criteria, read `references/extended-reference.md`."

In Cursor: Read tool. In Quick: `file_read` or `file_rag_search`.

## Naming convention

- `references/creation.md` - instructions for "create" mode
- `references/editing.md` - instructions for "edit" mode
- `references/reference-tables.md` - lookup data
- `references/api-schema.md` - response field definitions
