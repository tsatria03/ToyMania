---
name: feedback_stage_commits_before_big_changes
description: "Proactively flag a commit break point before a large/risky change so safe pieces land first."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Before a large or risky stage, proactively flag a commit break point so the safe, finished pieces get committed on their own and the big change stays isolated in its own commit.

**Why:** It keeps the history reviewable and makes the risky change easy to revert without losing the good work around it. The dev commits their own work ([[feedback_check_git_log_for_commits]]) but appreciates being told when a natural break point has arrived.

**How to apply:** When you're about to start something big, say so and suggest committing what's done first — then proceed once they've had the chance.
