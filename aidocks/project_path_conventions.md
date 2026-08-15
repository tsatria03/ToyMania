---
name: project_path_conventions
description: "The src/ (code) + tm/ (assets+launcher) + build/ + releases/ split, the cwd=tm/ trick, and how in-code paths resolve."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania separates code from runtime assets into top-level folders (the SimpleFighter layout):

- **`src/`** — code only. Entry `src/tm.nvgt`, plus `src/includes/` (`includes.nvgt`, `version.nvgt`, and the `main/` subtree — see [[project_include_tree]]). No assets here.
- **`tm/`** — runtime assets + the launcher: `tm/tm.py`, `tm/data/config/` (`keyboard.ini`), `tm/docks/`, `tm/sounds/` (with the sound packs under `tm/sounds/<pack>/`).
- **`build/`** — the build/release pipeline (`tools.py`, `tools.ini`, `version.txt`, `installer.iss`) — see [[project_build_pipeline]].
- **`releases/`** — compiled output + archives (gitignored).

**The cwd trick (the key mechanism):** `tm/tm.py` runs `../src/tm.nvgt` through `C:\nvgt2\nvgt.exe` but sets **cwd = `tm/`**. So two path classes coexist in the code:
- `#include"includes/..."` resolves relative to the **script** → `src/includes/`.
- bare `sounds/...`, `data/...`, `docks/...` strings resolve relative to **cwd** → `tm/`. This is why the sound-pack lookup `"sounds/" + soundpack + "/" + path` resolves under `tm/sounds/` ([[project_sound_pack_system]]).

**No in-code asset path needs to change** for the split — only the launcher's cwd (runtime) and `tools.py`'s asset-copy (build) know about it. There are deliberately **no `#pragma asset`/`#pragma document`** lines (nvgt2 resolves those against the output dir, which was brittle); `tools.py` copies `data/docks/sounds` into the compiled bundle instead. (`#pragma plugin nvgt_curl` stays — a plugin, not an asset.)

**Writable user data** is absolute, unaffected by the split: `DIRECTORY_APPDATA + "tsatria03/ToyMania/..."` (saves/stats/recordings) — see [[project_save_data_layout]].
