---
name: count-lines
description: Counts lines of code in the project or in specific files. Use when the user asks to count lines, get line counts, or measure file sizes.
---

## Procedure

1. Use the `bash` tool to run `wc -l` on the requested files or directories.
2. If no specific file is given, count all non-hidden files recursively: `find . -type f -not -path '*/\.*' | xargs wc -l`
3. Present the results in a clear summary showing per-file and total line counts.
