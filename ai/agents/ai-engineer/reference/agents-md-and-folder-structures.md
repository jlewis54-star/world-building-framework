---
type: guide
title: AGENTS.md and 2026 Project Folder Structures
description: The AGENTS.md standard, the .agents protocol, the full 2026 AI-ready file hierarchy (CLAUDE.md, Skills, Memory, Context), and a project charter folder template for enablement initiatives.
tags: [agents-md, folder-structure, project-charter, skills, memory, conventions, enablement]
timestamp: 2026-07-07
sources:
  - https://AGENTS.md
  - https://dotagentsprotocol.com/
  - https://amitray.com/claude-md-vs-agents-md-memory-md-skills-md-context-md-guide-2026/
  - https://blog.buildbetter.ai/agents-md-complete-guide-for-engineering-teams-in-2026/
---

# AGENTS.md and 2026 Project Folder Structures

## What Is AGENTS.md

A standardized markdown file at the root of a repository that gives AI coding agents persistent instructions about the project. It is a README written for LLMs: human-readable, but structured for machine consumption.

- **Stewarded by:** Agentic AI Foundation under the Linux Foundation.
- **Emerged from:** OpenAI Codex, Amp, Jules (Google), Cursor, Factory.
- **Compatible with:** Claude Code, GitHub Copilot CLI, Cursor, Windsurf, Codex, Jules, Aider.

### Core Principles

- One AGENTS.md works across many agents (tool-agnostic).
- No required fields. Standard markdown, any headings you like.
- Closest AGENTS.md to the edited file wins (hierarchical).
- Explicit user chat prompts override everything.
- Agents will execute testing commands listed in AGENTS.md automatically.

---

## AGENTS.md Template

```markdown
# AGENTS.md

## Project Overview
[What this project does, who it serves, key architecture]

## Tech Stack
- Language: [e.g., TypeScript]
- Framework: [e.g., Next.js 15]
- Package manager: [e.g., pnpm]
- Database: [e.g., PostgreSQL via Prisma]

## Build & Run
- Install: `pnpm install`
- Dev: `pnpm dev`
- Build: `pnpm build`
- Test: `pnpm test`
- Lint: `pnpm lint`

## Code Conventions
- [Style rules]
- [Naming patterns]
- [Import ordering]
- [File organization]

## Testing Instructions
- Run full suite before committing
- Add or update tests for every change
- Use pattern: `pnpm vitest run -t "<test name>"` for focused runs

## PR Instructions
- Title format: `[package-name] Description`
- Always run lint and test before committing
- Squash commits on merge

## Security
- Never commit secrets or API keys
- Use environment variables for all credentials
- Flag any dependency with known CVEs

## Do NOT Modify
- [Generated files, config that breaks things]
- [Files managed by CI/CD]
```

### Monorepo Pattern

Place nested AGENTS.md inside each package. The closest file to the edited code takes precedence. OpenAI's own repo has 88 AGENTS.md files.

---

## The Full 2026 AI-Ready File Hierarchy

Beyond AGENTS.md, a mature project in 2026 uses multiple context files:

```
project-root/
├── AGENTS.md              # Universal agent instructions (cross-tool)
├── CLAUDE.md              # Claude Code specific (project-level)
├── CLAUDE.local.md        # Personal overrides (gitignored)
├── .github/
│   └── copilot-instructions.md   # GitHub Copilot specific
├── .cursor/
│   └── rules/             # Cursor-specific rule files
├── .windsurf/
│   └── rules              # Windsurf-specific
├── .agents/               # .agents protocol directory
│   ├── config.yaml        # Model config, MCP tools
│   ├── skills/            # Reusable task templates
│   │   ├── write-test/
│   │   │   └── SKILL.md
│   │   └── review-pr/
│   │       └── SKILL.md
│   ├── sub-agents/        # Agent definitions
│   ├── tasks/             # Active task state
│   └── memories/          # Persistent learned context
├── MEMORY.md              # Cross-session learned facts
├── CONTEXT.md             # Current project state/focus
└── README.md              # Human-facing documentation
```

### What Each File Does

| File | Audience | Persistence | Purpose |
|------|----------|-------------|---------|
| AGENTS.md | All AI agents | Permanent, versioned | Build, test, conventions, constraints |
| CLAUDE.md | Claude Code | Permanent, versioned | Claude-specific rules, commands |
| CLAUDE.local.md | Claude Code (personal) | Not committed | User preferences, local paths |
| MEMORY.md | All agents | Grows over time | Learned project facts, past decisions |
| CONTEXT.md | All agents | Updated per sprint/phase | Current goals, active work, blockers |
| .agents/config.yaml | .agents protocol tools | Permanent | MCP servers, model selection, tool config |
| .agents/skills/ | On-demand loading | Permanent | Task-specific instruction sets |

### Priority Order (When Instructions Conflict)

1. User's live chat prompt (highest)
2. Nearest AGENTS.md to the file being edited
3. Root AGENTS.md
4. Tool-specific file (CLAUDE.md, .cursorrules)
5. Memory/Context files (lowest)

---

## The .agents Protocol

An open directory convention for AI agent configuration. Everything in plain, version-controllable files.

### config.yaml

```yaml
model:
  default: claude-sonnet-4.6
  reasoning: deepseek-r1
  fast: claude-haiku-4.5

mcp_servers:
  github:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-github"]
  filesystem:
    command: npx
    args: ["-y", "@modelcontextprotocol/server-filesystem"]

defaults:
  temperature: 0.3
  max_tokens: 4096
```

### Skills (SKILL.md)

Skills are on-demand instruction sets loaded when a specific task type is detected.

```markdown
---
name: write-test
description: Generate unit tests for a function
triggers: ["write test", "add tests", "test coverage"]
---

# Write Test

Given a function, produce a unit test covering:
- Happy path with expected inputs
- Edge cases (null, empty, boundary)
- Error conditions and exception paths

Match the project's test framework and naming conventions.
Place the test file adjacent to the source file with `.test.` suffix.
Run the test to confirm it passes before reporting done.
```

### Sub-Agents

```markdown
---
name: code-reviewer
role: Review code for correctness, security, and style
model: claude-sonnet-4.6
tools: [filesystem, github]
---

# Code Reviewer

You review pull requests. For each file changed:
1. Check correctness (logic errors, off-by-ones, null handling)
2. Check security (injection, auth bypass, data exposure)
3. Check style (per AGENTS.md conventions)

Output format:
- APPROVED (if clean)
- ISSUES: severity | file:line | description | suggested fix
```

---

## Project Charter Folder Structure

Use this template when starting an enablement initiative.

```
{initiative-name}/
├── AGENTS.md                    # Agent instructions for this project
├── charter/
│   ├── charter.md               # Project charter document
│   ├── stakeholders.md          # RACI, decision makers, SMEs
│   ├── timeline.md              # Milestones, dates, dependencies
│   └── success-metrics.md       # KPIs and measurement plan
├── content/
│   ├── drafts/                  # Working content drafts
│   ├── final/                   # Approved deliverables
│   └── templates/               # Reusable content templates
├── research/
│   ├── discovery/               # Initial research, interviews, data
│   ├── competitive/             # Competitor/peer analysis
│   └── insights/                # Synthesized findings
├── design/
│   ├── wireframes/              # Visual layouts and flows
│   ├── assets/                  # Images, icons, brand elements
│   └── reviews/                 # Design feedback and iterations
├── sme-artifacts/
│   ├── interviews/              # SME interview notes and transcripts
│   ├── source-materials/        # Raw docs from subject matter experts
│   └── validations/             # SME sign-offs and fact-checks
└── .agents/
    └── skills/
        └── enablement-review/
            └── SKILL.md          # Skill for reviewing enablement content
```

### charter.md Template

```markdown
# Project Charter: {Initiative Name}

## Problem Statement
[What gap or need does this enablement initiative address?]

## Objective
[One sentence: what does success look like?]

## Scope
- In scope: [deliverables, audiences, platforms]
- Out of scope: [explicit exclusions]

## Audience
- Primary: [who benefits directly]
- Secondary: [who else uses it]

## Deliverables
1. [Deliverable 1] - [format, owner, due date]
2. [Deliverable 2] - [format, owner, due date]

## Success Metrics
| Metric | Baseline | Target | Measurement Method |
|--------|----------|--------|--------------------|
| [KPI 1] | [current] | [goal] | [how measured] |

## Timeline
| Phase | Start | End | Key Activities |
|-------|-------|-----|----------------|
| Discovery | [date] | [date] | Research, SME interviews |
| Design | [date] | [date] | Content architecture, wireframes |
| Development | [date] | [date] | Content creation, review cycles |
| Launch | [date] | [date] | Publishing, communication, training |

## Stakeholders
| Role | Person | Responsibility |
|------|--------|----------------|
| Sponsor | [name] | Approvals, budget |
| Lead | [name] | Day-to-day execution |
| SME | [name] | Domain expertise, validation |
| Reviewer | [name] | Quality and accuracy checks |

## Risks
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| [Risk 1] | H/M/L | H/M/L | [action] |

## Decision Log
| Date | Decision | Rationale | Decided By |
|------|----------|-----------|------------|
| | | | |
```

### AGENTS.md for Enablement Projects

```markdown
# AGENTS.md - Enablement Initiative

## Project Type
Enablement content development initiative.

## Conventions
- All content drafts go in content/drafts/ until approved
- File naming: kebab-case, descriptive (e.g., objection-handling-guide.md)
- Research files include date prefix: YYYY-MM-DD-{description}.md
- SME artifacts are read-only reference; never modify originals

## Workflow
1. Research phase: populate research/ from discovery interviews and desk research
2. Design phase: create wireframes/outlines in design/
3. Draft phase: write content in content/drafts/
4. Review phase: get SME validation in sme-artifacts/validations/
5. Final phase: move approved content to content/final/

## Quality Checks
- Every content piece must have at least one SME validation
- Check charter/success-metrics.md to confirm deliverable aligns with KPIs
- Cross-reference research/insights/ for factual grounding
- Ensure consistent terminology across all deliverables

## Do NOT
- Modify anything in sme-artifacts/source-materials/
- Publish content without a matching entry in sme-artifacts/validations/
- Change charter.md without stakeholder approval
- Create folders outside the defined structure
```

---

## Best Practices

### Writing Effective AGENTS.md

- Be specific over general: "Use pnpm, not npm" beats "follow project conventions".
- Commands are gold: executable instructions the agent can run and verify.
- Update when you correct: if you told the agent something in chat, put it in the file.
- Keep it under 2000 tokens: long files get partially read. Split into nested files.
- Include anti-patterns: "Do NOT" rules prevent common agent mistakes.

### Choosing What Goes Where

| Information Type | Put It In |
|------------------|-----------|
| Build/test/lint commands | AGENTS.md |
| Code style and conventions | AGENTS.md |
| Project architecture | AGENTS.md (overview) + code comments (detail) |
| Current sprint goals | CONTEXT.md |
| Past decisions and rationale | MEMORY.md |
| Task-specific workflows | .agents/skills/SKILL.md |
| Personal preferences | CLAUDE.local.md (gitignored) |
| Recurring agent behaviors | .agents/sub-agents/ |

### Migration Path (Legacy to 2026 Structure)

1. Start with AGENTS.md (build commands + conventions).
2. Add the project charter folder scaffold for new initiatives.
3. Extract reusable patterns into .agents/skills/.
4. Add MEMORY.md once the project has decisions worth preserving.
5. Add CONTEXT.md when the project has phases or sprints.
