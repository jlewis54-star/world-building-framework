---
type: changelog
title: Skill Authoring Changelog
description: Version history of the skill-authoring skill. Source-only, excluded on deploy.
timestamp: 2026-07-08
---

# Changelog

All notable changes to the `skill-authoring` skill. Newest first. Semantic versioning. Mirrors the `version` field in `SKILL.md`.

## [1.0.0] - 2026-07-08

### Added
- Initial harvest merging intake `Skill-Authoring-Guide.md`, `Wiki-as-Code-Skill-Generation.md`, `skill-distribution/_example-skill-structure/`, and mirror Quick session-extract skill into one rich folder.
- `references/`: instruction-architecture, quick-format, adapters, session-extraction-workflow, sop-to-skill.
- `examples/minimal-skill/`: full starter skeleton with scripts, assets, extended reference.
- `evals/`: trigger-tests, quality-checks, evals.json.
- Cursor invoke copy at `.cursorai/skills/skill-authoring/`.

### Notes

## [1.0.2] - 2026-07-08

### Added
- Pointed authoring and review workflow at `ai/reference/skill-quality-exemplar.md` and `ai/skills/writing-standard/` as the library gold standard.

## [1.0.1] - 2026-07-08

### Added
- `CHANGELOG.md` convention formalized: every skill now ships one, matching the `agents/<name>/` pattern.
- Pointed voice/banned-word rules at `reference/voice.md` instead of restating them.
