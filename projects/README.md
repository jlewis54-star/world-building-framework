# Projects

Shipping instances that inherit from `world/` without duplicating canon.

## Spin up

```bash
cp -R templates/projects/_project_scaffold "projects/YYYY-MM-slug"
```

1. Set frontmatter in `PROJECT.md` (`project_type`, `inherits_canon`).
2. Write narrative hook with **citations** to `world/10_foundations/12_lore_canon.md`.
3. Fill `asset_matrix.md`.
4. Produce assets.
5. Complete `shipping_checklist.md` (or run `ai/agents/brand-friction.md`).

## Project types

`story | product | game | marketing | film`

Same scaffold. Different matrix rows and inheritance emphasis.

## Rules

- No lore paste. Link paths.
- Public-facing PRs need Shipping Ledger pass (`CONVENTIONS.md`).
- Record `inherits_canon` at kickoff. If world MAJOR-bumps mid-project, note migration in `PROJECT.md`.
- Drafted copy follows [`WRITING.md`](../WRITING.md).
- Scaffold copy into `projects/` is correct. Instantiated project files should stay artifact-focused (strip Purpose/AI Prompt/Example once filled, same rule as `world/`).
