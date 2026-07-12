---
type: eval
title: Skill Authoring Quality Checks
description: Pre-save checklist and output-quality assertions for skill authoring work.
timestamp: 2026-07-08
---

# Quality Checks

## Pre-save checklist

Before promoting a skill to `skills/`:

- [ ] Trigger/description specific enough to avoid false activations
- [ ] Every input has a clear description (if inputs exist)
- [ ] Steps mark deterministic vs agentic
- [ ] Every tool call has an On failure path
- [ ] Output format explicit (structure, length, location)
- [ ] At least one gotcha or example where format is non-obvious
- [ ] No vague instructions ("handle appropriately", "be creative", "use best judgment")
- [ ] SKILL.md under ~500 lines; overflow in references/
- [ ] Decision branches named with ELSE path
- [ ] Hard stop conditions defined
- [ ] OKF frontmatter on every non-reserved `.md`
- [ ] Adapters separated per `references/adapters.md`
- [ ] Does not duplicate skill-creation-best-practices.md wholesale

## Output-quality assertions (sample eval cases)

### Case 1: New skill from runbook

**Prompt:** "Author a skill from this 5-step runbook for weekly account summaries."

**Assertions:**
- Output is a folder shape, not a single bare file
- SKILL.md has Purpose, Constraints, Workflow, Output
- Steps distinguish deterministic from agentic
- Description is imperative and names activation contexts

### Case 2: Harvest promotion


**Assertions:**
- Proposes kebab-case name and home under `skills/`
- References HARVEST.md steps
- Separates core procedure from platform adapters
- Includes evals/ recommendation

### Case 3: Description tune

**Prompt:** "This skill fires on unrelated tasks. Fix the description."

**Assertions:**
- Revised description names what it does NOT cover
- Suggests trigger-tests from evals/trigger-tests.md pattern
- Does not only add keywords from the failure example (avoids overfit)

## Grading

PASS only with quoted evidence from output. FAIL with specific fix. Run with and without skill loaded; compare pass rate delta.
