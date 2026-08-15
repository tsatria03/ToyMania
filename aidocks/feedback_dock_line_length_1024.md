---
name: feedback_dock_line_length_1024
description: "Keep every line in the player-facing docks (tm/docks/) at or under 1024 characters."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Keep every line in the player-facing docks — `tm/docks/readme.txt`, `changelog.txt`, `credits.txt`, `todo_list.txt` — at or under 1024 characters.

**Why:** The dev (and players) read the docks through a screen reader that splits longer lines mid-thought, which garbles the reading. Paragraph breaks keep it legible.

**How to apply:** Break long paragraphs into shorter lines/paragraphs when writing or editing any dock file.
