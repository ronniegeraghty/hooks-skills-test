# Hooks + Skills Test Project

Tests whether Copilot CLI `preToolUse` and `postToolUse` hooks fire when skills are triggered.

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
    ├── count-lines/SKILL.md    # Skill: count lines of code (triggers bash)
    ├── generate-greeting/SKILL.md  # Skill: create a greeting file (triggers create + bash)
    └── list-todos/SKILL.md     # Skill: find TODO/FIXME comments (triggers bash)
```

## How to Test

1. `cd` into this directory so Copilot CLI picks up the hooks and skills.
2. Start a Copilot CLI session.
3. Try prompts that trigger skills:
   - **count-lines**: "Count the lines in this project"
   - **generate-greeting**: "Greet me" or "Say hello to Alice"
   - **list-todos**: "Find all TODOs in this project"
4. Check the log file for hook events:
   ```bash
   cat .github/hooks/logs/hook-events.jsonl | jq .
   ```

## What to Look For

Each line in `hook-events.jsonl` is a JSON object with:
- `event`: `"preToolUse"` or `"postToolUse"`
- `toolName`: The tool that was called (e.g. `"bash"`, `"create"`, `"view"`)
- `toolArgs`: The arguments passed to the tool
- `resultType` (postToolUse only): `"success"` or `"failure"`

If hooks fire for skill-triggered tool calls, you'll see entries for every
`bash`, `create`, `edit`, etc. call that the skill instructions cause.

## Sample File

`sample.py` contains TODO/FIXME/HACK comments to give the `list-todos` skill something to find.
