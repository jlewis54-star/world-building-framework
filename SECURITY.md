# Security

Report security issues in this framework repo. Do not open public issues for exploitable findings.

## Report a vulnerability

**Preferred:** GitHub private vulnerability reporting.

1. Open the repo on GitHub.
2. Click **Security** (top tab).
3. Click **Report a vulnerability** (or **Advisories** → **Report**).
4. Describe impact, reproduction steps, and affected paths.

If private reporting is unavailable, email the repo owner via the contact listed on their GitHub profile. Do not paste exploit details in public issues or PR comments.

## Response expectations

- Acknowledgment within 7 days for valid reports.
- Fix or documented mitigation before public disclosure when possible.
- Credit in release notes if you want it (optional).

## In scope

- Leaked secrets in committed files or history
- CI/workflow misconfigurations that allow unauthorized write or secret exfiltration
- Scripts under `scripts/` with command injection or unsafe handling of untrusted input
- Validation bypass that could merge broken or malicious markdown into protected paths

## Out of scope

- Fictional lore disputes or creative disagreements in `examples/`
- Social engineering against individual contributors
- Issues in third-party tools (Cursor, GitHub, ripgrep) unless this repo's integration is the root cause
- Missing features or documentation gaps (use a docs issue instead)

## Safe disclosure rules for reporters

- Do not include live API keys, passwords, or session tokens in issues or PRs.
- Do not test against production systems you do not own.
- Minimize data access when demonstrating a flaw.

## Maintainer hygiene

- Enable secret scanning and push protection: [`playbook/public-repo-governance.md`](playbook/public-repo-governance.md).
- Never commit `.env`, `.pem`, or `.cursor/mcp.json` (listed in [`.gitignore`](.gitignore)).
- Rotate any credential accidentally pushed. Assume git history retains it until scrubbed.
