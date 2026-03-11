# Copilot CLI Hooks + Skills Test

An experiment to answer: **do Copilot CLI `preToolUse` / `postToolUse` hooks fire when skills are activated?**

**TL;DR — Yes, they do.** Skill activation appears as a tool call with `toolName: "skill"` in both `preToolUse` and `postToolUse` hooks.

## Background

[GitHub Copilot CLI](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line) supports two extensibility mechanisms:

- **Hooks** (`preToolUse` / `postToolUse`) — shell scripts that run before and after every tool call the agent makes. Configured in `.github/hooks/hooks.json`.
- **Skills** — markdown files (`SKILL.md`) that inject contextual knowledge into the agent when relevant prompts are detected. Defined in `.github/skills/`.

This repo tests whether invoking a skill triggers the hook pipeline, or if skills are silently injected without appearing as a tool use event.

## Project Structure

```
.
├── sample.py                              # Sample Python module (skills reference this)
├── .gitignore
└── .github/
    ├── hooks/
    │   ├── hooks.json                     # Hook configuration
    │   ├── logs/                          # Hook event logs (gitignored)
    │   └── scripts/
    │       ├── pre-tool-log.sh            # Logs every tool call BEFORE execution
    │       └── post-tool-log.sh           # Logs every tool call AFTER execution
    └── skills/
        ├── project-architecture/SKILL.md  # Context about project structure
        ├── coding-conventions/SKILL.md    # Context about code style rules
        └── error-handling-patterns/SKILL.md # Context about error handling
```

### Hooks

Both hook scripts read the JSON event from stdin and append a structured log entry to `.github/hooks/logs/hook-events.jsonl`. They use `python3` for JSON parsing (no `jq` dependency required).

**`hooks.json`** registers two hooks:

```json
{
  "hooks": {
    "preToolUse":  [{ "type": "command", "bash": "./scripts/pre-tool-log.sh" }],
    "postToolUse": [{ "type": "command", "bash": "./scripts/post-tool-log.sh" }]
  }
}
```

### Skills

Three skills provide contextual knowledge about the project. Each is a standalone `SKILL.md` with YAML frontmatter (`name`, `description`) and markdown body:

| Skill | Triggers On |
|-------|------------|
| `project-architecture` | "How is this project structured?" |
| `coding-conventions` | "What coding style does this project use?" |
| `error-handling-patterns` | "How does this project handle errors?" |

## How to Reproduce

### Prerequisites

- [GitHub Copilot CLI](https://docs.github.com/en/copilot/using-github-copilot/using-github-copilot-in-the-command-line) installed and authenticated
- Python 3 available on your `PATH` (used by the hook scripts for JSON parsing)

### Steps

1. **Clone the repo and `cd` into it** — Copilot CLI automatically discovers `.github/hooks/` and `.github/skills/` relative to the working directory.

   ```bash
   git clone https://github.com/ronniegeraghty/hooks-skills-test.git
   cd hooks-skills-test
   ```

2. **Start a Copilot CLI session** in this directory.

3. **Ask a question that triggers a skill**, for example:

   ```
   How is this project structured?
   ```

   This should activate the `project-architecture` skill and inject its context.

4. **Inspect the hook log** to see what events were captured:

   ```bash
   cat .github/hooks/logs/hook-events.jsonl | python3 -m json.tool --no-ensure-ascii
   ```

### What to Expect

Each line in `hook-events.jsonl` is a JSON object:

```jsonc
// preToolUse fires BEFORE the skill is invoked
{ "event": "preToolUse",  "toolName": "skill", "toolArgs": "{\"skill\": \"project-architecture\"}", ... }

// postToolUse fires AFTER the skill completes
{ "event": "postToolUse", "toolName": "skill", "toolArgs": { "skill": "project-architecture" }, "resultType": "success" }
```

Key fields:
- **`event`** — `"preToolUse"` or `"postToolUse"`
- **`toolName`** — the tool that was called (`"skill"` for skill activation, `"bash"`, `"view"`, etc. for other tools)
- **`toolArgs`** — arguments passed to the tool (for skills, this includes the skill name)
- **`resultType`** (postToolUse only) — `"success"` or `"failure"`

## Results

**Skills do trigger hooks.** When Copilot CLI activates a skill, it appears as a tool call with `toolName: "skill"` in both the `preToolUse` and `postToolUse` hook pipelines. This means you can:

- **Audit** which skills are being activated and when
- **Log** skill usage alongside other tool calls for observability
- **Conditionally modify** skill behavior via hook responses (e.g., reject a skill activation by returning a non-zero exit code from a `preToolUse` hook)

Other tool calls made by the agent (e.g., `view`, `bash`, `report_intent`) also appear in the log, giving full visibility into the agent's actions.

## Sample File

`sample.py` is a small Python math module with `TODO`/`FIXME`/`HACK` comments that the skills reference. It exists to give the skills realistic content to describe.

## License

This is an experiment / reference implementation. Use it however you like.
