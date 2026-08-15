---
name: project_sound_device_indexing
description: "NVGT's sound-output-device list is index 0 'No sound', 1 'Default', 2+ named; when building the device picker, don't add a synthetic Default item."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania has a **sound-output-device picker** (in the settings menus). NVGT's `get_sound_output_devices()` returns a list where **index 0 is "No sound"** and **index 1 is "Default"**, with real named devices at index 2+. Common handling is to strip index 0 (so the presented list starts at "Default") and store the chosen index offset accordingly.

**Why it bites:** if you rebuild or extend the device menu, it's easy to (a) add your own "Default" entry on top of the one already at index 1, giving two Defaults, or (b) mismatch the stored index against the trimmed list so the wrong device is selected on next launch.

**How to apply:** work with the list NVGT gives you — don't inject a synthetic "Default" item, and keep the stored-index math consistent with however the current code trims index 0. Verify against the existing device-menu code before changing it ([[feedback_verify_code_while_fixing]]).
