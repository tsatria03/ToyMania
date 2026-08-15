---
name: feedback_verify_code_while_fixing
description: "Re-locate by symbol not stored line number, confirm a reported finding is actually true, and flag adjacent bugs."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

When fixing something, read the surrounding code carefully first: re-locate the target by symbol name (not a remembered line number — they drift), confirm the reported finding's claims are actually true before patching, and catch/flag adjacent errors you notice rather than blindly patching only the reported spot.

**Why:** The dev runs and verifies builds, so a wrong or half-right edit ships and costs a round-trip. Line numbers in a report or memory go stale as files change; a "fix" applied to the wrong or a misunderstood site is worse than none.

**How to apply:** Grep for the symbol, read the real code, verify the claim, then edit. If the surrounding code has a related problem, mention it instead of silently ignoring or silently "fixing" it.
