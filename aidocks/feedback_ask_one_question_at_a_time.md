---
name: feedback_ask_one_question_at_a_time
description: "When clarifying, ask ONE question per turn and wait; don't batch a numbered list of questions."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

When you need to clarify a plan or a decision, surface exactly ONE question per turn and wait for the answer before asking the next. Don't batch several questions into a numbered list or a multi-question prompt.

**Why:** The dev reviews and answers by screen reader; a wall of several questions at once is hard to work through linearly, and they've explicitly asked for one at a time. (A multi-question `AskUserQuestion` prompt was rejected mid-session for exactly this reason.)

**How to apply:** Pick the single highest-leverage question, ask it, wait. If you have a recommendation, state it so a one-word answer suffices.
