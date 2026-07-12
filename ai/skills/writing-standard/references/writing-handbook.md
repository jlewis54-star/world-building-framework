---
type: reference
title: Writing Handbook
description: Long-form rules for studio memos, procedures, and deep edits. Load on demand for formatting disputes and narrative structure.
timestamp: 2026-07-12
---

# Writing Handbook

Condensed reference for this worldbuilding framework. Load sections on demand. Full banned-word list lives in [`../../../../reference/voice.md`](../../../../reference/voice.md).

## Narrative memos (when to use)

Use a short narrative memo when a decision needs context: canon MAJOR bump, new brand partner tier, greenlight on a cross-media project.

Structure:

1. **Opening sentence:** the decision or recommendation
2. **Background:** only what the reader needs to judge the call
3. **Options considered:** 2-3 max, with tradeoffs
4. **Recommendation:** one clear pick
5. **Next steps:** owner + date per action

Default length: 1-2 pages for most studio decisions. Appendices for asset matrices, timelines, or vendor lists.

Slides are fine for walkthroughs. Decisions still land in prose the team can cite.

## Pyramid structure

Most important information first. Supporting detail after.

```
❌ "After reviewing twelve mood boards, polling the writers, and testing
packaging mockups, we recommend locking the rectangular institution rule."

✅ "Lock the rectangular institution rule (recommendation). Mood boards,
writer poll, and packaging tests support it. Detail below."
```

## Active vs passive

Prefer active voice in decision sentences. Passive is OK when the actor does not matter ("The manifesto was signed off on March 3").

## Plain language

- Prefer common words over Latinisms (*via* → *through*, *per* → *for each* when it reads cleaner)
- Define world-specific terms once, then use the dictionary term from `21_verbal_lexicon`
- One idea per sentence when writing rules someone will fail an asset against

## Procedures

Number steps when order matters. Start each step with an imperative verb.

```
1. Open `world/10_foundations/12_lore_canon.md`.
2. Add the timeline row under Historical Timeline.
3. Run `ai/agents/canon-consistency.md` before setting `status: review`.
```

Console/UI procedures for creative tools: name the exact menu or file path. Do not invent UI labels.

## Headings and formatting

- Sentence case for headings in repo docs (`## Core friction`, not `## Core Friction`)
- Tables for comparisons; bullets for parallel items; numbers for sequences
- No decorative bold. Structural labels only.

## Weasel words and hedging

Cut: very, quite, somewhat, approximately, generally, we believe, it seems, arguably, moving forward.

Replace with a number, a path, an owner, or delete.

## AI-drafted text

Run `ai-slop-detection.md` when the source was LLM-generated. Human review required before canon sign-off.

Do not publish generative output into `world/` without:

1. Consistency pass (`canon-consistency` agent)
2. Writing pass (this skill)
3. Named owner setting `status: signed_off`

## Length targets

| Format | Target |
| --- | --- |
| Email / short message | ≤200 words |
| 1-pager / brief | ≤500 words |
| Playbook section | ≤2000 words unless scope requires more |
| World fill section | Only the section being filled |

## Internal updates (team)

Bullets only. Order: outcome, next step, blocker (if any), owner, date.

Lead with what changed or was decided, not what was done.

## Quality bar for world docs

A world rule is good when a reviewer can fail an asset against it without asking the author what they meant.

Bad: "Keep the vibe cohesive."
Good: "No UI glassmorphism. No pure white full-bleed backgrounds."

## When to load this handbook vs writing-standards.md

| Need | Load |
| --- | --- |
| Quick email or paragraph edit | `writing-standards.md` |
| Slop / LLM tells | `ai-slop-detection.md` |
| Long memo, procedure, formatting fight | This file |
| Banned words, tone | `reference/voice.md` |
