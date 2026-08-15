---
name: project_build_pipeline
description: "build/tools.py pipeline (commit tools + compile → package → release → website), the tm.py launcher, version mirroring, the nvgt_curl plugin + LAME dependency, and config."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

No test suite or linter. Running and building are scripted but manual; **the dev runs them, not Claude** ([[feedback_dont_run_or_build_the_game]]).

**Launcher — `tm/tm.py`:** runs `../src/tm.nvgt` under `C:\nvgt2\nvgt.exe` with cwd = `tm/` (the [[project_path_conventions]] cwd trick), `CREATE_NO_WINDOW`, hides its own console, and watches ~5s for an early compile-error exit → writes `tm/errors.txt` (+ a popup) on failure, otherwise detaches. An absent/empty `errors.txt` means "no errors." It mirrors `build/version.txt` → `src/includes/version.nvgt` before launch, preserving the file's line ending.

**Release — `build/tools.py`** (via `build/tools.bat`, or 5 flag args non-interactively). Interactive menu = commit tools (commit / undo / push / history / create-tag) + release stages:
- **compile:** mirror version into `version.nvgt`, run `nvgt -c -Q tm.nvgt` from `src/` (bundle lands in `src/tm`), copy `data`,`docks`,`sounds` from `tm/` into the bundle, move it to `releases/windows/ToyMania_windows_portable_password_is_<pw>/tm`.
- **package:** a password-protected 7z portable archive **and** an Inno Setup installer (`build/installer.iss` via ISCC).
- **release:** `gh release create`, attaching archive + installer.
- **website:** `site_updater.ps1` updates the github.io page **and writes the site's `version.txt`** — which ToyMania's in-game updater reads to detect new versions ([[project_updater]]).

**External deps:** the game declares `#pragma plugin nvgt_curl` (updater) and uses **LAME** to encode recordings to MP3 ([[project_recording]]); those need to be present with the engine/build. **Config:** per-repo `build/tools.ini` (`[game]`/`[installer]`/`[site]`); shared tool paths (`nvgt`, `sevenzip`, `gh`, `iscc`) in `~/.game_tools/tools.ini`. Version source of truth is `build/version.txt` ([[feedback_update_build_version_txt]]).
