---
name: project_nvgt_sound_preload_cache
description: "sound.load caches decoded audio by filename; reusing a name for changed audio replays the old clip. Use a fresh name or allow_preloads=false."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

NVGT caches decoded audio by filename in a preload cache. If you load a sound, then regenerate or replace the file at the **same path** and load it again, NVGT replays the **old** cached clip, not the new audio.

**Why it bites here:** any feature that writes a file and immediately plays it back under a reused name will silently play stale audio. It looks like the write failed when it didn't.

**How to apply:** Use a unique/fresh filename for regenerated audio, or load with `allow_preloads=false` so the cache is bypassed. Static shipped sounds (the `tm/sounds/` tree) are fine — this only affects sounds whose bytes change under a fixed name. See [[project_audio_model]].
