---
type: skill
name: low-ambiguity-notes
title: Low-Ambiguity Notes
description: >-
  Turn meeting transcripts, creative critiques, or raw research captures into
  structured notes with low ambiguity. Use for meeting notes, call notes,
  research atoms, lore intake before canon promotion, or any note that must
  pass the single-interpretation test, even if the user does not say atomic
  or low-ambiguity. Spawn a subagent for long transcripts or multi-note batches.
version: "1.1.0"
timestamp: 2026-07-12
---

# Low-Ambiguity Notes

One job: produce notes a future agent or teammate can retrieve with exactly one interpretation. Two modes: **meeting notes** (full transcript capture) and **atomic notes** (one claim per file or per line block).

**In scope:** transcript → structured meeting note; raw bullets → atomic notes; research / critique captures destined for later canon promotion; quality pass on existing notes.

**Out of scope:** writing thin `world/` bible docs end-to-end; inventing lore; external system logging; calendar scheduling (adapter layer only).

## Workspace fit

This repo promotes notes into canon through [`playbook/notes-to-canon.md`](../../../playbook/notes-to-canon.md). Notes are not canon. Do not write note output into `world/` unless the user explicitly starts a promotion pass and names the target doc.

| Capture type | Typical next step |
| --- | --- |
| Creative review / lore debate | Atomic notes → promote selected claims into `world/` |
| Production / vendor call | Meeting notes → action items; world changes only if a rule changed |
| Research excerpt | Atomic note with source → mood vault or anti-library candidate |

## Mode router

| Input | Mode | Load |
| --- | --- | --- |
| Transcript, recording summary, meeting email | Meeting | `references/meeting-notes-format.md` |
| Single idea, finding, or excerpt to store | Atomic | `references/atomic-notes-quality.md` |
| Need executive tables + red flags | Meeting+tables | Also `references/meeting-extraction-tables.md` |
| Saving to Obsidian or another vault | Any | `references/adapters.md` if path given |

## Meeting notes workflow

**Mode:** meeting capture.

1. Confirm mode: meeting notes (default for transcript).
2. Load `references/meeting-notes-format.md`. Follow section order and filename rules exactly.
3. Do not fabricate names, numbers, owners, or topics not in source.
4. Run atomic quality pass on Key Numbers and Action Items lines per `references/atomic-notes-quality.md` steps 1-4.
5. Output filename as first line (bold). Metadata block second.
6. If user wants table digest, append or replace summary sections per `references/meeting-extraction-tables.md` only when asked.

**Validate:** every action item and metric traceable to source or tagged `[NO METRIC IN SOURCE]` / `[DATA NEEDED]`.

**On failure:** re-read source segment; do not invent missing owners or dates.

## Atomic notes workflow

**Mode:** atomic capture.

1. One concept per file. Kebab-case filename unless user supplies vault convention.
2. Optional frontmatter: `source`, `tags`, `date` (see `references/atomic-notes-quality.md`).
3. Run all seven anti-hallucination steps before delivery.
4. Retrieval simulation on every stored line.
5. If the claim might change canon, add a one-line `promote_to:` hint naming a `world/` path or `none`.

**Validate:** single-interpretation test passes on every stored line.

**On failure:** split multi-claim lines or mark ambiguity explicit; never soft claims as questions buried in prose.

## Delegate to subagent

Spawn a `low-ambiguity-notes` subagent when:

- Transcript over ~30 minutes or output likely over 2k words
- Batch: one transcript plus multiple atomic spin-off notes
- Main thread crowded

Stay inline for short calls, single atomic note, or format-only fix.

## Hard rules

- No aggressive summarization on meeting mode. Output length tracks input length.
- No speaker attribution unless source requires it; follow meeting-notes-format rules.
- No em dashes. Banned words per [`../../../reference/voice.md`](../../../reference/voice.md) plus meeting-notes forbidden list in reference.
- Flag `[NO METRIC IN SOURCE]` or `[DATA NEEDED]` instead of inventing.
- Never paste Purpose / Theory / AI Prompt / Review Checklist into notes as if they were canon.

## Voice

Meeting notes: short sentences, lead with conclusion, numerals for all numbers.

Atomic notes: definitive claims only; questions explicit, never soft claims.

Agent chat with the user: Interaction voice from [`../../../reference/voice.md`](../../../reference/voice.md). Drafted note bodies: Drafting voice from the same file.
