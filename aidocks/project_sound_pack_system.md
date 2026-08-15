---
name: project_sound_pack_system
description: "Swappable sound packs under tm/sounds/<pack>/; get_sound() routes 'sounds/'+soundpack+'/'+path; soundpack/dlgpack/menupack default 'default'; packs enumerated via find_directories."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania supports **user-swappable sound packs** (a feature the sibling games don't have). A pack is a folder under `tm/sounds/<pack>/`; the shipped one is `default`. Three independent selectors — `soundpack`, `dlgpack`, `menupack` (declared in `main/globals/dec.nvgt`, default `"default"`) — let the player theme game sounds, dialog, and menus separately.

**Routing:** all pack audio goes through `get_sound()` (`main/functions/extrafuncts.nvgt`), which returns `"sounds/" + soundpack + "/" + path`. Available packs are discovered at runtime with `find_directories("sounds/...")` (used across `menu.nvgt`, `boss.nvgt`, `door.nvgt`, etc.), so dropping a new pack folder in makes it selectable — no code change.

**Modifiable vs. hardcoded:** the readme documents which pack folders players may customize and which are deliberately fixed (balance/gameplay-critical clips). Respect that split when adding or moving clips.

**How to apply:** reference new clips through `get_sound()` (never a bare `sounds/...` path that skips the pack), keep new clip names inside the pack layout, and update `tm/docks/readme.txt` (the customization reference) when the set of modifiable clips changes ([[feedback_dock_line_length_1024]]). Audio model overview: [[project_audio_model]].
