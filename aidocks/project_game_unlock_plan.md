---
name: project_game_unlock_plan
description: "Finalized design (not yet implemented) for locking sub-games behind play-count gates: Time Trial always open, Endless Arcade after 3 Time Trials, Timed Defense after 5 Collector games, Endless Defense after 3 Timed Defense games."
metadata:
  node_type: memory
  type: project
  originSessionId: 0a768c3e-c5af-4cd5-bb65-ccc32a83039b
---

IMPLEMENTED 2026-08-15 (all 5 sections built; shipped in v5.2). See [[project_game_vision]] for mode structure. This file now doubles as the record of how it was built.

## Implementation status
- S1 (data): 8 persisted ints in dec.nvgt (`*_completed`, `*_max_difficulty`) + save/load in savefuncts.nvgt. DONE.
- S2 (increments): `record_game_completion()` in game.nvgt, called from the 5 completion end-states (health death, level-6 escape-fail, endless-defense stolen, timed-defense timer, both door wins in door.nvgt). Not on Escape-quit. DONE.
- S3 (gating): unlock helpers in game.nvgt (`endless_arcade_unlocked` >=3 TT, `defender_unlocked` >=5 Collector, `endless_defense_unlocked` >=3 TD, `difficulty_unlocked`); `choose_difficulty()` in menu.nvgt (Layer-2 ladder, re-prompts on locked pick); modemenu/ty/ty2 gated. DONE.
- S4 (veteran migration): `bool unlocks_migrated` + `migrate_unlocks()` in game.nvgt, called in tm.nvgt after readdata(). If a save has history (`total_moved_steps>0 || total_playtime>0 || total_collected_toys>0`) but no unlock data, it seeds all `*_completed=100` and `*_max_difficulty=5` so pre-update veterans keep full access; genuinely new saves ramp normally. Idempotent via the flag. DONE.
- S5 (docks): added a "Game modes" section to tm/docks/readme.txt (the readme had none) covering the 2 games, 4 sub-modes, and all unlock rules; plus 3 changelog entries under New in 5.2. DONE.
NOTE: `choose_difficulty()` needs a trailing unreachable `return -1;` after its `while(true)` — see [[project_angelscript_while_true_return]].

## What gets locked
Lock layers:
- Layer 0 — MAIN-GAME gate (Toy Defender only): the whole Toy Defender main game is locked until you've completed 5 Toy Collector games TOTAL (either Collector sub-mode counts, in any mix). Toy Collector itself is never locked. This is the "before unlocking the other main game" gate the dev asked for.
- Layer 1 — sub-game gate: within an unlocked main game, can you enter this sub-mode? (Collector: Time Trial always / Endless Arcade after 3 Time Trials. Defender: once the Defender main game is unlocked, Timed Defense is playable immediately / Endless Defense after 3 Timed Defense games.)
- Layer 2 — difficulty ladder (tracked PER SUB-MODE): once a sub-mode is unlocked, which of its 5 difficulties (Easy..Chaos / gamemod 1..5) can you pick? Easy always; each next tier unlocks after 1 completed game of the tier below IN THAT SAME sub-mode. Ladders are per sub-mode and independent — climbing Time Trial's ladder does NOT unlock difficulties in Endless Arcade or the Defender modes; each starts fresh at Easy when it unlocks.

## Unlock tree
- Toy Collector (main game) — ALWAYS unlocked.
  - Time Trial (endless=false) — ALWAYS unlocked. The teacher mode.
  - Endless Arcade (endless=true) — unlock after 3 completed Time Trial games.
- Toy Defender (main game) — LOCKED until 5 completed Collector games total (Time Trial + Endless Arcade combined, either counts).
  - Timed Defense (store_defense + defense_timed) — playable as soon as the Defender main game unlocks (no extra sub-gate).
  - Endless Defense (store_defense + endless) — unlock after 3 completed Timed Defense games.
Natural chains: Time Trial -> Endless Arcade; (5 Collector games) -> Toy Defender / Timed Defense -> Endless Defense.
No dead zone: when Defender opens at 5 Collector games, Timed Defense is immediately playable.

Defender gate mix: the 5 Collector games can be ANY mix of Time Trial and Endless Arcade (5 Time Trial alone works; 3 Time Trial + 2 Endless Arcade works; etc.). The mix is unconstrained EXCEPT by the upstream Endless Arcade gate (needs 3 Time Trials), so you always play at least 3 Time Trials before any Endless Arcade can count — i.e. Defender can never be unlocked with fewer than 3 Time Trial games.

## Trigger: what counts as "completed"
Reaching ANY end state — win, loss, timer-out, thieves-too-many — but NOT an Escape quit. This is the one rule that works uniformly across all 4 modes, because the two Endless modes (Endless Arcade, Endless Defense) have NO win state (they only end in death/overwhelm; see the mode endings). Excluding Escape-quits prevents launch-and-bail farming.

## Difficulty ladder per sub-mode (Layer 2)
Applies inside every unlocked sub-mode, each with its OWN independent ladder:
- Easy — always open
- Medium — after 1 completed Easy game (this sub-mode)
- Hard — after 1 completed Medium game (this sub-mode)
- Insane — after 1 completed Hard game (this sub-mode)
- Chaos — after 1 completed Insane game (this sub-mode)
Menu readout example (Time Trial difficulty menu, fresh): "Medium. Locked. Unlocked after completing 1 easy time trial game." Once Easy is completed, Medium becomes playable; etc.

## UX
All layers: locked items still APPEAR in their menu with the requirement spoken, never hidden. Main-game example: "Toy defender. Locked. Unlocked after completing 5 toy collector games." Sub-mode example: "Endless arcade. Locked. Unlocked after completing 3 time trial games." Difficulty example: "Hard. Locked. Unlocked after completing 1 medium time trial game."

## Implementation notes (for when we build it)
- Persisted data is light: PER SUB-MODE store (a) a completion count and (b) highest difficulty completed (0..5). 4 sub-modes x 2 values = 8 values. No per-difficulty counters needed — each ladder step only needs 1 game.
  - completion counts feed the gates: Time Trial count -> Endless Arcade (>=3); Collector count = Time Trial + Endless Arcade -> Toy Defender MAIN game (>=5); Timed Defense count -> Endless Defense (>=3). Timed Defense has no gate of its own beyond the Defender main-game gate.
  - highest-difficulty-completed per sub-mode drives that mode's Layer-2 ladder: difficulty D is unlocked iff D==1 (Easy) or highest_completed >= D-1.
- No existing per-mode games-played counter today; add these to the settings/stats save (survive across sessions), alongside the existing total_* stats in dec.nvgt.
- Increment BOTH the count and (if gamemod > highest_completed) the highest-difficulty on the completion end-states in game.nvgt (death / timer-out / stolen>max / level-6 escape-fail / door win), NOT in the Escape-quit path.
- Gate the menu items in menu.nvgt: Layer 0 on the "toy defender" item in the top mode menu (modemenu); Layer 1 on the Endless Arcade item in the `ty` sub-mode menu (Timed Defense in `ty2` no longer needs its own gate); Layer 2 in the shared difficulty menu (needs to know which sub-mode is being launched so it can read that mode's ladder + requirement wording). When locked, block selection with a spoken requirement or append " Locked." to the label.
- Counts are just constants — trivially tunable after playtest; dev prefers erring low.
