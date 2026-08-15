---
name: project_angelscript_braceless_if
description: "A braceless if/else governs only ONE statement; adding a second into a braceless branch orphans the else → compile error → game won't launch."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

In AngelScript a braceless `if`/`else` governs exactly **one** statement. If you add a second statement into a braceless branch (very common when extending a menu dispatch or an event handler), the following `else` is orphaned and the file fails to compile — and because the game runs from source, a compile error means it **won't launch at all**.

**Why it bites here:** the codebase uses braceless branches heavily in dispatch chains. Dropping one extra line into what looks like a normal block silently changes the control flow's shape.

**How to apply:** When adding a statement to any `if`/`else` branch, wrap the branch in `{ }` first. Related compile-breakers: [[project_angelscript_reserved_words]], [[project_nvgt_key_pressed_oneshot]].
