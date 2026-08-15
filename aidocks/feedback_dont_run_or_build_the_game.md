---
name: feedback_dont_run_or_build_the_game
description: "Never launch or compile the game; the dev runs and verifies builds. Read-only inspection is fine."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Never launch or compile ToyMania yourself — not `tm/tm.py`, not `build/tools.py`, not `nvgt -c`. Make the edits, report them, and stop. The dev runs the launcher and builds/verifies releases.

**Why:** The game runs from source, so the dev is the one who exercises it and catches compile/runtime issues; an AI-triggered build or launch is noise at best and can leave stray processes/artifacts. Read-only inspection (Read/Grep) is always fine.

**How to apply:** When a change needs verifying, hand it back with a clear "relaunch to test" note (see [[feedback_list_modified_files]]) rather than running anything. Related: [[project_build_pipeline]], [[project_path_conventions]].
