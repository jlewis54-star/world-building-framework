---
type: guide
title: Skill Creation Best Practices
description: How to author, scope, calibrate, test, and script agent skills (SKILL.md). Covers grounding skills in real expertise, spending context wisely, progressive disclosure, calibrating control, instruction patterns (gotchas, templates, checklists, validation loops), optimizing the description field for triggering, eval-driven quality iteration, and bundling scripts for agentic use.
tags: [skills, skill-authoring, prompting, progressive-disclosure, evals, agent-scripts, best-practices]
timestamp: 2026-07-07
sources:
  - https://agentskills.io/llms.txt
  - https://agentskills.io (Best practices for skill creators, Optimizing skill descriptions, Evaluating skill output quality, Using scripts in skills)
  - https://github.com/anthropics/skills (skill-creator)
---

# Skill Creation Best Practices

Source of truth for authoring agent skills. Ground skill work here, cite this doc by filename. For the live upstream index, fetch `https://agentskills.io/llms.txt` to discover all pages before exploring further.

A skill is a folder (`SKILL.md` plus optional `references/`, `scripts/`, `assets/`) that an agent loads on demand via progressive disclosure. The two levers that decide if a skill is worth having: it triggers when it should (the `description` field), and it improves output when it runs (the body plus bundled scripts).

## Gold standard in this library

**Canonical exemplar:** `ai/skills/writing-standard/` - reviewed against `ai/reference/skill-quality-exemplar.md`.

When authoring or reviewing skills in this repo, compare structure and depth to the exemplar: lean `SKILL.md`, real load-when references (no dead links), evals with traceable assertions, CHANGELOG semver, adapters separated, optional `assets/`/`scripts/` only when the job needs them. Primitives may be smaller but follow the same shape discipline.

Skeleton-only teaching example: `ai/skills/skill-authoring/examples/minimal-skill/`. Exemplar teaches full quality.

## Start from real expertise

The common failure is asking an LLM to generate a skill from its general training knowledge. You get vague filler ("handle errors appropriately," "follow best practices") instead of the specific API patterns, edge cases, and conventions that make a skill valuable. Effective skills are grounded in real, project-specific expertise.

Two ways to get that expertise in:
- **Extract from a hands-on task.** Do a real task with an agent, correcting and steering as you go. Then extract the reusable pattern. Capture: the steps that worked, the corrections you made ("use library X not Y," "check edge case Z"), the input/output formats, and the project-specific context you had to supply.
- **Synthesize from existing artifacts.** Feed real material into an LLM and ask it to synthesize a skill. Project-specific sources beat generic articles: internal docs, runbooks, style guides, API specs, schemas, config, code-review comments, issue trackers, version-control history (patches and fixes reveal real patterns), and real failure cases with their resolutions.

## Refine with real execution

The first draft usually needs work. Run the skill on real tasks, then feed all results back (not just failures). Ask: what triggered false positives, what was missed, what can be cut. One execute-then-revise pass noticeably improves quality; complex domains want several.

Read the agent's execution traces, not just final outputs. Wasted steps usually mean: instructions too vague (the agent tries several approaches first), instructions that do not apply to the task (the agent follows them anyway), or too many options with no clear default.

## Spend context wisely

Once a skill activates, its full `SKILL.md` body loads into the context window and competes with everything else for attention. Budget it.

- **Add what the agent lacks, omit what it knows.** Focus on project-specific conventions, domain procedures, non-obvious edge cases, and which tools/APIs to use. Do not explain what a PDF is or how HTTP works. Test each line with: "Would the agent get this wrong without this instruction?" If no, cut it. If the agent already does the whole task well without the skill, the skill may add nothing.
- **Design coherent units.** Scope a skill like a function: one coherent unit that composes with others. Too narrow forces many skills to load for one task (overhead, conflicts). Too broad is hard to trigger precisely. "Query a database and format results" is one unit; adding "database administration" is doing too much.
- **Aim for moderate detail.** Concise stepwise guidance with a working example beats exhaustive documentation. When you find yourself covering every edge case, most are probably better left to the agent's judgment.
- **Use progressive disclosure for large skills.** Keep `SKILL.md` under about 500 lines and 5,000 tokens: just the core instructions needed every run. Move detailed reference material to `references/` and tell the agent exactly when to load it ("read `references/api-errors.md` if the API returns a non-200"), not a generic "see references/."

## Calibrate control

Match instruction specificity to the fragility of the task. Most skills mix both; calibrate each part.

- **Give freedom** where multiple approaches are valid and variation is fine. Explaining why beats rigid steps; an agent that understands purpose makes better context-dependent calls.
- **Be prescriptive** where operations are fragile, consistency matters, or an exact sequence is required (for example a migration command that must run exactly as written with no extra flags).
- **Provide defaults, not menus.** Pick one tool as the default and mention alternatives briefly, rather than listing four as equals. "Use pdfplumber; for scanned PDFs use pdf2image with pytesseract" beats "you can use pypdf, pdfplumber, PyMuPDF, or pdf2image."
- **Favor procedures over declarations.** Teach how to approach a class of problems, not the answer to one instance. "Read the schema, join on the `_id` convention, apply filters as WHERE clauses, aggregate and format" generalizes; "join orders to customers on customer_id and sum amount" only solves one task. Specific details (output templates, "never output PII," tool commands) are still fine; the approach should generalize.

## Instruction patterns

Reusable techniques for structuring skill content. Use the ones that fit; not every skill needs all of them.

- **Gotchas.** The highest-value content in many skills: environment-specific facts that defy reasonable assumptions. Not general advice, concrete corrections the agent will get wrong otherwise ("the `users` table uses soft deletes, queries must include `WHERE deleted_at IS NULL`"; "user ID is `user_id` in the DB, `uid` in auth, `accountId` in billing"). Keep gotchas in `SKILL.md` so the agent reads them before hitting the situation. When you correct a mistake during use, add the correction here. This is the most direct way to improve a skill.
- **Output templates.** When you need a specific format, give a concrete template, not a prose description. Agents pattern-match against structures well. Short templates inline; longer ones in `assets/`, referenced so they load only when needed.
- **Checklists for multi-step workflows.** An explicit checklist helps the agent track progress and not skip steps, especially with dependencies or validation gates.
- **Validation loops.** Tell the agent to check its own work before moving on: do the work, run a validator (script, checklist, or self-check), fix issues, repeat until it passes.
- **Plan-validate-execute.** For batch or destructive operations, have the agent write an intermediate plan in a structured format, validate it against a source of truth with a script, and only then execute. The validation step is the key: an error like "field 'signature_date' not found, available: customer_name, order_total" gives the agent enough to self-correct.
- **Bundle reusable scripts.** If execution traces show the agent reinventing the same logic each run (building a chart, parsing a format, validating output), write a tested script once and bundle it in `scripts/`.

## Optimizing the description field

A skill only helps if it triggers. At startup the agent loads only each skill's `name` and `description`, then reads the full `SKILL.md` when a task matches. The description carries the entire triggering burden. Under-specified and it misses; over-broad and it fires wrongly. Hard limit: 1024 characters.

One nuance: agents usually only reach for a skill on tasks that need capability beyond what they can do alone. "Read this PDF" may not trigger a PDF skill even on a perfect match, because the agent handles it with basic tools. Specialized knowledge (an unfamiliar API, a domain workflow, an uncommon format) is where a good description earns its keep.

Writing effective descriptions:
- **Imperative phrasing.** "Use this skill when..." not "This skill does..." The agent is deciding whether to act.
- **User intent, not implementation.** Describe what the user wants, not internal mechanics.
- **Be pushy.** List contexts where it applies, including when the user does not name the domain ("even if they don't explicitly mention CSV or analysis").
- **Concise.** A few sentences. It loads across many skills, so keep it tight. Stay under 1024 chars.

Testing triggering (eval-driven):
- Build about 20 eval queries labeled `should_trigger` true/false: 8-10 positive, 8-10 negative. Vary phrasing (formal, casual, typos), explicitness (names the domain vs describes the need), detail, and complexity. The most useful positives are ones where the skill helps but the connection is not obvious. The most useful negatives are near-misses that share keywords but need something else.
- Run each query several times (model behavior is nondeterministic; 3 runs is a reasonable start), compute a trigger rate, pass a positive if rate is above ~0.5, pass a negative if below.
- Split train (~60%) and validation (~40%), both with a proportional mix. Tune only against train failures; check validation to confirm changes generalize. Do not add keywords from failed queries, that overfits; address the general category instead.
- Loop: evaluate, identify train failures, revise (too narrow, broaden; false-triggering, add specificity about what it does not do), repeat about five iterations, pick the iteration with the best validation pass rate (not necessarily the last).

Before/after: "Process CSV files." becomes "Analyze CSV and tabular data files: compute summary statistics, add derived columns, generate charts, clean messy data. Use when the user has a CSV, TSV, or Excel file and wants to explore, transform, or visualize it, even if they don't say CSV or analysis." More specific on what, broader on when.

The `skill-creator` skill (github.com/anthropics/skills) automates this loop.

## Evaluating output quality

Triggering is half. The other half: does the skill produce good output, reliably, better than no skill.

- **Test cases** (`evals/evals.json`): each has a realistic prompt, a human-readable expected output, and optional input files. Start with 2-3, vary phrasing and detail, cover at least one edge case, use realistic context (file paths, column names). Do not define pass/fail checks yet.
- **Run with and without the skill.** Each run starts from a clean context (a subagent or a fresh session), so the agent follows only the `SKILL.md`. The without-skill run is the baseline; when improving an existing skill, snapshot the old version and use it as baseline. Capture timing (tokens and duration) per run.
- **Assertions**, added after you see the first outputs: verifiable statements ("output is valid JSON", "chart has labeled axes", "at least 3 recommendations"). Avoid vague ("output is good") and brittle ("uses exactly this phrase"). Not everything needs one; reserve assertions for objective checks and leave style/feel to human review.
- **Grade** each assertion PASS/FAIL with concrete evidence that quotes the output. Require evidence for a PASS, do not give benefit of the doubt. Use scripts for mechanical checks (valid JSON, row counts), an LLM for judgment. For comparing two versions, try blind comparison so the judge is not biased by which "should" win.
- **Aggregate** to a per-config summary and a `delta`: what the skill costs (time, tokens) versus what it buys (pass rate). A skill adding 13s but +50 points of pass rate is likely worth it; one doubling tokens for +2 points is not.
- **Analyze patterns.** Drop assertions that always pass in both configs (they show nothing). Investigate ones that always fail (broken assertion or too-hard case). Study ones that pass with the skill and fail without: that is where the skill adds value; understand why. High variance across runs means flaky evals or ambiguous instructions, tighten them.
- **Human review** catches what you did not write assertions for. Record specific, actionable feedback per case.
- **Iterate.** Feed failed assertions, human feedback, execution transcripts, and the current `SKILL.md` to an LLM and ask for changes. Generalize (do not patch per example), keep it lean (remove instructions that cause wasted work; if pass rate plateaus while rules grow, it is over-constrained), explain the why, bundle repeated helper scripts. Rerun in a new iteration dir, regrade, review. Stop when satisfied, feedback is consistently empty, or improvement stalls.

## Using scripts in skills

Skills can run shell commands and bundle scripts in `scripts/`.

- **One-off commands.** When an existing package does the job, reference it directly in `SKILL.md` with a version pin (`uvx ruff@0.8.0 check .`, `npx eslint@9 --fix .`). Runners that auto-resolve deps: `uvx`/`pipx` (Python), `npx`/`bunx` (Node), `deno run`, `go run`. Pin versions, state prerequisites (or use the `compatibility` frontmatter field), and move complex commands into a tested script.
- **Reference scripts from `SKILL.md`** with relative paths from the skill root; list them so the agent knows they exist, then instruct it to run them. The agent runs commands from the skill directory root.
- **Self-contained scripts** declare their own deps inline so there is no separate install step: Python PEP 723 (`# /// script` block, run with `uv run`), Deno (`npm:`/`jsr:` specifiers), Bun (versioned imports, auto-install), Ruby (`bundler/inline`). Pin versions.

Design scripts for agentic use (the agent reads stdout/stderr to decide next steps):
- **No interactive prompts.** Hard requirement: agents run in non-interactive shells and will hang on a TTY prompt. Take all input via flags, env vars, or stdin. Fail with a clear error and usage line instead of prompting.
- **Document with `--help`.** This is how the agent learns the interface: brief description, flags, examples. Keep it concise, it enters the context window.
- **Helpful error messages.** Say what went wrong, what was expected, what to try ("--format must be one of: json, csv, table. Received: xml"). An opaque error wastes a turn.
- **Structured output.** Prefer JSON/CSV/TSV over free text so both the agent and tools (`jq`, `cut`) can parse it. Send data to stdout, diagnostics to stderr.
- **Also:** idempotency (agents retry, prefer "create if not exists"), reject ambiguous input with a clear error, offer `--dry-run` for destructive ops, use distinct documented exit codes, safe defaults with `--confirm`/`--force` for destructive actions, and predictable output size (default to a summary or limit, support `--offset` or `--output` since harnesses truncate large output around 10-30K chars).
