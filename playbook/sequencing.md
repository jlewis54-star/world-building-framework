# Sequencing

Dependency order for coherent worlds. Matches treatise Phased Build Plan with governance stub early and harden late.

## Dependency graph

```text
01_governance (stub)
        |
11_manifesto ----+------------------+
        |        |                  |
12_lore_canon    |                  |
        |        |                  |
        +--------+--------+         |
                 |        |         |
         21_verbal   22_visual   31_sonic (optional)
                 |        |
                 +---+----+
                     |
              23_asset_behavior
                     |
              41_brand_guidelines
                     |
              42_channel_playbook
                     |
              projects/* (shipping)
                     |
              01_governance (harden) + 51/52 vaults
```

## Must decide early

Breaks coherence if deferred:

- Core friction / emotion / enemy (`11`)
- World type + hard/soft dial (`01` profile)
- Rules of reality (`12`)
- Voice poles (`21`)

## Can fill later

- Deep timeline and secondary characters
- Sonic DNA
- Mood vault and anti-library detail
- Channel edge cases
- Campaign/project instances

## Phase gates

| Phase | Deliverables | Gate |
| --- | --- | --- |
| P0 | World profile | Type + dial + owners |
| P1 | `11`, `12` stub | Friction one-liner + five beliefs |
| P2 | `21`, `22`, `23`, optional `31` | Voice matrix + palette + silhouette |
| P3 | `41`, `42`, vault seeds | Partner-safe brand one-pager |
| P4 | First `projects/*` | Shipping Ledger pass |
| P5 | Governance harden | `CANON_VERSION` + change protocol |

## Skip rules

- `STATUS: skip` allowed only where [`world-types.md`](world-types.md) permits.
- Skipped docs stay in tree with frontmatter `status: skipped` and one-line reason.
- Do not delete numbered slots. Downstream links assume paths exist.
