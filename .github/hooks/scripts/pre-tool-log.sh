#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
mkdir -p "$LOG_DIR"

python3 -c "
import json, sys
data = json.load(sys.stdin)
entry = {
    'event': 'preToolUse',
    'timestamp': data.get('timestamp'),
    'toolName': data.get('toolName'),
    'toolArgs': data.get('toolArgs'),
}
with open('$LOG_DIR/hook-events.jsonl', 'a') as f:
    f.write(json.dumps(entry) + '\n')
print(f'🔵 [preToolUse] tool={data.get(\"toolName\")}', file=sys.stderr)
"

exit 0
