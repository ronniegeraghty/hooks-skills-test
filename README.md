# Hooks + Skills Test Project

Tests whether Copilot CLI `preToolUse` and `postToolUse` hooks fire when skills are activated.

## Structure

```
.github/
├── hooks/
│   ├── hooks.json              # Hook configuration (preToolUse + postToolUse)
│   ├── logs/                   # Hook event logs (gitignored)
│   └── scripts/
│       ├── pre-tool-log.sh     # Logs every tool call BEFORE execution
│       └── post-tool-log.sh    # Logs every tool call AFTER execution
└── skills/
    ├── project-architecture/SKILL.md   # Context about project structure
    ├── coding-conventions/SKILL.md     # Context about code style rules
    └── error-handling-patterns/SKILL.md # Context about error handling
```

## How to Test

1. `cd` into this directory so Copilot CLI picks up the hooks and skills.
2. Start a Copilot CLI session.
3. Try prompts that should trigger skill activation (context injection):
   - **project-architecture**: "How is this project structured?"
   - **coding-conventions**: "What coding style does this project use?"
   - **error-handling-patterns**: "How does this project handle errors?"
4. Check the log file for hook events:
   ```bash
   cat .github/hooks/logs/hook-events.jsonl
   ```

## What to Look For

Each line in `hook-events.jsonl` is a JSON object with:
- `event`: `"preToolUse"` or `"postToolUse"`
- `toolName`: The tool that was called
- `toolArgs`: The arguments passed to the tool
- `resultType` (postToolUse only): `"success"` or `"failure"`

The key question: **does skill activation itself show up as a tool use in the hooks?**
Skills are purely contextual — they inject knowledge into the agent's context
rather than invoking tools. If hooks fire, you'll see a `toolName` related to
skill loading. If they don't, the log will only contain entries for any tools
the agent decides to use on its own after reading the skill context.

## Sample File

`sample.py` contains a small math module with TODO/FIXME/HACK comments
that the skills reference.
