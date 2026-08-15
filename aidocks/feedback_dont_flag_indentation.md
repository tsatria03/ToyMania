---
name: feedback_dont_flag_indentation
description: "AngelScript ignores indentation; don't flag uneven whitespace or spend effort reformatting it."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

NVGT/AngelScript ignores indentation entirely — code compiles regardless of whitespace. Don't call out uneven or unusual indentation after edits, and don't spend turns reformatting it. Much of this codebase is written flush-left or inconsistently on purpose; that is not a bug.

**Why:** Indentation cleanup is cosmetic here and the dev has parked it; flagging it is noise, and a bulk reformat pass is unwanted churn.

**How to apply:** Match the surrounding style loosely, keep your own additions readable, and move on. A formatting pass happens only if the dev explicitly asks.
