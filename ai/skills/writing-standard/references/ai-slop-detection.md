---
type: reference
title: AI Slop Detection
description: Checklist and rules to humanize AI-drafted text. Load when output sounds LLM-generated, marketing-ish, or formulaic.
timestamp: 2026-07-12
---

# AI Slop Detection

Humanize AI drafts before delivery. Quality is quality regardless of author; AI drafts fail in predictable ways.

**Workspace rules (always apply):**

- 3+ flagged words in one paragraph = rewrite that paragraph
- Zero em dashes anywhere
- No throat-clearing intros ("In today's fast-paced...", "I hope this finds you well")
- No filler sentences that add no information
- Take clear positions; no false balance when data supports one option
- **Pub test:** would you say this to a studio teammate in a casual setting?

**Banned-word list:** [`../../../../reference/voice.md`](../../../../reference/voice.md) is the single source. Do not restate it here.

Do not publish generative-AI output into `world/` without human review and sign-off.

## Word use

- **Hyperbolic adjectives?** Cut "groundbreaking", "revolutionize", "cutting-edge". Inform, do not brag.
- **LLM-overused words?** One "delve" or "leverage" per topic max; beyond that, rewrite. Prefer "use" over "utilize" or "leverage".
- **LLM cliché phrases?** Cut "a rich tapestry of...", "only time will tell if...", "it's important to note that..."
- **Burstiness / repetition?** Same word repeated in close proximity reads robotic. Vary vocabulary in conceptual text; repeat deliberately in procedures where precision matters.

## Sentence structure

- **Too many identical structures in a row?** AI loves parallel templates ("Not only X but also Y" repeated).
- **Participial phrase chains?** LLMs overuse -ing phrase stacks.
- **"That" as subject?** e.g. "That the system failed... indicates..." often signals AI phrasing.
- **Nominalizations?** Prefer verbs: "tighten the palette" over "implement a palette reduction".
- **"In today's..." openers?** Especially "teams face increasing..." Cut entirely.

## Meaning

- **False balance?** AI presents options without picking the better one when data exists.
- **Unasked editorializing?** Cut "It's important to consider...", "No discussion would be complete without..."
- **Overstated significance?** Cut "stands as a testament to", "plays a vital role", "underscores the importance of".
- **Fluff sentences?** Grammar-correct but empty. If you halved word count, what goes first?
- **Irrelevant tangents?** Related is not the same as relevant to the document's purpose.

## Accuracy (AI-specific)

- **Hallucinated facts?** Verify every assertion; tag unknowns `[VERIFY]` or `[DATA NEEDED]`.
- **Fake sources?** Check links and citations exist.
- **Fake UI or file paths?** Button labels and repo paths must match reality.
- **Weasel attributions?** "Has been described as...", "Critics have argued..." without naming who.

## Transition phrases

- **Connector mismatch?** "However" followed by more of the same, not a contrast.
- **Transition spam?** Multiple sentences starting with "However", "Furthermore", "Additionally".
- **Unnecessary organizers?** "Firstly", "Primarily", "In conclusion" on short or simple ideas.

## Document structure

- **Scattered related ideas?** Group concepts; use headings.
- **Repetition in different words?** Same point stated three ways = cut two.
- **Title case headings?** Prefer sentence case per repo style.
- **Excessive bold, lists, em dashes?** Common AI tells; simplify.
- **Markdown artifacts?** Broken `**bold**`, prompt formatting leaked into prose.

## Prompt remnants

Cut conversational LLM residue:

- "Certainly! I'll provide..."
- "Here's a detailed breakdown of..."
- "In this section, we will discuss..."
- Knowledge cutoff lines ("As of my last knowledge update...")

## Self-check before delivery

1. Read aloud. Does it sound like a person talking?
2. Count flagged words per paragraph. Any paragraph with 3+ → rewrite.
3. First sentence: main point or throat-clearing?
4. Every claim: sourced, tagged `[DATA NEEDED]`, or cut.
5. Pub test pass?

For deep structure and procedure rules, load `writing-handbook.md`.
