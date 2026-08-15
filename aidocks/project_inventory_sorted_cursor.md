---
name: project_inventory_sorted_cursor
description: "Inventory invariant: the invpos cursor indexes the ALPHABETICALLY SORTED key list; every place that turns invpos back into an item must sort too, because inv.get_keys() alone returns unordered dictionary order."
metadata:
  node_type: memory
  type: project
  originSessionId: 0a768c3e-c5af-4cd5-bb65-ccc32a83039b
---

The player's inventory lives in a `dictionary inv` (`src/includes/main/globals/inventory.nvgt`), keyed by item name (items are stored name-only via `give(toytype2/keytype2, 1)` — no category). `cycle_inv()` (bound to the in-game inventory-cycle key, i.e. "tab") sorts the keys with `sort_ascending()`, advances the global `invpos`, and announces the item at that position in the SORTED list.

INVARIANT: `invpos` is a cursor into the alphabetically sorted key list. `dictionary.get_keys()` returns keys in unspecified (hash/insertion) order, NOT sorted. So any code that does `inv.get_keys()[invpos]` reads a DIFFERENT item than the one `cycle_inv` announced.

Bug this caused (FIXED 2026-08-14): pressing the use/read key (enter) after cycling with tab read the WRONG item's description, because `game.nvgt`'s `item_use` handler called `useitem(inv.get_keys()[invpos])` on the unsorted list while `cycle_inv` had set `invpos` against the sorted list. The item descriptions on disk (each item's `equipments/items/.../<name>/info.tmf`) were correct; only the index mapping was wrong. The inventory MENU path (`invmenu` in `menu.nvgt`) was never affected — it matches by item name, not by index.

FIX: added `string[] sorted_inv_keys()` in `inventory.nvgt` (get_keys + sort_ascending) and routed every invpos-to-item site through it: `cycle_inv`, `useitem`'s `invpos = ...find(current)`, `getitem` (dead code but fixed for consistency), and `game.nvgt` `item_use`. Rule going forward: never index `inv.get_keys()` with `invpos` directly — always use `sorted_inv_keys()`.
