---
name: project_angelscript_reserved_words
description: "Never name a variable 'out' (or in/inout/shared/final/from…) — reserved keywords are a compile error."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Never name a variable (or parameter) `out` — it's a reserved AngelScript keyword and produces a compile error. Watch the other easy-to-hit reserved words too: `in`, `inout`, `shared`, `final`, `from`, `override`, `explicit`, `property`.

**Why it bites here:** `out` in particular reads like a perfectly natural local variable name, so it slips in and then breaks the build — and a compile error means the game won't launch.

**How to apply:** Pick a non-reserved name (`outp`, `output`, `result`, …) when the natural choice collides. See also [[project_angelscript_braceless_if]].
