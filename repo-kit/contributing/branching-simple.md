## Branches

This repository works directly on `main` through pull requests.

- `main` is the default branch. No direct pushes: every change goes through a pull request.
- Work on short-lived branches named `<type>/<issue>-<slug>`, where type is `feature`, `fix` or
  `task`: `fix/42-uart-overrun`.
- `Fixes #N` closes the issue as soon as the pull request is merged.
- A release is a tag `vX.Y.Z` on `main` and a GitHub Release with generated notes.
