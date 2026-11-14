## Software

- Use the formatter and linter configured in the repository; CI must pass.
- New behavior comes with tests when the project has a test suite.
- Document user-visible changes (README, `--help`, docs).
- Never commit secrets, credentials or personal data.
- **Version**: the public interface is what users and other programs rely on: API, CLI options,
  file formats, configuration. Keep the version in one place (`pyproject.toml`, `package.json`,
  `CMakeLists.txt` ...) and bump it in the release commit: `build(release): bump version to 1.4.0`.
