---
type: example
title: Email Rewrite Sample
description: Before/after sample for writing-standard email edit.
timestamp: 2026-07-12
---

# Example: Status Email Rewrite

## Input

**Subject:** Update

Hi team,

I hope you're doing well. I wanted to reach out to provide a quick update on the Season 2 pitch package. We've been making really good progress over the past few weeks and the team has been working hard to ensure everything goes smoothly. We believe we'll be able to complete the package in the near future. There are a few areas that still need some attention but overall things are looking positive. Please let me know if you have any questions or concerns.

Thanks!

## Expected issues

1. Weak subject ("Update")
2. Throat-clearing opener
3. Vague progress ("really good", "near future")
4. No specific data, owner, or deadline
5. Passive/implied ask

## Output shape (abbreviated)

**Subject:** Season 2 Pitch Package: 68% Complete, Blocker on Faction Names

The pitch package is 68% complete (17 of 25 assets in the matrix). We hit a blocker on faction naming in `12_lore_canon`; Morgan owns the fix, target date March 14.

Remaining work: 8 assets, estimated 2 weeks if naming resolves by Friday. [DATA NEEDED: final partner review date for the PDF one-pager.]

Three actions:
- Morgan: propose three faction name options by Friday EOD
- Art: pause merch mockups until accent palette sign-off
- Producer: approve extended review window for March 15 partner send
