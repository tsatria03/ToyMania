---
name: feedback_multiline_comment_style
description: "Multi-line code comments use one /* */ block, not stacked // lines; single-line stays //."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Write multi-line code comments as a single `/* ... */` block, not several stacked `//` lines. A single-line comment still uses `//`.

**Why:** It's the dev's preferred style and reads more cleanly, especially through a screen reader that would announce each `//` separately.

**How to apply:** When a comment runs more than one line, wrap it in one `/* */`. Leave existing single-line `//` comments alone.
