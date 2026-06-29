#!/bin/bash
# Шаблон бэкапа БД — адаптируй под свой стек
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-./backups}"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
RETENTION_DAYS="${RETENTION_DAYS:-14}"

mkdir -p "$BACKUP_DIR"

# --- PostgreSQL ---
# source .env 2>/dev/null || true
# pg_dump -h "${DB_HOST:-localhost}" -U "${DB_USER:-app}" "${DB_NAME:-app}" \
#   | gzip > "$BACKUP_DIR/db_${TIMESTAMP}.sql.gz"

# --- SQLite ---
# cp data/app.db "$BACKUP_DIR/app_${TIMESTAMP}.db"

# Удаление старых бэкапов
find "$BACKUP_DIR" -type f -mtime +"$RETENTION_DAYS" -delete 2>/dev/null || true

echo "Backup template ready. Uncomment your DB section above."
echo "Backups dir: $BACKUP_DIR, retention: ${RETENTION_DAYS}d"
