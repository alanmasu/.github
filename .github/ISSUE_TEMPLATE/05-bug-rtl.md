---
name: Bug report - RTL (FPGA / ASIC)
about: Problem in simulation, synthesis, implementation, timing, on-board behavior or sign-off.
title: "bug(rtl): "
labels: ["bug", "area: rtl", "needs triage"]
assignees: []
---

<!-- Fill in what you can and delete sections that do not apply. -->

## Description

<!-- What is wrong, in one or two sentences. -->

## Design

- Module / top level:
- Version / commit:
- Target:
  - [ ] FPGA - device: <!-- e.g. xc7a35t, 5CSEBA6, iCE40UP5K -->
  - [ ] ASIC - PDK / node: <!-- e.g. SKY130, GF180MCU, IHP SG13G2 -->
- Language: <!-- SystemVerilog, Verilog, VHDL, Chisel, Amaranth ... -->

## Stage where it fails

- [ ] Simulation / testbench
- [ ] Lint
- [ ] Synthesis
- [ ] Place and route
- [ ] Timing (setup / hold)
- [ ] On board / on silicon
- [ ] Sign-off (DRC / LVS / antenna)
- [ ] Other:

## Tools

<!-- Name and version, e.g. Vivado 2024.2, Verilator 5.030, Yosys 0.48, OpenROAD, cocotb 1.9 -->

-

## Steps to reproduce

<!-- Exact commands, testbench, seed, make target. -->

```sh

```

## Expected vs actual

## Evidence

<!-- Waveform screenshot, failing assertion, timing report excerpt (WNS/TNS), utilization, log. -->

## Additional context
