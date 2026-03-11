---
name: error-handling-patterns
description: Provides context on how errors and edge cases are handled in this project. Use when asked about error handling, edge cases, defensive programming, or how to deal with invalid inputs.
---

## Error Handling Patterns

### Current Approach
This project uses return-value-based error handling rather than exceptions:

- `divide(a, b)` returns `None` when `b` is zero
- No functions currently raise exceptions
- Callers are expected to check for `None` before using results

### Known Gaps
- `add` and `subtract` have no input validation at all
- `multiply` does not handle numeric overflow
- There is no type checking — passing strings will produce unexpected results

### Future Direction
The team plans to migrate to a `Result` type pattern or add proper exception handling. See the TODO comments in `sample.py` for specific items.
