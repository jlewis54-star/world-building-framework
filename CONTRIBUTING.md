# Contributing

How to change this public framework repo without breaking canon rules or leaking private IP.

## Two audiences

| Audience | Goal |
| --- | --- |
| Framework contributors | Improve templates, playbook, AI kit, examples, validation |
| World builders | Fill `world/` and ship from `projects/` (see private workflow below) |

This public repo ships **empty** root `world/` stubs. Filled canon is your IP. If you are the maintainer building a real world, use [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md) so filled canon never lands on public `main`.

## Workflow

1. Branch from `main`.
2. Edit. Run validation before opening a PR.
3. Push the branch. Open a PR. Wait for CI (`validate` job) to pass.
4. Merge (squash recommended). GitHub deletes the branch if that setting is on.

Owner and collaborators use the same flow. No approval count required: merge your own PR when CI is green.

## Validation

Full repo:

```bash
make validate
```

Changed files only (faster for small PRs):

```bash
make validate-changed
```

Details: [`VALIDATION.md`](VALIDATION.md).

## What belongs in a public PR

- Framework docs: `playbook/`, `templates/`, `ai/`, `scripts/`, root docs
- Examples: `examples/demo-world/`, `examples/demo-project/`
- Root `world/` **only while stubs stay empty** (or framework stub shape fixes)
- Bug fixes to validation, CI, or tooling

## What does not belong in a public PR

- Filled root `world/` canon (manifesto, lore, identity, brand)
- Local `projects/YYYY-MM-slug/` instances (gitignored; use [`examples/demo-project/`](examples/demo-project/) patterns)
- Secrets: `.env`, API keys, tokens, private keys
- Competitor market analyses in `world/` (anti-library only: `52_anti_library.md`)
- Thick template paste into `world/` (Purpose, Theory, AI Prompt, Review Checklist)

## PR rules (summary)

Full list: [`CONVENTIONS.md`](CONVENTIONS.md) (Contribution / PR rules).

1. Changes to `11_manifesto` or `12_lore_canon` require named owner approval from the Primary owners table in [`world/00_governance/01_governance_ledger.md`](world/00_governance/01_governance_ledger.md).
2. Public-facing assets in [`examples/demo-project/`](examples/demo-project/) (or in a private-repo `projects/` instance) need a completed Shipping Ledger in the PR description.
3. Do not reintroduce scaffold sections into `world/`.
4. Drafted prose follows [`WRITING.md`](WRITING.md).

## Fork etiquette (external contributors)

1. Fork the repo.
2. Create a feature branch on your fork.
3. Open a PR against `main` on the upstream repo.
4. Keep PRs focused. One concern per PR when possible.
5. Do not rename numbered world doc IDs without updating cross-links (`CONVENTIONS.md` naming table).

## AI-assisted edits

- Canonical prompts: [`ai/prompts/`](ai/prompts/). Do not duplicate prompt bodies inline.
- Generate into thin `world/` fill sections only (`status: draft`). On the public repo, keep stubs empty; fill real lore on your private remote ([`playbook/private-world-workflow.md`](playbook/private-world-workflow.md)).
- Run [`ai/agents/canon-consistency.md`](ai/agents/canon-consistency.md) and [`ai/agents/brand-friction.md`](ai/agents/brand-friction.md) before `signed_off`.
- Humans own final canon.

Agent kit: [`AGENTS.md`](AGENTS.md).

## Governance and security

| Doc | Purpose |
| --- | --- |
| [`playbook/public-repo-governance.md`](playbook/public-repo-governance.md) | GitHub Settings checklist for maintainers |
| [`playbook/private-world-workflow.md`](playbook/private-world-workflow.md) | Keep filled canon off public `main` |
| [`SECURITY.md`](SECURITY.md) | Report vulnerabilities |

## Questions

Open a documentation issue using the template under `.github/ISSUE_TEMPLATE/`.
