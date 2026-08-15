---
name: project_include_tree
description: "src/includes/ layout: version.nvgt + main/{deps,functions,globals,menus}, wildcard glob aggregation, vendored stdlib helpers (incl. rotation), #pragma plugin nvgt_curl. No parsers folder."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Entry `src/tm.nvgt` does `#include"includes/includes.nvgt"`. `src/includes/` holds `includes.nvgt` (aggregator) and `version.nvgt` at the top level; everything else lives under **`main/`**:

- **`main/deps/`** — vendored stdlib/helper scripts + shared UI: `bgt_compat`, `instance`, `keyhook`, `sound_pool`, `rotation`, `audioutils`, `datetime`, `file_contents`, `input_conf`, `recording`, `size`, `form`, `speech`, `custom_menu`, `dlg`, `buffer`, `savedata`, `virtual_dialogs`.
- **`main/functions/`** — `extrafuncts` (holds `get_sound`, `getver`, `restart`), `savefuncts`.
- **`main/globals/`** — the entity/world classes and systems: `dec` (globals), `game`, `gametime`, `inventory`, `achievments`, `updater`, `weapons`, `bullet`, and the entities `toy`, `key`, `door`, `boss`, `guard`, `car`, `dart`, `thief`, `bodyfall`, `healzone`, `item`, `platform`.
- **`main/menus/`** — `menu`.
- **No `parsers/` folder** — ToyMania has no data-table parsers (its content is not table-driven like the sibling games); the folder was removed.

**Aggregation is by wildcard glob.** `includes.nvgt` is `#pragma plugin nvgt_curl`, then `#include"version.nvgt"`, then `#include"main/deps/*"`, `#include"main/functions/*"`, `#include"main/globals/*"`, `#include"main/menus/*"` (**no `main/parsers/*`** line). A new file in a `main/<subdir>/` is auto-included. There are **no bare stdlib includes and no `#pragma asset/document`** lines (the stdlib helpers are vendored into `main/deps/` and picked up by the deps glob).

**Vendoring gotcha:** a vendored helper's own `#include` resolves against its folder (`main/deps/`), NOT the engine include path. `sound_pool.nvgt` does `#include "rotation.nvgt"` and needs `rotation.nvgt` (defines `pi`/`calculate_theta`) present in `main/deps/` — it's vendored there. If you vendor another engine helper, bring its transitive includes too. Engine + the nvgt_curl plugin: [[project_engine_pinned_nvgt2]].
