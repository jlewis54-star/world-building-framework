# Atomic Notes Quality

Anti-hallucination checks for atomic notes.

## The test

Can this line be retrieved in 3 months with exactly one interpretation and zero gap-filling?

## Seven steps

1. **Kill hedging.** Remove might, could, potentially, generally, significant, recently, soon, various, several. Definitive claim or delete.
2. **Resolve ambiguous references.** Replace this/it/they/the team with named nouns. Standalone sentences.
3. **Single-claim lines.** One subject-verb-object. Split on "and" when two facts.
4. **Specificity floor.** Each claim needs a number, proper name, or date; else `[NO METRIC IN SOURCE]` or delete.
5. **Strip unsupported causation.** Correlation only unless source states cause. Flag `[CORRELATION; CAUSATION NOT STATED]`.
6. **Anchor time.** Absolute dates. "Last quarter" → "Q1 2026".
7. **Retrieval simulation.** Read line cold. Two meanings → rewrite. Invites inference → delete or gap marker.

## File convention (atomic mode)

- One concept per file
- Filename: `{topic}-{subtopic}.md` kebab-case
- Optional frontmatter:

```yaml
---
source: "URL or reference"
tags: [topic]
date: YYYY-MM-DD
---
```

## Exception

Exploratory notes (Status: Seed) may use explicit questions. Never soft claims ("likely caused by...").
