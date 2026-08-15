---
name: project_recording
description: "Built-in audio recorder (main/deps/recording.nvgt): device selection, MP3 export via LAME, saved to the AppData recordings/ folder (default hotkey Alt+R)."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania has a **built-in audio recorder** (`main/deps/recording.nvgt`) so players can capture their sessions. It supports choosing the capture device (see the device-indexing gotcha [[project_sound_device_indexing]]), encodes to **MP3 via LAME**, and writes files to the AppData `recordings/` folder ([[project_save_data_layout]]). The default toggle is **Alt+R**.

**Why it matters here:** LAME is an external dependency the build/runtime must provide ([[project_build_pipeline]]); recording touches the sound-device layer, so changes there interact with the device picker.

**How to apply:** treat recording as an isolated utility subsystem — when editing it, keep the device-selection handling consistent with the rest of the sound-device code, and don't assume LAME is optional (MP3 export depends on it).
