---
name: feedback_list_modified_files
description: "End every file-editing turn with an explicit 'Files changed:' list of bare filenames."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

End every turn in which you edited files with an explicit **"Files changed:"** list naming each touched file. Bare filenames (or repo-relative paths) are enough — one per line.

**Why:** The dev reviews changes via screen reader and relies on that list to know exactly what to re-read, commit, and (if applicable) relaunch. Silent edits are easy to miss.

**How to apply:** After the edits, before signing off, print the list. Follow it with a note on whether the game must be relaunched to see the change (interpreted `.nvgt` edits need a relaunch; `data/`/`docks/` asset edits usually don't).
