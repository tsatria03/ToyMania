---
name: feedback_claudemd_length
description: "Keep CLAUDE.md under 40,000 characters; move detail into aidocks memory files."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Keep `CLAUDE.md` a lean dispatcher under 40,000 characters. When a section grows past a few lines of real detail, move that detail into an `aidocks/` memory file and leave a `[[name]]` pointer in its place.

**Why:** CLAUDE.md is loaded every session; bloating it wastes context and buries the orientation. The memory files are loaded on demand, so detail belongs there.

**How to apply:** CLAUDE.md carries "what this is / layout / running" plus a trigger per load-bearing rule. Everything deeper is a `[[memory]]`. Add a one-line pointer to [[MEMORY]] for every new memory file.
