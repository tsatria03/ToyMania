---
name: project_deferred_code_bugs
description: "Known internal code bugs found by review but intentionally deferred (not fixing right now): the toygame() spawner return crash-out and the per-step writedata() disk churn."
metadata:
  node_type: memory
  type: project
  originSessionId: 0a768c3e-c5af-4cd5-bb65-ccc32a83039b
---

Running list of confirmed internal code bugs the dev is aware of but has chosen NOT to fix yet. Verify each still exists (re-locate by symbol) before acting; don't fix any of these unless the dev asks ([[feedback_confirm_before_implementing]]).

## 1. `toygame()` spawner guards `return` out of the whole game loop — FIXED 2026-08-14
In `src/includes/main/globals/game.nvgt`, inside `toygame()`'s `while(true)` loop, the key/obj/toy spawners bailed with `return;` when the sound-pack category folder was empty (`keytypes`, `objtypes`, `toytypes` in the main loop, and the store-defense `toytypes` one-liner). Because these `return`s lived directly in `toygame()` (no wrapping helper), an empty `find_directories(...)` result didn't skip that one spawn tick — it exited the entire game loop and silently dumped the player back to the menu mid-session. Only triggered if a (custom) sound pack was missing a category folder, which is why it went unnoticed on the default pack.

FIX APPLIED: all four sites rewritten from an early `if (types.length() == 0) return;` to a positive guard `if (types.length() > 0) { <random_string + spawn_* + spawntimer.restart()> }`, so an empty folder now skips only that spawn tick and the game loop continues. The `spawntimer.restart()` stays inside the guard (matches the original — only restarts after a successful spawn), so an empty folder re-checks `find_directories` each tick; harmless on the default pack, and only a broken custom pack would hit it.

## 1b. `random_string()` empty-array crash on `find_directories()` spawn sites — FIXED 2026-08-14
Same empty-folder class as #1, but a HARDER failure: `random_string()` (`extrafuncts.nvgt:427`) did `array[random(0, array.length()-1)]` with no empty guard, so `random_string(find_directories(...))` on a missing folder was an index-out-of-bounds runtime crash. Affected 7 NPC/door spawn sites that pass a `find_directories(...)` result straight into `random_string()`: `boss.nvgt:55-56` (boss summons a guard), and in `game.nvgt` the endless door (~L612), boss (~L702), car (~L708), guard (~L717), level-6 door (~L802), and thief (~L1132). `random_string()` on hardcoded arrays (`game.nvgt:577`, `900`; `weapons.nvgt:85`) and `find_directories()` walked with `for` loops (`door.nvgt`, `inventory.nvgt`, menu pack/item selectors) were never at risk.

FIX APPLIED (both layers, dev picked "both"):
- Layer 1 (safety net): `random_string()` now `if (array.length() == 0) return "";` at the top — kills the crash class for every current and future caller.
- Layer 2 (no broken entities): each of the 7 spawn sites wrapped in `if (type.length() > 0) { spawn_* + timer.restart() }` (braces for the timer-loop spawners; braceless single-statement `if` for the two one-shot door spawns and the boss-summon, whose following statement must always run). Without layer 2, layer 1 would turn a crash into a silently-spawned soundless entity. Only triggers on an incomplete custom pack; the default pack has every folder.

## 2. `writedata()` called on every footstep (lower priority)
Each of the 8 movement blocks in `game.nvgt` (tap + held, ~L467-556) calls `update_achievements()` then `writedata()`. `writedata()` (`src/includes/main/functions/savefuncts.nvgt:89`) rebuilds a ~20-key dictionary plus every achievement tier and calls `sd.save()` (serialize + encrypt + disk write); `update_achievements()` loops all achievements. So every single step does a full encrypted save-file write — even though `savedata_timer`/`save_interval` (5000ms, `game.nvgt:693-697`) already persists periodically. Redundant disk churn on fast-walk holds; probably harmless in practice. Fix would be to drop the per-step `writedata()` and rely on the timer (+ save on notable events).

Status as of 2026-08-14: #1 and #1b FIXED. #2 still open (dev deferred it).
