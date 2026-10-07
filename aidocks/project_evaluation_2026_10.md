---
name: project_evaluation_2026_10
description: "Full-game evaluation (2026-10-06): verified OPEN bugs (pause-quit No still quits, ingame flag leak, key double-count, dart/bullet direction, thief freeze, stun-by-type, replay state leak, playtime undercount) + design notes. None fixed yet."
metadata:
  type: project
---

Whole-codebase evaluation done 2026-10-06 (read every gameplay/menu file; deps/ skimmed). Everything below was verified against source but is **NOT fixed** — the dev hasn't picked what to fix yet ([[feedback_confirm_before_implementing]]). Re-locate by symbol before acting ([[feedback_verify_code_while_fixing]]); move items to FIXED here as they land. Earlier fixed bugs live in [[project_deferred_code_bugs]] / [[project_player_facing_bugs]].

## Bugs (verified)
1. **Pause-menu quit "No" still quits** — `pausemenu()` "qmg" branch reads `m.get_item_id(mres)` (the pause-menu index, 3) instead of `confirmres`; `custom_menu` is 1-based so id(3) on a 2-item Yes/No menu is "", never "no". Only Escape cancels. Same wrong-var pattern in the "vds" branch (harmless there).
2. **`ingame` never cleared on 3 exits** — door win (`doorloop`), level-6 timeout "No" (`toygame`, the `mainmenu()` after the replay block), pause-menu quit. Stale `ingame=true` makes settings menus act in-game from the main menu: device/pack/test controls hidden, Cancel/OK call `resume_game()` and `return` into `preffsmenu()`'s loop with a reset form.
3. **Door keys double-counted (time trial)** — `keyloop` does `give(key,1)` AND `collected_keys+=1`; `doorcheck` sums `collected_keys + inventory keys`, so the door opens at ~half `required_keys`, while the Shift info key (collected_keys only) still says more are needed. Locked message also says "need <required> more" instead of the missing count.
4. **Stun darts don't move when facing forward/backward** — `facing` is left/right/forward/backward; `dartloop` only handles right/left/up/down.
5. **Stun hits every entity of the same sound type** — `stun_target()` matches by `cartype`/`gardtype` string, not the struck instance.
6. **Car bullets: vertical inverted + range 0** — `carloop` labels dy>0 "down" but bullet "down" does `bully--` (away; up = +y per movement code). `spawn_bullet(..., 0, 0, ...)` → range check removes the bullet after its first step, so car fire only lands within ~2-3 tiles.
7. **Thieves freeze permanently** — `thief.target` is an index into `toys`; when toys shrink below it, `thiefloop` neither moves nor resets it to -1 (only assigns when target==-1). Removals also silently retarget other thieves.
8. **In-game replays skip `reset_game_state()`** — level-6 timeout / defense replays hand-reset a subset; `carnum`/`gardnum` (10/20 from late levels) leak into the replay, so replays are harder. `reset_game_state()`'s header comment claims in-game restarts call it — they don't.
9. **Playtime undercounted** — `session_playtime`/`total_playtime` only accrue on death (`toygame`) and door win; level-6 timeout and both defense endings add nothing (affects Time Traveler achievement).
10. **Store can explode during the door escape** — `doorloop` auto-walk to (0,0) can take ~10s while `boss_timer` keeps running; timeout during `doormove` = loss after "escaping".

## Design notes (not bugs; raise as questions)
- Time-trial menu text says "defeat the final boss" but `doorcheck` never checks `bossdefeated` — boss is optional.
- Melee/guns hit a rectangle in all directions (`fire_on_target`); `facing` only matters for darts.
- Store HP is cosmetic (no consequence). Endless level 6 drops caps (cars 10→1, guards 20→3, toys 50→5) then regrows — intentional?
- Achievements: 50 tiers × 1.5 growth; tiers past ~20 unreachable and late thresholds overflow int (harmless in practice).
- Architecture: menus/game navigate by unbounded recursion (mainmenu→toygame→mainmenu…); end-of-game reset logic is copy-pasted ~6 times — root cause of #2 and #8. Suggested direction: one `end_game()` path + `reset_game_state()` everywhere.
- Player-facing typos: "Grate work!" (door win), "Could not fined" (dockread), "intire" (sound-pack picker).
