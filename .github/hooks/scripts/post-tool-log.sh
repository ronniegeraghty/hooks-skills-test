#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/../logs"
mkdir -p "$LOG_DIR"

python3 -c "
import json, sys
data = json.load(sys.stdin)
result_type = (data.get('toolResult') or {}).get('resultType')
entry = {
    'event': 'postToolUse',
    'timestamp': data.get('timestamp'),
    'toolName': data.get('toolName'),
    'toolArgs': data.get('toolArgs'),
    'resultType': result_type,
}
with open('$LOG_DIR/hook-events.jsonl', 'a') as f:
    f.write(json.dumps(entry) + '\n')
print(f'🟢 [postToolUse] tool={data.get(\"toolName\")} result={result_type}', file=sys.stderr)
"

exit 0
