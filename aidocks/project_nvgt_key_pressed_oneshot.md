---
name: project_nvgt_key_pressed_oneshot
description: "key_pressed() is consumed on first read each frame; read a multi-purpose key once and branch inside, never in two sibling ifs."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

NVGT's `key_pressed()` is a one-shot: it returns true only on the first read of that key each frame and is consumed. So if two sibling `if (key_pressed(KEY_X))` checks both want to act on the same key in one frame, only the first sees it — the second silently never fires.

**Why it bites here:** it looks like two independent handlers for the same key, but the second is dead. This produces "the key sometimes does nothing" bugs that are hard to spot.

**How to apply:** Read a multi-purpose key **once** into a local (`bool x = key_pressed(KEY_X);`) and branch on the local, or nest the logic inside a single `if`. Never gate two separate actions on two separate `key_pressed()` calls for the same key.
