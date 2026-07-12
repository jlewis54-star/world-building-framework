#!/usr/bin/env python3
"""Canon version and project inheritance checks."""
from __future__ import annotations

import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
GOV = ROOT / "world/00_governance/01_governance_ledger.md"
WORLD = ROOT / "world"
PROJECTS = ROOT / "projects"

errors: list[str] = []
warnings: list[str] = []


def err(msg: str) -> None:
    errors.append(msg)


def warn(msg: str) -> None:
    warnings.append(msg)


def read(path: Path) -> str:
    return path.read_text(encoding="utf-8")


def frontmatter_field(text: str, field: str) -> str | None:
    m = re.search(rf"^{field}:\s*(.+)$", text, re.MULTILINE)
    return m.group(1).strip() if m else None


def governance_version() -> str | None:
    if not GOV.is_file():
        err("missing world/00_governance/01_governance_ledger.md")
        return None
    text = read(GOV)
    m = re.search(r"^\|\s*CANON_VERSION\s*\|\s*([^\|]+)\|", text, re.MULTILINE)
    if m:
        return m.group(1).strip()
    return frontmatter_field(text, "canon_version")


def world_type() -> str | None:
    if not GOV.is_file():
        return None
    text = read(GOV)
    m = re.search(r"^\|\s*World type\s*\|\s*([^\|]+)\|", text, re.MULTILINE)
    if not m:
        return None
    val = m.group(1).strip().lower()
    for token in ("fiction", "brand", "creator_ip", "ttrpg"):
        if token in val.replace(" ", "_").replace("-", "_"):
            return token
    return val.split()[0] if val and val != "_fill_" else None


def profile_filled() -> bool:
    if not GOV.is_file():
        return False
    text = read(GOV)
    name = re.search(r"^\|\s*World name\s*\|\s*([^\|]+)\|", text, re.MULTILINE)
    if not name or "_fill_" in name.group(1):
        return False
    wt = re.search(r"^\|\s*World type\s*\|\s*([^\|]+)\|", text, re.MULTILINE)
    if not wt or "_fill_" in wt.group(1):
        return False
    return True


def check_world_frontmatter(gov_ver: str) -> None:
    for path in sorted(WORLD.rglob("*.md")):
        if path.name == "README.md":
            continue
        text = read(path)
        cv = frontmatter_field(text, "canon_version")
        if cv and cv != gov_ver:
            rel = path.relative_to(ROOT)
            warn(f"{rel}: canon_version {cv} != governance CANON_VERSION {gov_ver}")


def check_skipped_docs() -> None:
    skip_ids = {
        "23_asset_behavior": "world/20_identity/23_asset_behavior.md",
        "31_sonic_dna": "world/30_sensory/31_sonic_dna.md",
        "41_brand_guidelines": "world/40_brand/41_brand_guidelines.md",
        "42_channel_playbook": "world/40_brand/42_channel_playbook.md",
    }
    gov_text = read(GOV) if GOV.is_file() else ""
    for doc_id, rel in skip_ids.items():
        path = ROOT / rel
        if not path.is_file():
            continue
        text = read(path)
        status = frontmatter_field(text, "status")
        if status != "skipped":
            continue
        has_reason = "reason:" in text.lower() or doc_id in gov_text
        if not has_reason:
            warn(f"{rel}: status skipped but no reason in doc or Skip Registry")


def check_projects(gov_ver: str) -> None:
    if not PROJECTS.is_dir():
        return
    for proj_md in sorted(PROJECTS.glob("*/PROJECT.md")):
        text = read(proj_md)
        inherits = frontmatter_field(text, "inherits_canon")
        rel = proj_md.relative_to(ROOT)
        if inherits and inherits != gov_ver:
            warn(f"{rel}: inherits_canon {inherits} != governance CANON_VERSION {gov_ver}")
        hook = text
        if len(hook) > 800 and "12_lore_canon" not in hook:
            warn(f"{rel}: long hook without 12_lore_canon citation (possible lore paste)")


def check_git_tag(gov_ver: str) -> None:
    tag = f"canon/v{gov_ver.lstrip('v')}"
    try:
        subprocess.run(
            ["git", "rev-parse", tag],
            cwd=ROOT,
            capture_output=True,
            check=True,
        )
    except (subprocess.CalledProcessError, FileNotFoundError):
        warn(f"git tag {tag} not found (optional until first canon bump)")


def main() -> int:
    if not profile_filled():
        warn("governance World Profile incomplete (expected for fresh clone)")

    gov_ver = governance_version()
    if not gov_ver:
        err("could not parse CANON_VERSION from governance ledger")
    else:
        check_world_frontmatter(gov_ver)
        check_projects(gov_ver)
        check_git_tag(gov_ver)

    check_skipped_docs()

    for w in warnings:
        print(f"WARNING: {w}", file=sys.stderr)
    for e in errors:
        print(f"ERROR: {e}", file=sys.stderr)

    if errors:
        return 1
    print("Canon version check passed (see warnings above if any).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
