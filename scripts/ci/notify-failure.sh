#!/bin/bash
# Уведомление о падении pipeline (Slack/Teams webhook из CI Variables)
set -euo pipefail

MESSAGE="${1:-Pipeline failed}"
WEBHOOK_URL="${SLACK_WEBHOOK_URL:-${TEAMS_WEBHOOK_URL:-}}"

if [[ -z "$WEBHOOK_URL" ]]; then
  echo "Webhook не настроен (SLACK_WEBHOOK_URL / TEAMS_WEBHOOK_URL) — пропуск"
  exit 0
fi

export MESSAGE
payload=$(python3 - <<'PY'
import json, os
print(json.dumps({"text": os.environ["MESSAGE"]}))
PY
)

curl -fsS -X POST "$WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d "$payload"

echo "Notification sent"
