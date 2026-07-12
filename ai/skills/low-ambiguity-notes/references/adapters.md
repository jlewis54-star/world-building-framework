# Adapters (low-ambiguity-notes)

Core procedure is tool-agnostic. Bindings below are optional per environment.

## Default (chat)

- **Input:** user pastes transcript or uploads text in chat
- **Output:** markdown in chat; user saves file manually
- **Omit:** external system writes (CRM, calendar, tickets) unless an adapter is configured

## This repo

- Notes are not canon. Promotion path: [`playbook/notes-to-canon.md`](../../../../playbook/notes-to-canon.md).
- Suggested scratch locations: [`examples/scratch/`](../../../../examples/scratch/), private notes vault, branch, or chat export. Do not invent a second bible under `world/`.
- If promoting: name the target thin stub path (`world/...`) and leave `status: draft` for human sign-off.

## Obsidian (optional)

If an Obsidian CLI or vault adapter is available:

- Write note to user-specified vault path
- Ask for folder before write (do not assume a default tree)

## Omit path

When adapter missing: output markdown in chat with filename as first line. Say: "Save to your vault at [suggested path]."
