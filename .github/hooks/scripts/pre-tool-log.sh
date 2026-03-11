#!/bin/bash
set -euo pipefail

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')
TOOL_ARGS=$(echo "$INPUT" | jq -r '.toolArgs')
TIMESTAMP=$(echo "$INPUT" | jq -r '.timestamp')

mkdir -p "$(dirname "$0")/../logs"

# Log the pre-tool event
jq -n -c \
  --arg event "preToolUse" \
  --arg ts "$TIMESTAMP" \
  --arg tool "$TOOL_NAME" \
  --arg args "$TOOL_ARGS" \
  '{event: $event, timestamp: $ts, toolName: $tool, toolArgs: $args}' \
  >> "$(dirname "$0")/../logs/hook-events.jsonl"

# Also print to stderr so it shows up in the terminal
echo "🔵 [preToolUse] tool=$TOOL_NAME" >&2

exit 0
