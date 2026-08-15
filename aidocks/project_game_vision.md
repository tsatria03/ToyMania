---
name: project_game_vision
description: "ToyMania is an audio action/arcade game: navigate a toy store, collect toys and keys, fight enemies, and escape before the timer — escalating to a boss chase; plus an endless mode."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania is a single-player, audio-only **action/arcade** game. You navigate a toy store on a 2D coordinate grid: collect toys, find keys, defeat enemies, and race a timer to escape the store. Difficulty escalates across levels — cars, guards, and eventually a chasing **boss** at level 6.

**Load-bearing systems (the game's identity):**
- **Modes:** Normal (level-based, timed escape → boss chase) and an **Endless/arcade "toy collector"** mode with a shop, money, and an expanded 100×100 grid. A time-based "toy defender" mode is also referenced.
- **Combat/entities:** melee weapons + two ammo-based artillery weapons (pistol/machine gun); darts for stunning; the entity classes live in `main/globals/` (`toy`, `key`, `door`, `boss`, `guard`, `car`, `dart`, `thief`, `bullet`, `healzone`, `item`, `bodyfall`).
- **Mechanics:** inventory items, platforms, healing zones, doors needing a randomized key count, an alarm system, and a store-damage mechanic.
- **Accessibility/UX:** extensive rebindable keys ([[project_save_data_layout]]), TTS/speech config, HRTF 3D audio + per-channel volume, a "learn game sounds" menu, achievements (life + session), and the swappable **sound-pack system** ([[project_sound_pack_system]]).
- **Utilities:** built-in audio **recording** ([[project_recording]]) and an auto **update checker** ([[project_updater]]).

Single-player — no multiplayer (only `nvgt_curl` HTTP for update checks; an online scoreboard is an unimplemented TODO). A shipped Mac version exists. It's a solo hobbyist project; expect occasional spelling quirks.
