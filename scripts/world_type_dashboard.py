#!/usr/bin/env python3
"""World-type dashboard: required / recommended / skipped / stale."""
from __future__ import annotations

import re
from datetime import datetime, timedelta
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GOV = ROOT / "world/00_governance/01_governance_ledger.md"

PROFILES = {
    "fiction": {
        "required": ["11_manifesto", "12_lore_canon"],
        "recommended": ["21_verbal_lexicon", "22_visual_core", "23_asset_behavior", "51_mood_vault", "52_anti_library"],
        "skip_ok": ["31_sonic_dna", "41_brand_guidelines", "42_channel_playbook"],
    },
    "brand": {
        "required": ["11_manifesto", "12_lore_canon", "21_verbal_lexicon", "22_visual_core", "23_asset_behavior", "41_brand_guidelines", "42_channel_playbook"],
        "recommended": ["31_sonic_dna", "51_mood_vault", "52_anti_library"],
        "skip_ok": ["31_sonic_dna"],
    },
    "creator_ip": {
        "required": ["11_manifesto", "12_lore_canon", "21_verbal_lexicon", "22_visual_core", "41_brand_guidelines", "42_channel_playbook"],
        "recommended": ["23_asset_behavior", "31_sonic_dna", "51_mood_vault", "52_anti_library"],
        "skip_ok": ["31_sonic_dna"],
    },
    "ttrpg": {
        "required": ["11_manifesto", "12_lore_canon"],
        "recommended": ["21_verbal_lexicon", "22_visual_core", "51_mood_vault", "52_anti_library"],
        "skip_ok": ["23_asset_behavior", "31_sonic_dna", "41_brand_guidelines", "42_channel_playbook"],
    },
}

DOC_PATHS = {
    "11_manifesto": "world/10_foundations/11_manifesto.md",
    "12_lore_canon": "world/10_foundations/12_lore_canon.md",
    "21_verbal_lexicon": "world/20_identity/21_verbal_lexicon.md",
    "22_visual_core": "world/20_identity/22_visual_core.md",
    "23_asset_behavior": "world/20_identity/23_asset_behavior.md",
    "31_sonic_dna": "world/30_sensory/31_sonic_dna.md",
    "41_brand_guidelines": "world/40_brand/41_brand_guidelines.md",
    "42_channel_playbook": "world/40_brand/42_channel_playbook.md",
    "51_mood_vault": "world/50_vault/51_mood_vault.md",
    "52_anti_library": "world/50_vault/52_anti_library.md",
}


def parse_world_type(text: str) -> str | None:
    """Return a single chosen type, or None for unset / stub / multi-option cells."""
    m = re.search(r"^\|\s*World type\s*\|\s*([^\|]+)\|", text, re.MULTILINE)
    if not m:
        return None
    val = m.group(1).strip().lower()
    if not val or val == "_fill_" or "/" in val:
        # Stub e.g. "fiction / brand / creator_ip / ttrpg" is not a choice.
        return None
    normalized = val.replace("-", "_").replace(" ", "_")
    if normalized in PROFILES:
        return normalized
    return None


def doc_status(path: Path) -> str:
    if not path.is_file():
        return "missing"
    text = path.read_text(encoding="utf-8")
    m = re.search(r"^status:\s*(.+)$", text, re.MULTILINE)
    if m:
        return m.group(1).strip()
    fill_n = text.count("_fill_")
    if fill_n:
        return f"draft-empty ({fill_n} _fill_)"
    return "unknown"


def main() -> None:
    if not GOV.is_file():
        print("Governance ledger not found.")
        return
    text = GOV.read_text(encoding="utf-8")
    wt = parse_world_type(text)
    if not wt or wt not in PROFILES:
        print("World type not set. Choose one of: fiction | brand | creator_ip | ttrpg")
        return
    prof = PROFILES[wt]
    print(f"World type: {wt}\n")
    for label, ids in [("Required", prof["required"]), ("Recommended", prof["recommended"]), ("Skip OK", prof["skip_ok"])]:
        print(f"## {label}")
        for doc_id in ids:
            rel = DOC_PATHS.get(doc_id, doc_id)
            path = ROOT / rel
            st = doc_status(path)
            flag = ""
            if st.startswith("draft-empty") and doc_id in prof["required"]:
                flag = " <- BLOCKER"
            elif st == "skipped" and doc_id in prof["required"]:
                flag = " <- WARN: required but skipped"
            print(f"  {doc_id}: {st}{flag}")
        print()


if __name__ == "__main__":
    main()
