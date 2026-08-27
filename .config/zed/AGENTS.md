# Global Agent Instructions

## General Tool Usage

- Prefer built-in tools (`list_directory`, `read_file`, etc.) over shell commands.
- Reserve the `terminal` tool for operations that must run outside of the editor — builds, tests, and other CLIs.
- Rationale: built-in tools integrate with the editor workflow, while `terminal` use require explicit human oversight.

## Terminal Tool

- Always pass an explicit `cd` parameter pointing at an absolute project path, e.g. `cd` = `.../project-root/some-folder`.
- Perform the directory switch with the `cd` parameter — never use `cd ... && ...` inside the `command` itself.
- Rationale: the terminal tool is sandboxed, and the sandbox must know the absolute path associated with the command.
