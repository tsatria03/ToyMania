---
name: feedback_one_sentence_game_messages
description: "In-game spoken feedback messages are exactly one sentence; no trailing advice sentence."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

In-game feedback messages (things the game speaks to the player) are exactly **one sentence**. Don't append a second sentence of advice or instruction.

**Why:** The game is played by ear; a tight one-sentence message is quick to hear and doesn't talk over the next action. A trailing "you should now do X" sentence is noise.

**How to apply:** State the result in one sentence and stop. If the player needs guidance, that belongs in the docks/readme, not in a runtime message.
