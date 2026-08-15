---
name: feedback_check_git_log_for_commits
description: "The dev commits their own work between turns; check git log/status before assuming commit state."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

The dev commits their own work between turns (often several commits you didn't make). Before asking about or assuming the commit state — or before a git operation — check `git log` / `git status` to see what's actually there.

**Why:** Assuming uncommitted work or a particular HEAD when the dev has already committed leads to wrong advice and redundant questions. They manage their own commits.

**How to apply:** Don't commit or push unless explicitly asked (see the global rules). When commit state matters, look it up rather than guessing. Related: [[feedback_stage_commits_before_big_changes]].
