---
name: project-architecture
description: Provides context about the project architecture, directory layout, and design decisions. Use when asked about how the project is structured, what components exist, or how things fit together.
---

## Project Architecture

This is a small Python utility project for basic math operations.

### Directory Layout

- `sample.py` — Core math utilities (add, subtract, multiply, divide)
- `.github/hooks/` — Copilot hook configurations for auditing tool usage
- `.github/skills/` — Copilot agent skills for contextual knowledge

### Design Decisions

- Functions return `None` for error cases (e.g. division by zero) rather than raising exceptions.
- The project uses no external dependencies — standard library only.
- A `MAGIC_NUMBER` constant (42) exists as a temporary workaround and should be refactored.
