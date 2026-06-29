#!/bin/bash
# Шаблон миграций БД — обратимые миграции как часть deployment
set -euo pipefail

ENVIRONMENT="${1:-staging}"
MIGRATION_CMD="${MIGRATION_CMD:-}"

echo "Running migrations for ${ENVIRONMENT}"

if [[ -z "$MIGRATION_CMD" ]]; then
  echo "MIGRATION_CMD не задан — пропуск (задайте в CI Variables)"
  echo "Примеры:"
  echo "  PHP:  MIGRATION_CMD='php bin/console doctrine:migrations:migrate --no-interaction'"
  echo "  Python: MIGRATION_CMD='alembic upgrade head'"
  exit 0
fi

# shellcheck disable=SC2086
eval $MIGRATION_CMD

echo "Migrations completed for ${ENVIRONMENT}"
