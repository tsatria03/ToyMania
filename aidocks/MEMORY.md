# ToyMania memory index

The `[[name]]` links in `CLAUDE.md` and across these memories resolve to `aidocks/<name>.md`. Add a one-line pointer here for every new memory. "Memory" / "memories" always means this folder.

## Project — what the game is and how it's built
- [Game vision](project_game_vision.md) — audio action/arcade: navigate a toy store, collect toys + keys, fight enemies, escape before the timer (boss chase at level 6); plus an endless mode; the load-bearing systems.
- [Sound-pack system](project_sound_pack_system.md) — swappable packs under tm/sounds/<pack>/; get_sound() routes 'sounds/'+soundpack+'/'+path; soundpack/dlgpack/menupack; find_directories enumerates; modifiable vs hardcoded folders.
- [Updater](project_updater.md) — in-game update checker (updater.nvgt) via nvgt_curl; fetches the site's version.txt (written by the release website step) and offers portable/installer downloads.
- [Recording](project_recording.md) — built-in audio recorder (recording.nvgt): device selection, MP3 via LAME, saved to AppData recordings/ (default Alt+R).
- [Path conventions](project_path_conventions.md) — src/ (code) + tm/ (assets+launcher) + build/ + releases/ split; the cwd=tm/ trick; no #pragma asset (tools.py copies assets); nvgt_curl plugin stays.
- [Include tree](project_include_tree.md) — src/includes/ = version.nvgt + main/{deps,functions,globals,menus} (NO parsers); wildcard glob aggregation; vendored stdlib helpers incl. rotation; #pragma plugin nvgt_curl.
- [Build pipeline](project_build_pipeline.md) — tm.py launcher + build/tools.py (commit tools + compile→package→release→website); version mirroring; nvgt_curl + LAME deps; tools.ini + ~/.game_tools/tools.ini config.
- [Audio model](project_audio_model.md) — sound_pool + HRTF; all clips via get_sound() + the sound-pack system; tm/sounds/<pack>/.
- [Save-data layout](project_save_data_layout.md) — AppData tsatria03/ToyMania/ (saves/stats/recordings); keyboard.ini rebinds live in tm/data/config/ (in the bundle).
- [Repo hygiene](project_repo_hygiene.md) — .gitattributes CRLF enforcement + binary rules; releases/ gitignored; stale .claude/ removed; CLAUDE.md + aidocks/ committed.
- [Engine pinned to nvgt2](project_engine_pinned_nvgt2.md) — runs on the legacy fork at C:\nvgt2 (BASS); upstream C:\nvgt (miniaudio) incompatible; don't target it or suggest upgrading.
- [Deferred code bugs](project_deferred_code_bugs.md) — internal bugs: toygame() spawner `return` crash-out (FIXED) and the wider random_string() empty-array crash on find_directories spawn sites, hardened helper + 7 guarded NPC/door spawners (FIXED 2026-08-14); per-step writedata() disk churn removed, now relies on the 5s timer + event saves (FIXED 2026-08-14). All tracked internal bugs fixed.
- [Player-facing bugs](project_player_facing_bugs.md) — cross-mode state bleed between collector and defender (FIXED, shipped v5.2): fixed via a shared reset_game_state() helper both menu launchers call + gating the level/level-6 blocks on !store_defense; file kept as a record of the class and the shared-reset design.

## NVGT / AngelScript gotchas — these cause compile failures or subtle bugs
- [AngelScript braceless if](project_angelscript_braceless_if.md) — a braceless if/else governs one statement; a second orphans the else → compile error.
- [AngelScript reserved words](project_angelscript_reserved_words.md) — never name a variable `out` (or in/inout/shared/final/from…); reserved keyword → compile error.
- [NVGT key_pressed one-shot](project_nvgt_key_pressed_oneshot.md) — key_pressed() is consumed on first read each frame; read a multi-purpose key once and branch inside.
- [NVGT sound preload cache](project_nvgt_sound_preload_cache.md) — sound.load caches by filename; reusing a name for changed audio replays the old clip; use a fresh name or allow_preloads=false.
- [Sound device indexing](project_sound_device_indexing.md) — device list is index 0 "No sound", 1 "Default", 2+ named; don't add a synthetic Default item in the picker.

## Feedback — how the dev wants you to work
- [Confirm before implementing](feedback_confirm_before_implementing.md) — a design discussion or any `?` is a request for a plan, not a green light to edit; wait for explicit go-ahead.
- [Ask one question at a time](feedback_ask_one_question_at_a_time.md) — surface ONE question per turn and wait; don't batch a numbered list.
- [List modified files](feedback_list_modified_files.md) — end every editing turn with a bare-filename "Files changed:" list; then note whether a relaunch is needed.
- [Don't run or build the game](feedback_dont_run_or_build_the_game.md) — never launch/compile (tm.py, tools.py, nvgt -c); edit and report, the dev runs and verifies.
- [Verify code while fixing](feedback_verify_code_while_fixing.md) — re-locate by symbol not line number, confirm the finding is true, flag adjacent bugs.
- [Check git log for commits](feedback_check_git_log_for_commits.md) — the dev commits between turns; check git log/status before assuming commit state; don't commit unless asked.
- [Stage commits before big changes](feedback_stage_commits_before_big_changes.md) — flag a commit break point before a risky stage so safe pieces land first.
- [CLAUDE.md length limit](feedback_claudemd_length.md) — keep CLAUDE.md a dispatcher under 40,000 chars; move detail into memory files.
- [Changelog rules](feedback_changelog_rules.md) — docks/changelog.txt: player-facing prose, reverse-chronological, a record not a manual; bump version.txt with each block.
- [Dock line length 1024](feedback_dock_line_length_1024.md) — keep every line in tm/docks/ at or under 1024 chars; the screen reader splits longer lines.
- [One-sentence game messages](feedback_one_sentence_game_messages.md) — in-game spoken feedback is exactly one sentence; no trailing advice.
- [Menus say canceled](feedback_menus_say_canceled.md) — every menu/input escape/Back/No path speaks "canceled".
- [Yes/no menu labels](feedback_yes_no_menu_labels.md) — label items exactly Yes/No (Yes first); context goes in the prompt.
- [Multiline comment style](feedback_multiline_comment_style.md) — multi-line comments use one /* */ block, not stacked //.
- [Don't flag indentation](feedback_dont_flag_indentation.md) — AngelScript ignores indentation; don't flag whitespace or reformat.
- [No CRLF normalization](feedback_no_crlf_normalization.md) — don't run a manual normalizer; preserve each file's ending on edit; .gitattributes + git handle it.
- [Update build/version.txt](feedback_update_build_version_txt.md) — version.txt is the single source of truth; never hand-edit the generated version.nvgt.
