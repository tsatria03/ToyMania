---
name: project_player_facing_bugs
description: "Known player-facing bugs deferred (not fixing right now): cross-mode state bleed between toy collector and toy defender — leftover level-6 store explosion / game-over dialog in defender, and defender thieves stealing toys in the collector."
metadata:
  node_type: memory
  type: project
  originSessionId: 0a768c3e-c5af-4cd5-bb65-ccc32a83039b
---

Player-facing bugs the dev is aware of but has chosen NOT to fix yet. Verify each (re-locate by symbol) before acting; don't fix unless asked ([[feedback_confirm_before_implementing]]). Internal/code-level bugs live in [[project_deferred_code_bugs]].

## Cross-mode state bleed between toy collector and toy defender

**Shared root cause.** The two menu launchers in `src/includes/main/menus/menu.nvgt` each reset ONLY their own mode's variables, not the other mode's. The in-game "play again?" restart paths in `game.nvgt` are thorough (destroy every entity type + reset every cross-mode flag + timers), but the menu launchers are partial and asymmetric:
- Collector launcher (`menu.nvgt` block `gamem2 == "ty"`, ~L295-366): never clears defender state — no `store_defense=false`, no `thievespawn=false`, no `destroy_all_thieves()`, no `defense_timed=false`; also doesn't destroy leftover cars/gards/bosses/keys/objs/toys (only `destroy_all_healzones()` + `destroy_all_doors()`).
- Defender launcher (`menu.nvgt` block `gamem2 == "ty2"`, ~L368-433): never clears collector progression — `level` is NOT reset (stays wherever it ended, e.g. 6), plus `boss_timer`, `alarm_started`, `countdown_started`, `small_storedest`, `medium_storedest`, `bossespawn`, `carspawn`, `gardspawn`, `keyspawn`, `objspawn`; also doesn't destroy leftover collector entities.

**Amplifier (independent structural bug).** The level-progression blocks and the level-6 store-explosion + escape-failure sequence in `game.nvgt` (the `if (!endless && level == 6)` at ~L819, and the level 1-5 timers) are NOT gated on `!store_defense`. So a non-endless defender game that inherited `level==6` will run the collector's store-destruction and game-over.

### Symptom 1 — collector's store explosion / game-over dialog appears in the toy defender (FULLY TRACED, reproducible)
Play toy collector, reach level 6, exit. Launch the TIMED toy defender (sets `endless=false`, leaves `level==6`). The ungated level-6 block fires inside the defender game: store gets damaged, countdown/alarm play, and eventually the "store turned to ashes" escape-failure game-over dialog shows — even though you're playing defender. This is the "store explodes from the collector game" + "collector's game-over dialog shows up" report.

### Symptom 2 — defender's thieves steal toys in the collector (mechanism identified, exact everyday trigger unconfirmed)
Because the collector launcher never resets `store_defense`/thieves, any residual defender state carries into the collector and `thiefloop()` keeps running (thieves target `toys[]` and increment `stolen_toys`; see `thief.nvgt`). Concrete leak paths that leave `store_defense=true` + live thieves on exit: the spawner `return` bail-out ([[project_deferred_code_bugs]] #1, which returns out of `toygame()` with no cleanup) and the health-death block (`game.nvgt:~1046`, which doesn't reset `store_defense` or call `destroy_all_thieves()`). The normal defender exits (quit ~L83-93, stolen>max ~L1152-1156, timed-expiry ~L1207-1211) DO clean up, so this couldn't be reproduced through those in current code — the dev's exact repro steps would pin the path.

### Suggested fix (one idea covers all symptoms)
1. Give both menu launchers a COMPLETE, symmetric reset — mirror the thorough in-game restart (destroy ALL entity types + reset ALL cross-mode flags + all timers). Best factored into a shared `reset_game_state()` helper both launchers (and the in-game restarts) call, to stop the two lists drifting apart again.
2. Belt-and-suspenders: gate the level-progression and level-6 blocks in `game.nvgt` on `!store_defense` so collector-only logic can never run during a defender game.

Confirmed against source on 2026-08-14. Symptom 1 fully traced; symptom 2 mechanism identified, exact trigger pending dev repro.
