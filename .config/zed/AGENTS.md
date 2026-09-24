# Global Agent Instructions

## General Tool Usage

- Use built-in tools (`list_directory`, `read_file`, etc.) whenever they can accomplish the task. Never shell out for an operation that has a built-in equivalent.
- Use the `terminal` tool only when no built-in alternative exists.
- When `terminal` is unavoidable, briefly state why.

Rationale: built-in tools generally run directly without approval, while `terminal` commands require explicit human approval — unnecessary usage slows the task and interrupts the user.

## Terminal Tool

The `terminal` tool requires **both** parameters and will not work with only one:

- `command` — the command to execute.
- `cd` — the directory the command runs in (a project root or one of its subdirectories, by name).

If either parameter is missing, the call fails with `tool input was not fully received` and no output is produced.
Every call launches a fresh shell, so never assume a working directory carries over from a previous call — set `cd` explicitly each time.
