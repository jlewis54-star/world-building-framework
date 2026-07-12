---
doc_id: 01_governance_ledger
status: draft
canon: true
canon_version: 0.1
owners: []
updated: YYYY-MM-DD
---

# 01 Governance Ledger

## World Profile

| Field | Value |
| --- | --- |
| World name | _fill_ |
| World type | fiction / brand / creator_ip / ttrpg |
| Hard/soft dial | hard / soft. _one sentence_ |
| Primary owners | manifesto: _name_; lore: _name_; visual: _name_; verbal: _name_ |

## Canon Version

| Field | Value |
| --- | --- |
| CANON_VERSION | 0.1 |
| Last tag | canon/v0.1 (when tagged) |
| Change summary | Initial stub |

## Change Protocol

1. Propose change in PR against the affected `world/` doc.
2. Classify impact: **MINOR** (additive) or **MAJOR** (breaking).
3. Required approvers: owners of affected layer + manifesto owner for MAJOR.
4. On merge of MAJOR/MINOR: bump `CANON_VERSION`; tag `canon/vX.Y`.
5. Notify open projects that inherit prior version.

## Sign-Off Matrix

| Doc | Draft | Review | Signed off by | Date |
| --- | --- | --- | --- | --- |
| 11_manifesto | | | | |
| 12_lore_canon | | | | |
| 21_verbal_lexicon | | | | |
| 22_visual_core | | | | |
| 23_asset_behavior | | | | |
| 31_sonic_dna | | | | |
| 41_brand_guidelines | | | | |
| 42_channel_playbook | | | | |

Process: [`templates/00_governance/01_governance_ledger.md`](../../templates/00_governance/01_governance_ledger.md) · Prompt: [`ai/prompts/01_governance_ledger.md`](../../ai/prompts/01_governance_ledger.md)
