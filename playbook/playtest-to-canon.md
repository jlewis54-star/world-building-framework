# Playtest to Canon

Promotion pass before **MAJOR** canon bumps or public publish. Complements [`notes-to-canon.md`](notes-to-canon.md).

---

## When to run

- Before rewriting factions, timeline, or reality rules in `12_lore_canon`
- Before `CANON_VERSION` MAJOR bump
- When a TTRPG arc or fiction draft accumulated facts only in `projects/`

---

## Procedure

1. **List open projects**

```bash
./scripts/list-open-projects.sh
```

2. **Scan each `projects/*/PROJECT.md` and session notes in `examples/scratch/`**

| Question | Action |
| --- | --- |
| Does this fact change a world rule? | Promote to matching `world/` doc |
| Is this a one-off instance (NPC name, session outcome)? | Keep in project; cite in hook only |
| Does it contradict signed `12`? | Resolve before MAJOR bump |
| Is it channel tactics? | Stay in project |

3. **Run promotion gate** from [`notes-to-canon.md`](notes-to-canon.md) for each promoted claim.

4. **Update governance**

- Add row to Canon Changelog
- Bump `CANON_VERSION` if rules changed
- Update Skip Registry if un-skipping docs for publish
- Run `./scripts/check_canon_version.sh`
- Notify stale projects (`inherits_canon` < governance version)

5. **Run `ai/agents/canon-consistency.md`** on edited world docs.

---

## Playtest lore stranded (anti-pattern)

| Symptom | Fix |
| --- | --- |
| Faction names only in `projects/2026-02-arc-one/` | Promote names to `12` or mark as non-canon instance |
| Table ruling repeated across sessions | Promote to reality rules in `12` |
| NPC backstory in scratch | Promote or delete; do not paste into `PROJECT.md` hook |

---

## After promotion

Archive or delete scratch files promoted into canon. Update project Migration notes if MAJOR bump breaks handouts.
