---
name: project_repo_hygiene
description: ".gitattributes enforces CRLF on code/data files (with binary rules); releases/ gitignored; the stale .claude/ was removed; CLAUDE.md + aidocks/ are committed."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

**Line endings:** `.gitattributes` uses `* text=auto` plus explicit `text eol=crlf` on `*.sif *.nvgt *.py *.txt *.bat *.ps1 *.md *.ini` — code/data files are pinned to CRLF so NVGT's parsers and the AngelScript compiler always see Windows endings. Binary types (`*.dat/*.exe/*.ogg/*.mp3/*.wav/*.zip`) are marked binary. The working tree is still a per-file LF/CRLF mix from before this policy (ToyMania leans mostly LF); a one-time `git add --renormalize .` is the dev's call to flip existing files. Don't run a manual normalizer — [[feedback_no_crlf_normalization]].

**Gitignored:** `releases/` (compiled output + archives). The `*.ini` ignore was removed so `build/tools.ini` commits.

**History note:** the repo used to have a `.claude/settings.local.json` with stale pre-reorg paths (`github/ToyMania/includes`); it was removed. If a `.claude/` reappears, it's machine-local config, not project docs.

**Committed on purpose:** `CLAUDE.md` and the whole `aidocks/` folder (this memory store) are committed — they travel with the repo.
