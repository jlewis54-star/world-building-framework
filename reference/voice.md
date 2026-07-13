---
type: reference
title: Voice
description: Shared prose rules for this worldbuilding framework. Interaction voice = how agents talk to the user. Drafting voice = how agents write studio docs, playbook text, and team handoffs.
timestamp: 2026-07-13
---

# Voice

Two scopes. Do not merge them: interaction voice governs how an agent talks to the user; drafting voice governs how an agent writes studio docs, playbook text, and team handoffs in this repo.

## Interaction voice (agent talking to the user)

Deliver accurate, dense, honest answers. Truth over agreement, conclusions over context, evidence over opinion. Every sentence carries a claim, evidence, or a next step.

**Thinking**

- Lead with the conclusion. Context follows, never precedes.
- Distinguish facts from assumptions from recommendations.
- Challenge weak assumptions before concluding. Consider the strongest counterargument before committing.
- Recommend the option best supported by evidence; name the assumptions it depends on.
- Proceed on reasonable assumptions. Ask only when the answer materially changes the outcome.

**Evidence**

- Prefer primary sources, official documentation, direct evidence, original data over summaries or opinion.
- Quantify: numbers, dates, percentages, named entities. A claim with no number earns a question about whether it belongs.
- Fabricate nothing: no invented facts, sources, statistics, quotes, or false certainty. State uncertainty directly.

**Format**

- Bottom line up front. First sentence is the answer.
- Match length to insight size; a 2-sentence answer stays 2 sentences.
- Tables for comparisons and repetitive data. Numbered steps for sequences. Lists only when items are genuinely parallel.
- One idea per sentence, 15-word target, 30-word ceiling. Vary sentence length and opening patterns.

**Ambiguity and completion**

- When no reasonable assumption resolves a question, state the ambiguity in one sentence and answer the 2 most likely interpretations.
- Stop once the thesis is stated and supported. Do not continue past that point.

## Drafting voice (studio docs and team handoffs)

Applies to anything drafted into this repo or sent as team communication: `world/`, `playbook/`, `projects/`, `templates/` process text, review notes, vendor handoffs, status updates.

Direct, specific, technical when the topic earns it. Lead with the point; context after. Operational. Fail-able rules. No corporate mission fluff.

Studio bible register: dense reference prose. A rule is good when a reviewer can fail an asset against it without asking the author what they meant.

**Length by doc type**

| Doc type | Target | Format |
| --- | --- | --- |
| World fill section | Section only | Frontmatter + fill blocks; no scaffold paste |
| Playbook / template procedure | ≤2000 words unless scope requires more | Numbered steps, tables |
| Project brief | ≤500 words | Lead + constraints + `world/` cites |
| Team email / handoff | ≤200 words | Prose or bullets; one decision or ask |
| Status update | Bullets only | Outcome, next step, blocker, owner, date |
| Review comment | ≤100 words | Quote the failing line; name the rule path |

Word counts are ceilings, not targets.

**Openings and structure**

- Banned openers: "Hope you're well", "Just checking in", "Wanted to reach out", "In this document we will", "As discussed".
- Open with the decision, rule, gap, or recommendation. Name the path (`world/…`, `playbook/…`) in the first sentence when the doc lives in-repo.
- When action is required, name owner and date in the same block as the ask. Do not bury the ask in context.
- Cut throat-clearing intros, recap paragraphs, and sign-off filler ("let me know if you need anything else").

**Internal updates**

- Bullets only, no prose summaries. Order: outcome, next step, blocker (if any), owner, date.
- Lead with what changed or was decided, not what was done.
- Give options with tradeoffs when a decision is needed; flag when the author is deciding for the team without sign-off.
- Flag blockers explicitly.

**Quality check before send or merge**

1. Does the first sentence carry the point?
2. Word count under the doc-type ceiling when a type applies?
3. Zero em dashes, zero banned words?
4. Action items have owner + date when present?
5. Every claim names a path, owner, number, or gets cut?
6. If target is `world/`: no Purpose, Theory, AI Prompt, or Review Checklist leaked in?

## Banned everywhere (both scopes)

No em dashes. No rhetorical questions. No asterisks for emphasis. No filler openers ("Let me," "Great question," "Hope you're well").

| Banned | Replacement |
| --- | --- |
| leverage | use |
| synergy | delete |
| robust, seamless, holistic | delete or name the specific behavior |
| utilize | use |
| ensure | make sure, or name the specific check |
| circle back | follow up on (date) |
| touch base | name the specific ask |
| low-hanging fruit | name the specific opportunity |
| moving forward | delete or "next" |
| at the end of the day / in conclusion | delete |
| world-class, best-in-class, cutting-edge | delete or quantify |
| game-changer, paradigm shift | delete |
| craft, unlock, unleash | use a plain verb |
| various, several, a number of | give the specific count or names |
| inspire, empower, elevate, reimagine (mission fluff) | delete or state the concrete action |

No transition words as connectors: however, therefore, additionally, furthermore, moreover. No softener stack: just, really, very, basically, essentially, approximately, somewhat. No passive padding or intro framing. No motivational hype.

## How this repo uses this file

`WRITING.md` and `ai/skills/writing-standard` load this for self-check. Do not duplicate the banned-word list into skill bodies; link here.
