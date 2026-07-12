#!/usr/bin/env python3
"""Project folder validation beyond markdown link checks."""
from __future__ import annotations

import os
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
errors: list[str] = []


def fail(msg: str) -> None:
    errors.append(msg)


def check_projects() -> None:
    projects = ROOT / "projects"
    if not projects.is_dir():
        return
    for proj_dir in sorted(projects.iterdir()):
        if not proj_dir.is_dir():
            continue
        proj_md = proj_dir / "PROJECT.md"
        if not proj_md.is_file():
            continue
        text = proj_md.read_text(encoding="utf-8")
        rel = proj_md.relative_to(ROOT)
        for pat in ("^## Purpose", "^## AI Prompt", "^## Review Checklist"):
            if re.search(pat, text, re.MULTILINE):
                fail(f"{rel}: scaffold section leaked ({pat})")
        checklist = proj_dir / "shipping_checklist.md"
        if checklist.is_file():
            ct = checklist.read_text(encoding="utf-8")
            status = re.search(r"^status:\s*(.+)$", text, re.MULTILINE)
            if status and status.group(1).strip() not in ("draft", "skipped"):
                if re.search(r"^\|\s*Result\s*\|\s*\|\s*$", ct, re.MULTILINE):
                    fail(f"{proj_dir.name}/shipping_checklist.md: Result empty for non-draft project")


def changed_demo_world_files() -> list[Path]:
    names: set[str] = set()
    for cmd in (
        ["git", "diff", "--name-only", "HEAD"],
        ["git", "diff", "--cached", "--name-only"],
        ["git", "ls-files", "--others", "--exclude-standard"],
    ):
        try:
            r = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, check=False)
            names.update(r.stdout.splitlines())
        except FileNotFoundError:
            return []
    return [ROOT / n for n in names if n.startswith("examples/demo-world/world/") and (ROOT / n).is_file()]


def check_demo_world_edits(changed_only: bool) -> None:
    if os.environ.get("ALLOW_DEMO_EDIT") == "1":
        return
    if not changed_only:
        return
    for p in changed_demo_world_files():
        fail(
            f"{p.relative_to(ROOT)}: demo-world edit detected; "
            "edit root world/ instead or set ALLOW_DEMO_EDIT=1"
        )


def main() -> int:
    changed = "--changed" in sys.argv
    check_projects()
    check_demo_world_edits(changed)
    for e in errors:
        print(f"ERROR: {e}", file=sys.stderr)
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
