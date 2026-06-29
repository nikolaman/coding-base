#!/bin/bash
# Чеклист в конце сессии агента
set -euo pipefail

input=$(cat)

followup="Сессия завершена. Проверь чеклист:
- [ ] Тесты пройдены
- [ ] Решения записаны в docs/SESSION-LOG.md
- [ ] docs/BACKLOG.md обновлён
- [ ] ADR создан (если было архитектурное решение)
- [ ] Коммит — только если готов и запрошен"

printf '%s\n' "{\"followup_message\": $(echo "$followup" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))')}"
exit 0
