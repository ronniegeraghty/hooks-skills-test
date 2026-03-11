---
name: list-todos
description: Searches for TODO, FIXME, and HACK comments in project files. Use when the user asks to find TODOs, list action items, or find things that need fixing.
---

## Procedure

1. Use the `bash` tool to run: `grep -rn --include='*' -E '(TODO|FIXME|HACK):?' . --color=never || echo "No TODOs found."`
2. Summarize the results, grouping by file.
3. If no results are found, let the user know the codebase is clean.
