---
name: feedback_update_build_version_txt
description: "build/version.txt is the single source of truth; bump only it with each changelog block. version.nvgt is generated — never hand-edit it."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

`build/version.txt` is the single source of truth for the version number. Bump only it, alongside each new changelog block ([[feedback_changelog_rules]]). It is mirrored into `src/includes/version.nvgt` automatically — by the launcher (`tm/tm.py`) on every run and by `build/tools.py` at compile — so **never hand-edit `version.nvgt`**; your edit would be overwritten anyway.

**Why:** One source of truth avoids drift between the running game's reported version and the release. The old scheme read the version from a `docks/version.txt` at runtime via `getver()`; that was removed in favor of the generated `version.nvgt`.

**How to apply:** Change `build/version.txt`, add the matching changelog block, done. The running game picks it up on the next launch. Details: [[project_build_pipeline]].
