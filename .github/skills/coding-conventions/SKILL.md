---
name: coding-conventions
description: Provides the coding conventions and style guidelines for this project. Use when asked about code style, naming conventions, formatting rules, or best practices for this codebase.
---

## Coding Conventions

### Naming
- Functions use `snake_case`
- Constants use `UPPER_SNAKE_CASE`
- No abbreviations in function names — prefer clarity over brevity

### Error Handling
- Return `None` for recoverable errors instead of raising exceptions
- Always guard against division by zero and invalid inputs
- Add a `# TODO` comment when error handling is incomplete

### Comments
- Use `# TODO:` for planned improvements
- Use `# FIXME:` for known bugs
- Use `# HACK:` for temporary workarounds that need refactoring

### General
- No external dependencies — standard library only
- All functions should be pure (no side effects)
- Include a `if __name__ == "__main__"` block for demonstration
