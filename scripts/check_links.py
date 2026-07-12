#!/usr/bin/env python3
"""Resolve relative markdown links from repo markdown files."""
from __future__ import annotations

import re
import sys
from pathlib import Path
from urllib.parse import unquote

ROOT = Path(__file__).resolve().parent.parent
LINK_RE = re.compile(r"\[[^\]]*\]\(([^)]+)\)")


def is_external(target: str) -> bool:
    return target.startswith(("http://", "https://", "mailto:", "#"))


def resolve_link(source: Path, target: str) -> Path | None:
    target = unquote(target.strip())
    if not target or is_external(target):
        return None
    target = target.split("#", 1)[0]
    if not target:
        return None
    if target.startswith("/"):
        resolved = ROOT / target.lstrip("/")
    else:
        resolved = (source.parent / target).resolve()
    return resolved


def main() -> int:
    errors: list[str] = []
    for arg in sys.argv[1:]:
        source = (ROOT / arg).resolve()
        if not source.is_file():
            continue
        text = source.read_text(encoding="utf-8")
        for match in LINK_RE.finditer(text):
            target = match.group(1)
            if target in ("path", "text"):
                continue
            resolved = resolve_link(source, target)
            if resolved is None:
                continue
            try:
                resolved.relative_to(ROOT)
            except ValueError:
                rel_source = source.relative_to(ROOT)
                errors.append(f"{rel_source}: link escapes repo: {target}")
                continue
            if not resolved.exists():
                if target.endswith("/"):
                    if (resolved / "README.md").is_file() or (resolved / "PROJECT.md").is_file():
                        continue
                rel_source = source.relative_to(ROOT)
                errors.append(f"{rel_source}: broken link: {target}")
    if errors:
        for err in errors:
            print(f"ERROR: {err}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
