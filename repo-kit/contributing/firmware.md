## Firmware

- The build must pass for every configured target without new warnings.
- In the pull request, state the board and hardware version you tested on.
- Report Flash and RAM usage for non-trivial changes.
- Pin and peripheral assignments live in one place (board header, device tree, `platformio.ini`)
  and must match the schematic of the hardware version they target.
- Never commit secrets or credentials (Wi-Fi passwords, keys, tokens).
- **Version**: keep it in one place (e.g. `version.h` or the build system) and make it readable
  at runtime (boot log, a version command or message), so a device in the field can tell which
  firmware it runs. Examples:
  - `v1.3.0 -> v2.0.0`: a CAN message changes ID or payload layout, so the other nodes must be
    updated too.
  - `v1.3.0 -> v1.4.0`: a new command or message; support for hardware `v2.x`.
  - `v1.3.0 -> v1.3.1`: a bug fix with no change to the protocol.
  - State in the README which hardware versions each firmware version supports.
