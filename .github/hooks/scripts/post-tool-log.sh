#!/bin/bash
set -euo pipefail

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.toolName')
TOOL_ARGS=$(echo "$INPUT" | jq -r '.toolArgs')
RESULT_TYPE=$(echo "$INPUT" | jq -r '.toolResult.resultType')
TIMESTAMP=$(echo "$INPUT" | jq -r '.timestamp')

mkdir -p "$(dirname "$0")/../logs"

# Log the post-tool event
jq -n -c \
  --arg event "postToolUse" \
  --arg ts "$TIMESTAMP" \
  --arg tool "$TOOL_NAME" \
  --arg args "$TOOL_ARGS" \
  --arg result "$RESULT_TYPE" \
  '{event: $event, timestamp: $ts, toolName: $tool, toolArgs: $args, resultType: $result}' \
  >> "$(dirname "$0")/../logs/hook-events.jsonl"

# Also print to stderr so it shows up in the terminal
echo "🟢 [postToolUse] tool=$TOOL_NAME result=$RESULT_TYPE" >&2

exit 0
