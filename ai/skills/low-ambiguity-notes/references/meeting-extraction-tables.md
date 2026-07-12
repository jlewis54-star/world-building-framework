# Meeting Extraction Tables (optional)

Load only when user asks for executive digest or table-heavy output. Default meeting mode uses `meeting-notes-format.md` (no tables).

## When to use

- Internal exec prep where scannability beats narrative depth
- User explicitly requests tables, red flags, or stakeholder comms plan

## Sections (table-friendly)

1. Meeting metadata (title, date, duration, attendees, type)
2. Executive summary: 3 bullets (decided / changing / needs attention)
3. Decisions table: Decision | Rationale | Owner | Effective Date | Reversibility (flag irreversible / costly / easy)
4. Action items table: # | Action | Owner | Due Date | Priority | Depends On. One owner each, concrete verb, P0/P1/P2
5. Open questions: Question | Resolver | By when | How
6. Parking lot: Topic | Why deferred | Revisit when
7. Risks: Risk | Raised by | Severity | Mitigation
8. Key insights/quotes (preserve non-obvious statements)
9. Stakeholder impact: Who | What to communicate | By whom | By when
10. Follow-up meetings needed
11. Red flags: conflicts, missing stakeholders, unrealistic commitments

## Quality checks before finalize

- Every decision has rationale
- Every action has owner and date
- No vague verbs ("look into")
- Dependencies explicit

Do not invent owners or dates not in source. Use `[UNASSIGNED]` or `[DATE NOT STATED]` only when source silent.
