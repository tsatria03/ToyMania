---
name: feedback_yes_no_menu_labels
description: "Label yes/no menu items exactly 'Yes' and 'No' (Yes first); context goes in the prompt, not the labels."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

For a yes/no menu, label the two items exactly `"Yes"` and `"No"`, with **Yes first**. Put all the context in the question/prompt line, never in the option labels.

**Why:** Short, predictable labels are fast to hear and consistent across the game; a screen-reader player learns "Yes is first." Verbose labels ("Yes, delete my save") slow every read.

**How to apply:** Question line carries the meaning ("Are you sure you want to delete this save?"); the two items are just Yes / No. Cancel/escape still speaks "canceled" ([[feedback_menus_say_canceled]]).
