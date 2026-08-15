---
name: project_save_data_layout
description: "Writable data: AppData under tsatria03/ToyMania/ (saves/stats/recordings); keyboard.ini rebinds live in tm/data/config/ (cwd-relative, in the bundle)."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Writable player data splits between two places:

**AppData (absolute, unaffected by the layout — [[project_path_conventions]])** under `DIRECTORY_APPDATA + "tsatria03/ToyMania/"`:
- `saves/` — save-slot game state.
- `stats/` — lifetime + session stats.
- `recordings/` — exported audio recordings (see [[project_recording]]).

**In the asset folder (cwd-relative):** `tm/data/config/keyboard.ini` — the user's key rebindings. `setup_keybinds()` reads/writes `configPath + "/keyboard.ini"` where `configPath = "data/config"` (cwd = `tm/`), so this user config lives inside the game's `tm/data/config/` rather than AppData. A default ships there; the player's rebinds overwrite it.

**Shipped read-only assets** stay in the bundle: `tm/sounds/` (the packs — [[project_sound_pack_system]]) and `tm/docks/`. Version is read from `src/includes/version.nvgt` at runtime (the old `docks/version.txt` read was removed).
