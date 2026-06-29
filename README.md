# coding-base

Соло-проект с настроенным окружением Cursor для вайб-кодинга.

## Быстрый старт

1. Открой проект в Cursor — правила и хуки подхватятся автоматически
2. Проверь `docs/BACKLOG.md` — текущие задачи
3. Для новой задачи: «используй vibe-coding-session»

## Структура

```
.cursor/
  rules/          # 6 правил (alwaysApply)
  skills/         # vibe-coding-session, solo-backlog, adr, weekly-audit
  hooks/          # sessionStart, stop
docs/
  BACKLOG.md      # Задачи
  SESSION-LOG.md  # Решения по сессиям
  adr/            # Architecture Decision Records
  architecture/   # Обзор архитектуры
.github/workflows/ci.yml
docker-compose.yml
scripts/backup-db.sh
AGENTS.md         # Инструкции для AI
```

## Workflow

```
Задача → План → Проверка → Код → Тесты + review → Коммит
```

## Скиллы

| Команда в чате | Скилл |
|----------------|-------|
| «вайб-кодинг сессия» | vibe-coding-session |
| «что в backlog» | solo-backlog |
| «задокументируй решение» | adr-documentation |
| «техаудит» | weekly-tech-audit |

## Еженедельно

- Запусти `weekly-tech-audit`
- Проверь бэкапы: `scripts/backup-db.sh`

## Backlog

Источник: `docs/BACKLOG.md`. Можно переключить на Notion/Obsidian/GitHub Issues — укажи в README.
