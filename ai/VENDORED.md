# Vendored AI Kit

Authoring toolchain copied from a personal agent library and adapted for this worldbuilding framework. Identity and employer references scrubbed.

## Included

| Source (concept) | Version pin | Target |
| --- | --- | --- |
| skill-authoring | 1.0.3 (adapted) | `ai/skills/skill-authoring/` |
| ai-engineer | 1.0.1 | `ai/agents/ai-engineer/` + `ai/agents/ai-engineer.md` |
| instruction-refiner | 1.0.0 (adapted) | `ai/agents/instruction-refiner.md` |
| context-engineering-principles | 2026-07-12 (adapted) | `ai/reference/context-engineering-principles.md` |
| skill-quality-exemplar | adapted | `ai/reference/skill-quality-exemplar.md` (exemplar = writing-standard) |
| cursor-subagents-practitioner | adapted | `ai/reference/cursor-subagents-practitioner.md` |

## Excluded

- Work-sales skills (prospecting, CRM, outreach)
- harvest, marketplace-shop, reason-deep agents
- ui-ux-master exemplar skill
- Marketplace site listings and `_staging/` intake paths
- Amazon Quick / employer-specific adapter bindings

## Adaptations applied

- All paths rewritten to `ai/` and `reference/voice.md`
- Gold-standard skill pointer: `writing-standard` not ui-ux-master
- skill-authoring workflow targets `ai/skills/` and `ai/README.md`
- instruction-refiner: no personal voice references; harvest row removed
- External runtime adapters collapsed to omit paths

## Scrub policy

`scripts/check_ai_leakage.sh` runs in `make validate`. Block patterns: personal names, machine paths, employer brands, staging/intake paths. Allowlist: `scripts/leakage-allowlist.txt` (historical de-brand notes in CHANGELOG only).

## Updating vendored content

1. Diff against upstream library manually (not synced automatically).
2. Re-apply path rewrites and scrub pass.
3. Bump version in this file and skill/agent CHANGELOG.
4. Run `make validate`.
