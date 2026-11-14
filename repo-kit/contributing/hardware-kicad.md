## Hardware (KiCad)

- Use the KiCad version stated in the README; do not upgrade the project format in a feature or
  fix branch.
- Symbols and footprints come from the project libraries in the repository, not from personal
  global libraries.
- Run ERC and DRC before opening a pull request; explain any remaining violation.
- In the pull request, attach screenshots or PDFs of the changed sheets and layers so the change
  can be reviewed without opening KiCad.
- Do not commit backups or local files (`*-backups/`, `*.kicad_prl`, `fp-info-cache`, `*.lck`).
- Fabrication outputs (Gerber, drill, BOM, pick and place) are attached to the GitHub Release,
  not committed.

**Versions**

- Write the version in the title block of every sheet and on the silkscreen (`v1.1.0`).
- **A version that has been ordered is frozen.** Any change after the order is a new version;
  collect them in issues labeled `hw: next rev`.
- Prototypes stay at `0.y.z`; the first board that works as intended becomes `v1.0.0`.
- Examples:
  - `v1.1.0 -> v2.0.0`: connector J4 moves, the board outline changes, or a pin moves to another
    MCU pin so the firmware must change.
  - `v1.1.0 -> v1.2.0`: a new PCB that is a drop-in replacement: fixed footprints, better ground
    plane, an added test point or an optional sensor that does not disturb anything.
  - `v1.1.0 -> v1.1.1`: the same PCB with a different BOM: a resistor value, an alternative part,
    an assembly variant, corrected fabrication files.
