# Global Agent Instructions

## General Tool Usage

- Use built-in tools (`list_directory`, `read_file`, etc.) whenever they can accomplish the task. Never shell out for an operation that has a built-in equivalent.
- Use the `terminal` tool only when no built-in alternative exists.
- When `terminal` is unavoidable, briefly state why.

Rationale: built-in tools generally run directly without approval, while `terminal` commands require explicit human approval — unnecessary usage slows the task and interrupts the user.
