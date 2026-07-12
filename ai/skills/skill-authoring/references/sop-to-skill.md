---
type: reference
title: SOP to Skill Generation
description: Methodology for generating skill drafts from Standard Operating Procedures. Load when converting a runbook or wiki SOP into a SKILL.md.
timestamp: 2026-07-08
sources:
---

# SOP to Skill Generation

Wiki-as-Code pattern: automate skill creation from existing SOP documentation instead of manual skill.md authoring.

## When to use

- Team has a documented SOP but no AIM/Quick skill yet
- SOP changes often and skills drift out of sync
- Manual skill authoring is a bottleneck

## Inputs

1. **SOP source** - wiki page, markdown runbook, or exported procedure doc
2. **Skill format guidelines** - target platform skill template (see `adapters.md`)
3. **Example skills** - 1-2 reference skills showing expected quality bar

## Generation steps

1. **Gather requirements** - identify SOP URL or file, target platform, skill name
2. **Extract procedure** - pull steps, decision points, tools, inputs, outputs, error cases from SOP
3. **Map to skill anatomy** - Purpose, Constraints, Workflow (deterministic/agentic), Decision Logic, Output, Error Handling
4. **Parameterize** - replace hardcoded values (URLs, account names, paths) with `inputs` or config references
5. **Draft SKILL.md** - apply `step-patterns.md` and skill-creation-best-practices.md
6. **Human review** - SOP authors validate fidelity before save
7. **Eval generation** - happy path, missing data, ambiguous input, tool failure cases

## Quality checks against SOP

- Every SOP step maps to a skill step or explicit decision branch
- No SOP step silently dropped
- Hard stops in SOP become Hard Stops in skill
- Tool names in SOP match available adapters or have omit paths

## Omit path (no Wiki-as-Code automation)

Manual workflow: read SOP, draft SKILL.md by hand using main skill workflow Step 3. Use ai-engineer review before promotion.
