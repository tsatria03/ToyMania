---
name: feedback_confirm_before_implementing
description: "Treat every design discussion as a question needing explicit go-ahead, never a commission to start editing."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Treat every design discussion as a question requiring an explicit go-ahead — never a commission. "I really wish X" / "what if we did Y" / "could we extend Z" / "I have an idea" are explorations, not instructions. Lay out the design, call out tradeoffs, ask for the go-ahead, then stop and wait. Anything ending in `?` is a request for a plan, not a green light to edit.

**Why:** This dev's default workflow is to describe an idea first and then say "go ahead." Starting to edit off a design discussion — or fanning out into adjacent files unprompted — produces unwanted changes they then have to unwind. The rule rests on instruction-following alone.

**How to apply:** Respond to a proposal with a plan and a question, not a diff. Only edit after an explicit "yes / do it / go ahead." See [[feedback_ask_one_question_at_a_time]].
