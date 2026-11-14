## RTL (FPGA and chip design)

- Simulation and lint must pass; add or update a testbench for every behavioral change.
- Timing must be met for the documented target and clock; report WNS and utilization in the pull
  request.
- Do not commit tool output directories (`.Xil/`, `*.runs/`, `*.cache/`, `build/`, `runs/`);
  commit sources, constraints and the scripts that regenerate everything.
- State the tool versions (synthesis, simulation, PDK) in the README.
- **Version**: expose it in the design (a `VERSION` parameter in a package, and a read-only
  version register if the IP has a register map), so software can check it. Examples:
  - `v1.2.0 -> v2.0.0`: a port is removed or renamed, a register moves, latency changes.
  - `v1.2.0 -> v1.3.0`: a new optional port or parameter with a default, a new register.
  - `v1.2.0 -> v1.2.1`: a bug fix, or better timing or area with identical behavior.
