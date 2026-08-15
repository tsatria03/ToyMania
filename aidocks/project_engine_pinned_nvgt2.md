---
name: project_engine_pinned_nvgt2
description: "ToyMania runs on the pinned legacy NVGT fork at C:\\nvgt2 (BASS audio); upstream C:\\nvgt (miniaudio) is incompatible — don't target it or suggest upgrading."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

The game is pinned to the **legacy NVGT fork at `C:\nvgt2\nvgt.exe`** (BASS audio). The launcher `tm/tm.py` and `build/tools.py` both use it. A newer stock NVGT at `C:\nvgt` (miniaudio) exists only for testing other people's games — **do not target it or treat upstream NVGT as authoritative**, and don't suggest upgrading the engine.

**Why:** ToyMania depends on behavior specific to the nvgt2 fork; upstream NVGT changed the audio backend and other internals and is incompatible.

**Consequences to watch:**
- The interpreted relaunch (`restart()` in `main/functions/extrafuncts.nvgt`) must run `c:\nvgt2\nvgtw.exe` with the script path `../src/tm.nvgt` (cwd is `tm/`), never bare `tm.nvgt` and never `c:\nvgt`.
- The nvgt2 stdlib includes live under `C:\nvgt2` and in the source mirror at `misc\Legacy-NVGT\release\include`; several helper scripts are vendored into `src/includes/main/deps/` (see [[project_include_tree]]).
- ToyMania declares `#pragma plugin nvgt_curl` (used by the updater — [[project_updater]]); that plugin ships with the nvgt2 install.
