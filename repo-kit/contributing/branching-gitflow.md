## Branches

This repository keeps a `develop` branch for integration; `main` holds released versions.

| Branch | Purpose | From | Merged into |
|---|---|---|---|
| `main` | Released versions, default branch. No direct pushes. | - | - |
| `develop` | Finished work waiting for the next release. Changes only through pull requests. | `main` | `main` at release |
| `feature/<issue>-<slug>` | A feature | `develop` | `develop` |
| `fix/<issue>-<slug>` | A bug fix | `develop` | `develop` |
| `task/<issue>-<slug>` | A task (refactor, docs, CI ...) | `develop` | `develop` |
| `hotfix/<issue>-<slug>` | Urgent fix to a released version | `main` | `main`, then `main` into `develop` |

- Branch names are lowercase with `-`, and start with the issue number: `fix/42-uart-overrun`.
- Pull requests target `develop`; only hotfixes target `main`.
- When a fix reaches `develop`, its issues get the `on develop` label; they are closed when
  `develop` is merged into `main`.
- A release is a merge of `develop` into `main` (merge commit, not squash), followed by a tag
  `vX.Y.Z` on `main` and a GitHub Release with generated notes.
