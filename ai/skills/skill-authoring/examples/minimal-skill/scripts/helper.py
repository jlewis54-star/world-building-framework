# scripts/helper.py
# Reusable code the skill calls via platform script runner.
#
# Guidelines:
# - One function per concern (fetch, transform, render)
# - Print output the agent needs (stdout only in many runners)
# - Accept inputs via CLI flags or env vars (non-interactive)
# - Pin deps inline (PEP 723 for Python) or document prerequisites
# - Run: uv run scripts/helper.py --help

def example_function(data: dict) -> dict:
    """Process data and return result."""
    return {"processed": True, "input_keys": list(data.keys())}


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Example skill helper")
    parser.add_argument("--dry-run", action="store_true", help="Validate without side effects")
    args = parser.parse_args()
    if args.dry_run:
        print('{"status": "ok", "mode": "dry-run"}')
    else:
        print('{"status": "ok", "message": "Replace with your logic"}')
