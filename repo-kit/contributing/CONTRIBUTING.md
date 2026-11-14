# Contributing

Thanks for contributing! These are the rules for this repository. Read the general rules first;
the sections after them are specific to this repository.

Contents: [Issues](#issues) · [Bug, feature or task?](#bug-feature-or-task) · [Labels](#labels) ·
[Commits](#commits) · [Pull requests](#pull-requests) · [Versions](#versions)

---

## Issues

- **Search first.** Comment on an existing issue instead of opening a duplicate.
- **One problem per issue.** Two bugs are two issues, even if they were found together.
- **Use a template** when one fits (blank issues are allowed) and delete the sections that do not apply.
- **Title**: keep the prefix the template puts in (`bug(fw): `, `feat: `, `task: ` ...) and
  describe the problem, not the solution: `bug(hw): U3 footprint pins 4 and 5 swapped`.
- **Be reproducible.** Versions, commands, measurements and logs are worth more than long
  descriptions.
- Security problems are **not** reported in public issues: contact the maintainer privately.

## Bug, feature or task?

| Kind | Definition | Quick test | Examples |
|---|---|---|---|
| **Bug** | Something that is supposed to work, according to the spec, the docs or common sense, and does not. | "Is the current behavior wrong?" | Crash on empty input; I2C sensor not detected; wrong footprint for U3 |
| **Feature** | A new capability, or a change in what the product does, that a user or another system would notice. | "Would someone outside the code notice the difference?" | New CAN message; USB-C instead of micro-USB; a new register in an IP |
| **Task** | Work that has to be done but does not change what the product does. | Neither of the above | Refactoring; CI setup; dependency updates; documentation; board bring-up; ordering parts |
| **Next-version change** (hardware) | A change to collect for the next board version. It can come from a bug, a measurement or a feature. | "Can it only be fixed with a new PCB?" | Move J4 by 2 mm; add a test point on 3V3 |

When in doubt between feature and task: would the change appear under "New" in the release notes?
If it would, it is a feature.

## Labels

Labels are grouped in tiers. A repository uses only the tiers it needs, so some of these may be
missing here.

| Tier | Labels | Used for |
|---|---|---|
| base | `bug`, `enhancement`, `task`, `documentation`, `question`, `duplicate`, `invalid`, `wontfix`, `on develop` | Kind of issue, resolution, and `on develop` = fix merged into `develop`, waiting for release (set automatically) |
| area | `area: sw`, `area: fw`, `area: hw`, `area: rtl` | Which part of the project is involved, in repositories that mix several |
| hw | `hw: next rev` | Changes for the next board version |
| advanced | `needs triage`, `breaking change`, `dependencies`, `do not close` | Triage, breaking changes, Dependabot, and `do not close` = referenced by a fix but not actually solved |
| community | `good first issue`, `help wanted` | Issues open to newcomers |

Label pull requests too: release notes are grouped by the labels of the merged pull requests.

## Commits

Commit messages follow the
[Conventional Commits cheat sheet by qoomon](https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13).
Read it for the details; in short:

```text
<type>(<optional scope>): <description>

<optional body>

<optional footer>
```

| Type | When |
|---|---|
| `feat` | Add, change or remove a feature |
| `fix` | Fix a bug |
| `refactor` | Restructure without changing behavior (`perf` if it is for performance) |
| `style` | Formatting only |
| `test` | Add or fix tests |
| `docs` | Documentation only |
| `build` | Build system, toolchain, dependencies, version bumps |
| `ops` | CI/CD, deployment, infrastructure |
| `chore` | Anything else (`.gitignore`, housekeeping) |

- Description: imperative, lowercase, no final period: `fix(fw/can): handle bus-off recovery`.
- Scope is optional and is a part of the project (`fw`, `hw/power`, `rtl/uart`), never an issue
  number.
- Breaking change: `!` before the colon (`feat(fw)!: ...`) and a `BREAKING CHANGE:` footer if the
  description is not enough.

**Exceptions**: the first commit may be `Initial commit` (GitHub's default). Merge and revert
commits keep the messages git creates (`Merge branch '...'`, `Revert "..."`).

**Linking issues** (in the footer or in the pull request description):

| Write | Effect |
|---|---|
| `Fixes #12` / `Closes #12` / `Resolves #12` | Closes #12 when the commit reaches the default branch. On `develop` it adds `on develop`. |
| `Refs #12` | Links #12 without closing it. **Use this for partial fixes.** |
| `Fixes owner/repo#12` | Same as `Fixes`, for an issue in another repository |
| `Fixes #12, fixes #13` | Every reference needs its own keyword: `Fixes #12, #13` closes only #12 |

If an issue was referenced with `Fixes` by mistake, add `do not close` so automations ignore it,
and reopen it if GitHub closes it.

## Pull requests

- Use the template: purpose, linked issues, overview, review guide, how it was tested.
  Keep only the checklist sections that apply.
- Title in the commit format: `fix(fw): debounce user button`.
- One topic per pull request; open it as a **draft** to get early feedback.
- Prefer a **merge commit** over squash, so that `Fixes #N` in the commits reaches the default
  branch. If you squash, keep the `Fixes #N` lines in the squash message.

## Versions

Releases use [Semantic Versioning](https://semver.org/): `vMAJOR.MINOR.PATCH`.

| Bump | When | Commit type |
|---|---|---|
| **MAJOR** | You break compatibility with whoever uses it | `!` / `BREAKING CHANGE` |
| **MINOR** | You add something without breaking anything | `feat` |
| **PATCH** | You fix something without adding or breaking | `fix` (and everything else) |

- **`0.y.z` = initial development**: anything may change, and a breaking change only bumps MINOR.
  Go to `1.0.0` when it is used for real (firmware in the field, a validated board, an IP
  integrated in another design).
- **Pre-releases**: `v1.2.0-rc.1` for a candidate that still has to be validated.

What "breaking compatibility" means depends on the public interface:

| Domain | Public interface | MAJOR | MINOR | PATCH |
|---|---|---|---|---|
| Software | API, CLI, file formats, configuration | Remove or change functions, options, formats | New functions or options | Bug fixes |
| Firmware | External protocols (CAN, serial, BLE), stored configuration format, supported hardware versions | Incompatible message change, configuration must be redone, hardware dropped | New messages or commands, new hardware supported | Bug fixes, optimizations |
| Hardware | Connectors and pinout, mechanics (outline, holes, connector positions), electrical levels, pin mapping to the MCU | Any of these changes: new harness, enclosure or firmware needed | New compatible PCB (fixes, additions that do not interfere) | Same PCB: BOM, values, assembly variants, fabrication files |
| RTL (IP) | Ports, parameters, register map, bus protocol, guaranteed latency | Ports or parameters removed or renamed, incompatible register map, different latency | New optional ports or parameters with defaults, new registers | Bug fixes, timing or area improvements without behavior changes |