---
name: feedback_menus_say_canceled
description: "Every menu/input escape, Back, or No path speaks 'canceled' for audible feedback."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Every menu or input-box path that backs out — escape, a Back option, or a No answer — must speak `"canceled"` so the player gets audible confirmation that nothing happened.

**Why:** Without a spoken cue, a screen-reader player can't tell whether an escape registered or the game hung. "canceled" closes the loop.

**How to apply:** When adding a menu or input flow, wire `speak("canceled")` (or the game's equivalent) into every cancel/back/No branch. Related UI conventions: [[feedback_yes_no_menu_labels]].
