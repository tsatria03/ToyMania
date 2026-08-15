---
name: project_audio_model
description: "sound_pool + HRTF spatial audio; all clip lookups route through get_sound() and the sound-pack system; sounds are cwd-relative to tm/."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania has no visual output — everything is screen-reader speech plus HRTF-spatialized audio through NVGT's `sound_pool`. `sound_pool` is vendored in `main/deps/` (it depends on `rotation.nvgt` for `pi`/`calculate_theta` — see [[project_include_tree]]).

**Sound assets live in `tm/sounds/`, organized as sound packs.** Nearly every clip is loaded through **`get_sound()`** (in `main/functions/extrafuncts.nvgt`), which builds the path `"sounds/" + soundpack + "/" + path` — cwd-relative to `tm/` (see [[project_path_conventions]]). The shipped pack is `tm/sounds/default/`. Full detail on the pack system (packs, the `soundpack`/`dlgpack`/`menupack` selectors, modifiable vs. hardcoded folders): **[[project_sound_pack_system]]**.

**Gotchas:**
- The preload cache replays stale audio if you reuse a filename for changed bytes — [[project_nvgt_sound_preload_cache]].
- The game has a **sound-output-device picker**; NVGT's device list has quirky indexing — [[project_sound_device_indexing]].

When a new sound is needed, wire the `get_sound()` call to the intended filename now; the dev adds the `.ogg` to the pack later (don't create dummy files).
