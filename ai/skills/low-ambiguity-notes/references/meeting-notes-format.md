# Meeting Notes Format

Format for low-ambiguity meeting notes in this repo.

## Filename (first output line, bold)

`YYYY.MM.DD_[INT|EXT]_Type_Subject_ShortDescriptor`

- PascalCase within segments. Underscores between. No spaces.
- Type: Strategy, Cadence, Review, Standup, CreativeReview, Kickoff, Debrief, Planning, Workshop, Retro, or similar.
- Under 100 chars. No `\ / : * ? " < > |`
- Add `_AM`, `_PM`, `_01`, `_02` for same-day duplicates.

## Metadata block (plaintext, every field on its own line)

```
File: [repeat filename]
Template: v1.1
Date: [YYYY-MM-DD]
Classification: [Internal or External]
Customer/Subject: [name]
Project: [from discussion or General]
Participants: [comma separated, no titles, do not guess]
Topics: [3-8 labels]
Related Meetings: None
Follow-Up Status: Open
Read Time: [word count / 250, rounded up] min
```

## Section order

1. **What This Meeting Was About** — 2-3 sentences. Outcome first.
2. **Decisions** — numbered. Conditions included. No speaker attribution.
3. **Action Items** — bullet. Task in bold. Owner on second line only if clearly assigned. No TBD placeholders.
4. **Key Numbers** — every metric, date, dollar, quantity. Bold the number.
5. **What Was Discussed** — 3-7 topic subheadings. Full record; do not compress long transcripts.
6. **Open Questions and Risks** — numbered with recommended next step.
7. **Pre-Event Checklist** — checkbox list; only if meeting prepares a future event.

## Writing rules

- Capture everything. Minor points stay.
- No fabrication. No speaker labels in discussion narrative.
- Short sentences. Active voice. Numerals for all numbers.
- Data over adjectives. "11 vendor mockups" not "many mockups."
- No tables, SVG, Mermaid, or code blocks except metadata.

## Forbidden language (meeting output)

See source list: hedge words (however, furthermore, in conclusion...), slop (leverage, robust, seamless, stakeholder...), weak intensifiers (basically, very, significantly...), hype verbs (enhance, foster, streamline...). Retain only inside proper nouns or direct quotes.
