#!/usr/bin/env python3
"""Validate YAML frontmatter on ai/prompts and ai/agents flat files."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

PROMPT_REQUIRED = {"doc_id", "description", "when", "target", "post_draft", "type"}
AGENT_REQUIRED = {"name", "description", "type"}


def parse_frontmatter(text: str) -> dict[str, str]:
    if not text.startswith("---"):
        return {}
    m = re.match(r"^---\n(.*?)\n---", text, re.DOTALL)
    if not m:
        return {}
    block = m.group(1)
    data: dict[str, str] = {}
    for line in block.splitlines():
        if ":" not in line:
            continue
        key, _, val = line.partition(":")
        data[key.strip()] = val.strip()
    return data


def check_file(path: Path, required: set[str], label: str) -> list[str]:
    text = path.read_text(encoding="utf-8")
    fm = parse_frontmatter(text)
    missing = required - set(fm.keys())
    if missing:
        return [f"{path}: missing frontmatter keys: {', '.join(sorted(missing))}"]
    return []


def main() -> int:
    errors: list[str] = []

    for p in sorted((ROOT / "ai/prompts").glob("*.md")):
        if p.name == "_shared_constraints.md":
            continue
        errors.extend(check_file(p, PROMPT_REQUIRED, "prompt"))

    for p in sorted((ROOT / "ai/agents").glob("*.md")):
        errors.extend(check_file(p, AGENT_REQUIRED, "agent"))

    if errors:
        for e in errors:
            print(f"ERROR: {e}", file=sys.stderr)
        return 1

    print("AI frontmatter check passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
