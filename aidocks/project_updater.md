---
name: project_updater
description: "In-game update checker (main/globals/updater.nvgt) using the nvgt_curl plugin: fetches the site's version.txt, compares to the running version, offers portable/installer downloads."
metadata:
  node_type: memory
  type: project
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

ToyMania checks for updates over HTTP using the **`nvgt_curl`** plugin (declared `#pragma plugin nvgt_curl` — [[project_include_tree]]). The logic is in `main/globals/updater.nvgt`:

- `check_for_updates()` does `url_get(version_url)` where `version_url = "https://tsatria03.github.io/projects/games/ToyMania/version.txt"`, and compares the fetched string to the running version (`version`, from `src/includes/version.nvgt`).
- It guards against non-version responses (empty, or an HTML error page) before treating the value as a version.
- On a newer version it offers the download (portable vs. installer) from the GitHub release.

**Load-bearing link:** the remote `version.txt` it reads is the one the **release pipeline's website step writes** (`build/tools.py` → `site_updater.ps1`) — see [[project_build_pipeline]]. So bumping `build/version.txt` and running the website update is what makes the in-game checker see a new release. If the website step is skipped, the checker stays stale even though a release exists.
