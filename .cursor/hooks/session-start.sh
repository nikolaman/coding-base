#!/bin/bash
# Напоминание о backlog и WIP в начале сессии
set -euo pipefail

input=$(cat)
project_dir="${CURSOR_PROJECT_DIR:-.}"

backlog="$project_dir/docs/BACKLOG.md"
session_log="$project_dir/docs/SESSION-LOG.md"

context=""

if [[ -f "$backlog" ]]; then
  wip=$(grep -c "in_progress" "$backlog" 2>/dev/null || echo "0")
  context="Backlog: docs/BACKLOG.md (WIP: $wip задач). "
else
  context="Backlog не найден — создай docs/BACKLOG.md. "
fi

if [[ -f "$session_log" ]]; then
  context="${context}Последние решения: docs/SESSION-LOG.md. "
fi

context="${context}Цикл: задача → план → проверка → код → тесты → коммит. WIP-лимит: 1–2 задачи."

printf '%s\n' "{\"additional_context\": $(echo "$context" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')}"
exit 0
