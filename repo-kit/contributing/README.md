# CONTRIBUTING kit

`CONTRIBUTING.md` here is the general template. To give a repository its own rules:

1. Copy `CONTRIBUTING.md` into the root of the repository.
2. Append, at the end, the modules that apply:

   | Module | For repositories that ... |
   |---|---|
   | `branching-gitflow.md` | use `main` + `develop` (and the on-develop action) |
   | `branching-simple.md` | work on `main` through pull requests only |
   | `software.md` | contain applications, libraries, tools or scripts |
   | `firmware.md` | contain firmware for microcontrollers |
   | `hardware-kicad.md` | contain KiCad projects |
   | `rtl.md` | contain FPGA or chip designs |

   ```sh
   cat CONTRIBUTING.md branching-gitflow.md firmware.md hardware-kicad.md > ../my-repo/CONTRIBUTING.md
   ```

3. Adjust the result by hand: remove rows that do not apply (e.g. label tiers the repository does
   not use) and add anything specific to the repository.
