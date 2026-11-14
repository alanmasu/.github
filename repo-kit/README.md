# Repository kit

Files that are **not** inherited from this `.github` repository. Copy them into the
repositories that need them.

| File | Copy to | Purpose |
|---|---|---|
| `contributing/` | repository root | `CONTRIBUTING.md` template and modules, see [contributing/README.md](contributing/README.md) |
| `.github/workflows/on-develop.yml` | `.github/workflows/` | `on develop` label for fixes merged into `develop` |
| `.github/workflows/on-develop-with-project.yml` | `.github/workflows/` | Same, plus project Status (use instead of the previous one) |
| `.github/workflows/project-auto-add.yml` | `.github/workflows/` | Adds new issues and pull requests to a project |
| `.github/dependabot.yml` | `.github/` | Weekly updates of the actions used by the workflows |
| `.github/release.yml` | `.github/` | Categories for generated release notes |
| `kicad.gitignore`, `rtl.gitignore` | append to `.gitignore` | Files that must not be committed |

Workflows that use a project need the `PROJECT_TOKEN` secret (classic PAT with the `project`
scope, plus `repo` for private repositories).
