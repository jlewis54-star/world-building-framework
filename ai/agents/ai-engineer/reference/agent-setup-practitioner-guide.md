---
type: guide
title: Agent Setup Practitioner Guide
description: Durable practices for building and running a personal agent setup, distilled from agent setup practitioner guides (My Kiro Setup, Making Your Agent Better, Agentic AI Starter Kit, Team Playbooks). Covers the config-vs-workspace split, the building blocks and where each instruction belongs, rules over resumes, context engineering, the feedback loop, when to add a second agent, common failure modes, the Managed AI Framework, and the shared knowledge base pattern.
tags: [agent-setup, personas, steering, skills, context-engineering, feedback-loop, managed-ai, knowledge-base, best-practices]
timestamp: 2026-07-07
sources:
  - Agent setup practitioner guides (public summaries, 2026)
  - Anthropic, "Effective context engineering for AI agents" (Sep 2025)
  - Anthropic, "Building Effective Agents" (Dec 2024)
---

# Agent Setup Practitioner Guide

Distilled from mature personal agent setups. Cite this doc when advising on how to structure, run, or improve someone's agent setup.

## The building blocks, and where each instruction goes

A working setup is composed of small, independent pieces, not one big prompt. Composability beats monoliths: a persona defines the agent, context files provide knowledge, skills define procedures, steering sets the rules. Each is reusable on its own.

| Piece | What it is | Holds |
|-------|-----------|-------|
| Persona | How the agent thinks | Role, communication style, default approach. Character and cognitive style |
| Steering | Shared rules across all agents | Safety rails, epistemic standards, formatting conventions |
| Skill | What the agent does | A repeatable multi-step procedure with inputs, steps, outputs (a SKILL.md folder) |
| Context file | Knowledge about the world | Product facts, frameworks, learnings. One topic per file |
| Tool / MCP | Reach outside the editor | Email, DB, chat, search, document manipulation |
| Agent config | Wiring | Pairs a persona, a model, a tool set, and the resources it loads |

The sorting test when unsure where something belongs: about character or approach, persona. A safety rail or quality standard for every agent, steering. A multi-step procedure you could trigger by name, skill. Knowledge the agent lacks, context file. A capability it cannot perform, a tool.

Two common mistakes: stuffing procedures into a persona (bloats every turn; extract to a skill), and duplicating a rule across persona and steering (put shared rules in steering once).

## Config vs workspace (two locations)

Mature setups separate the team definition from the working environment:
- **Config** (the "team"): steering rules, agent configs, skills, settings. This is what defines the agents.
- **Workspace** (the working env): personas, context, data, projects. Agents read and write here.
- **Data** is often split out from context because it changes frequently and is versioned by date, not maintained as a living document.

Everything is markdown and CSV. Those formats are compact, diffable, and easy for models to parse. Word and PDF are outputs, not inputs to the knowledge base.

## Rules over resumes

A persona written like a LinkedIn bio ("expert analyst with a keen eye for detail") does little. Behavioral rules that constrain specific failure modes work better because you can verify them.

- Bad: "You are detail-oriented and thorough."
- Good: "Every number in your output must trace to a named source. If you cannot cite it, flag it as unverified."

Rules work best as negative space: constrain bad defaults rather than describe ideal behavior. The model already knows how to write; your job is to prevent the specific ways it writes badly for your use case. Start with a short persona (about 50 to 100 lines). Add a rule only after you observe a failure. If you cannot tell from the output whether a rule was violated, it is too vague; rewrite or cut it.

Five rules that repeatedly earn their place: confirm before deleting; say what you do not know (label hypotheses, never present a guess as fact); read before assuming (re-read files from disk, do not trust memory of earlier context); show your math (use code for non-trivial calculation, trace every number); push back when the user is wrong (with reasoning, not manufactured disagreement).

## Context engineering: treat every token as a cost

Context is finite and has diminishing returns. The goal is the smallest set of high-signal tokens that gets the outcome. Performance degrades well before the window limit: recall accuracy drops as tokens grow (Chroma "Context Rot," 2025), most frontier models fall below 50% on non-lexical matching at 32k tokens (NoLiMa, 2025), and practitioner testing finds quality degrading past a few thousand tokens.

- **Budget the always-loaded system prompt.** Keep combined steering plus persona to roughly 150 to 200 lines (about 2,000 to 3,000 tokens). Skills and context files load on demand and do not count against this.
- **Position matters.** The beginning and end of context get more attention than the middle. Put critical instructions there, not buried.
- **Audit and trim.** If a context file has not influenced output in weeks, remove it. Cut unused tools and MCP servers; every tool definition costs tokens every turn.
- **Structure and compress.** Use headers and clear sections. Summarize completed work rather than keeping full transcripts (compaction).

## The feedback loop (how the setup actually improves)

The agent does not learn between sessions. It is exactly as good as its current configuration. Improvement is a manual cycle: use the agent on real work, notice a specific failure, diagnose the cause (missing rule, bad rule, missing skill, context problem), make the specific fix at the right layer, verify on similar tasks.

Keep a feedback log. The valuable entries recur; a one-time oddity is not worth a rule. Resist preemptive rules (they cost tokens and add load); add them in response to observed failures, not anticipated ones. Audit periodically and cut aggressively. A lean configuration usually beats a sprawling one.

## When to add a second agent

Resist it until you exhaust single-agent improvements. Teams often build elaborate multi-agent systems only to find that better prompting on one agent matched it, and multi-agent uses several times more tokens. Three valid reasons: context pollution (one task's context contaminates another and compaction does not fix it), genuine parallelization, and specialization (fundamentally different tools or reasoning). Before adding an agent, ask whether a new skill, context file, or steering rule on an existing agent would do. If yes, do that.

## Common failure modes and fixes

| Failure | Fix |
|---------|-----|
| Asserts false facts confidently | Epistemic honesty rule: label uncertainty, never fabricate sources |
| Ignores tools or docs you provided | Reduce context length; sharpen tool descriptions; remove overlapping tools |
| Silent data quality issues | Validation rule: check nulls, duplicates, outliers before analysis |
| Scope creep in documents | Scope rule: deliver exactly what was asked; flag suggestions separately |
| Subagent returns garbage | Give subagents self-contained briefs with all needed context |
| Hits size or timeout limits | Platform-awareness rule with specific limits |
| Silently corrupts a document over long edit sessions | Diff every edit; keep edit sessions short; strip irrelevant files from context |

The pattern: the fix is almost always a specific, testable rule, not "be more careful."

## The Managed AI Framework

Manage the agent like a team, not a tool. Two phases, six steps:
1. Define the roles (group recurring work into roles; keep the team to about eight or fewer; start with one).
2. Create the personas (behavioral rules, start lean).
3. Set up the agents (config ties persona, model, tools, context).
4. Work with the team (hand each agent the work it was built for; switch agents when you switch tasks).
5. Spot the gaps (behavioral, capability, or knowledge).
6. Apply the fix at the right level: all agents keep missing something, steering rule; one workflow is inconsistent, skill; one agent keeps missing, update its persona; missing knowledge, context file; cannot do something, add a tool.

Then close the loop: capture feedback each session, audit periodically, apply.

## Shared knowledge base pattern

When more than one person's agents need the same context, centralize it (a shared, agent-optimized store) so no one re-explains the domain. Practices that carry over even for a solo library:
- Markdown for prose (with YAML frontmatter), CSV or TSV for tabular data. No Word, PDF, or slides in the knowledge base; agents cannot parse them.
- YAML frontmatter on every markdown file: `type`, `description` (when should an agent pull this file), `status` (approved/draft/deprecated), `updated`. Pick 5 to 10 types and stay consistent.
- Write for agent consumption: be explicit (no unstated institutional memory), front-load key information (search returns chunks, not whole files), use headers liberally, one topic per file.
- Permissions when shared: contribute-without-delete for most, one or two owners, versioning on for rollback.
- Scaling: retrieval handles hundreds of files; human navigation is the limit. Add subfolders past about 15 to 20 files in one folder; let the `description` field and the agent do the placement work.

## How to apply this

- Put each instruction in its right layer (persona, steering, skill, context, tool). Do not duplicate.
- Keep the always-loaded prompt lean; load everything else on demand.
- Write behavioral rules, add them from observed failures, and run the feedback loop.
- Prefer improving one agent over adding another.
- Store knowledge as markdown and CSV with frontmatter, one topic per file.
