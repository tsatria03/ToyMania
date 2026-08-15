---
name: feedback_no_crlf_normalization
description: "Don't run a manual CRLF normalizer pass; .gitattributes + git handle line endings. Preserve each file's existing ending on edit."
metadata:
  node_type: memory
  type: feedback
  originSessionId: 9c2aa66a-3d36-4ec3-8742-42265704afb7
---

Don't run a manual line-ending normalizer over the tree. When you edit a file, preserve its existing line ending (this repo is a mix of LF and CRLF per file). Line-ending policy is declared in `.gitattributes` and applied by git at commit time — see [[project_repo_hygiene]].

**Why:** A blind normalizer pass flips endings on files you didn't mean to touch, producing huge noisy diffs and fighting the `.gitattributes` policy. The sanctioned way to standardize is `git add --renormalize` per the `.gitattributes` rules, not an ad-hoc script.

**How to apply:** For surgical edits that must preserve endings, prefer byte-level edits that keep the file's current ending. `.gitattributes` now pins `*.nvgt/.py/.txt/.bat/.ps1/.md/.ini` to CRLF; a one-time `git add --renormalize .` is the dev's call to make.
