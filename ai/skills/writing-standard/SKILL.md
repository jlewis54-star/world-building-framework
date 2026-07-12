---
type: skill
name: writing-standard
title: Writing Standard
description: >-
  Enforce clear, direct, data-driven prose and remove AI slop. Use when improving
  writing, reviewing a doc or email, rewriting for clarity, checking against
  studio writing standards, or humanizing AI drafts, even if the user does not
  name writing-standard or WRITING.md. Primary targets: playbook docs, thin world
  stubs, project briefs, shipping copy, partner guidelines. Do NOT use to invent
  a world's brand voice from scratch (world/21_verbal_lexicon) or final creative
  fiction that intentionally breaks formal standards.
version: "1.2.0"
timestamp: 2026-07-12
---

# Writing Standard

One job: turn vague, passive, or AI-sounding text into clear, direct, data-driven prose for this studio bible repo.

**In scope:** edit and rewrite framework docs, world fill sections, project briefs, shipping copy, partner emails, status notes; run standards checklist; humanize AI drafts; explain what changed.

**Out of scope:** inventing the world's brand voice from nothing (fill `world/20_identity/21_verbal_lexicon.md` instead); final creative fiction or marketing that intentionally breaks formal standards; legal review.

## Standards (load on demand)

| Reference | Load when |
| --- | --- |
| `references/writing-standards.md` | Quick rewrite pass, email/doc review, clarity checklist |
| `references/ai-slop-detection.md` | Text sounds LLM-generated, marketing-ish, or formulaic |
| `references/writing-handbook.md` | Long memos, deep style rules, formatting, procedures, global English |
| [`../../../reference/voice.md`](../../../reference/voice.md) | Every pass. Drafting voice is authority for tone, banned words, zero em dashes |

Do not restate the banned-word list here. Load Drafting voice for repo docs and outbound copy. Load Interaction voice only when the output is a direct reply to the user rather than a draft into the repo.

## Workspace defaults

| Doc class | Expectation |
| --- | --- |
| `world/**` | Thin stubs. Fill sections only. No scaffold paste. |
| `templates/**` | Thick process OK. Still no em dashes / banned slop. |
| `projects/**` | Cite `world/` paths. No lore duplication. |
| `playbook/**`, root docs | Procedure voice. Tables and numbered steps. |

Also enforce root [`WRITING.md`](../../../WRITING.md) self-check.

## Core principles

Load and apply [`references/writing-standards.md`](references/writing-standards.md) on every pass. Do not restate the six principles here.

## Workflow

### 1. Classify the text

**Mode:** diagnosis (classify only; no rewrite yet).

Identify:

- **Format:** world fill, playbook procedure, project brief, email, 1-pager, chat message, other.
- **Goal:** inform, decide, request action, status update, fill canon.
- **Audience:** teammate, creative lead, vendor/partner, external.
- **Source:** human draft, AI draft, mixed.

If final creative fiction or pure marketing hype was requested, stop and say out of scope for this skill (point at `world/` voice docs or a creative brief instead).

**Validate:** format, goal, audience, and source identified.

**On failure:** ask one clarifying question; do not rewrite until scope is clear.

### 2. Diagnose top issues

**Mode:** audit (read-only on source text).

Scan for the three highest-impact problems. Priority order:

1. Missing conclusion or buried lead
2. Passive voice in key sentences
3. Claims without data, paths, or examples
4. Unclear ask (no owner/deadline) when an ask is required
5. AI slop tells (see `references/ai-slop-detection.md`)
6. Weasel words and filler
7. Scaffold leaked into `world/` (Purpose, Theory, AI Prompt, Review Checklist)

Load `references/writing-standards.md` for email and short-doc patterns.
Load `references/ai-slop-detection.md` when source is AI or text feels generic.
Load `references/writing-handbook.md` for long procedures or formatting disputes.

**Validate:** top three issues named with quotes or line references.

**On failure:** re-scan using priority order; do not skip to rewrite with fewer than three issues unless text is under 50 words.

### 3. Rewrite

**Mode:** edit (apply fixes).

Apply fixes in this order:

1. Restate the lead sentence (main point in one line).
2. Replace vague claims with specifics or mark `[DATA NEEDED]`.
3. Flip passive to active in decision sentences.
4. Add owner + deadline to every action item.
5. Cut throat-clearing intros and filler paragraphs.
6. Run slop pass: hyperbolic adjectives, LLM phrases, false balance, transition spam.
7. Enforce length targets when format known:
   - Email body: ≤200 words unless user asks otherwise
   - 1-pager: ≤500 words
   - Full doc: ≤2000 words unless scope requires more
   - World fill: only the sections being filled; do not expand into scaffold

Do not invent facts or lore. If data is missing, flag it; do not fabricate numbers or continuity.

**Validate:** revised text addresses the three diagnosed issues.

**On failure:** loop to step 2 with remaining issues.

### 4. Self-check before delivery

**Mode:** validate (checklist only).

Run every item:

- [ ] Lead states main point (not "In this document, we will...")
- [ ] Claims have data, examples, paths, or `[DATA NEEDED]` tags
- [ ] Key sentences use active voice
- [ ] Action items have owner + deadline when present
- [ ] Zero em dashes
- [ ] Zero `reference/voice.md` banned words
- [ ] 3+ flagged slop words in one paragraph → that paragraph rewritten
- [ ] Subject/title describes content (not "Update" or "FYI")
- [ ] Pub test: would you say this to a studio teammate
- [ ] If target is `world/`: no Purpose / Theory / AI Prompt / Review Checklist leaked in

**On failure:** fix failing items before step 5. Do not deliver partial passes.

### 5. Present output

**Mode:** deliver.

Use this structure unless user asks for rewrite only:

```markdown
## Issues Found
1. [Issue]: [quote or example from text]
2. [Issue]
3. [Issue]

## Key Rewrites

**Original:** "[quote]"
**Improved:** "[rewrite]"
**Why:** [one line]

## Full Revised Version
[complete rewrite]
```

For quick "just fix it" requests, deliver **Full Revised Version** first, then a short **What changed** bullet list (max 5 items).

## Output constraints

- Direct tone. No hedging openers ("I hope this finds you well").
- Take positions when data supports them. No false balance.
- Preserve technical accuracy. Do not simplify away necessary precision.
- Match user's stated length and formality unless standards require stricter.

## Gotchas

- AI drafts often pass grammar but fail substance. Slow down; paraphrase each sentence mentally.
- "Leverage" and "delve" may appear once; more than once in a section triggers rewrite.
- Series sentences ("You can do A. You can also do B.") read worse than "You can do A, B, or C" unless items are very long.
- Subject lines like "Update" or "FYI" fail the checklist every time; always propose a descriptive replacement.
- Handbook is long-form reference. Load sections on demand, not whole file into working memory.
- Do not match `theory/` academic cadence when rewriting canon or playbook text.

## Voice

See [`../../../reference/voice.md`](../../../reference/voice.md). Do not duplicate its rules here.
