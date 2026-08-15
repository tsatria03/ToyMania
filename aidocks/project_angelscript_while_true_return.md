---
name: project_angelscript_while_true_return
description: "A non-void AngelScript function whose body is a while(true) loop still needs a trailing (unreachable) return after the loop, or it fails to compile with 'Not all paths return a value'."
metadata:
  node_type: memory
  type: reference
  originSessionId: 0a768c3e-c5af-4cd5-bb65-ccc32a83039b
---

AngelScript's flow analysis does NOT recognize that `while (true) { ... }` never falls through, so a non-void function that returns only from inside such a loop still fails to compile:

`ERROR: Not all paths return a value`

Fix: add a trailing `return <dummy>;` after the loop even though it's unreachable. Example (choose_difficulty in `src/includes/main/menus/menu.nvgt`):
```
int choose_difficulty(...)
{
while (true)
{
...
if (...) return -1;
return chosen;
}
return -1; // unreachable, but the compiler requires it
}
```

Same class as [[project_angelscript_braceless_if]] and [[project_angelscript_reserved_words]]: an AngelScript quirk that turns into a compile error, and since the game runs from source a compile error means it won't launch. Applies to any loop the compiler can't prove terminates (while(true), for(;;)). Hit while building the game-unlock menu gating (2026-08-15).
