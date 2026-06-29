# Agents

Инструкции для AI-агента в этом проекте.

## Workflow

```
Задача → План → Проверка → Код → Тесты + review → Коммит
```

## CI/CD

Полный стандарт: `docs/ci-cd/README.md`, ADR-0001.

## Версионирование

ADR-0002. `VERSION` + `release.yml` + Conventional Commits. Скилл: `auto-versioning`.

## Скиллы

| Скилл | Когда |
|-------|-------|
| vibe-coding-session | Начало задачи, крупные изменения |
| solo-backlog | Планирование, приоритизация |
| adr-documentation | Архитектурные решения |
| ci-cd-php-python | CI/CD, pipeline, деплой |
| auto-versioning | Версии, релизы, CHANGELOG, Conventional Commits |
| weekly-tech-audit | Еженедельная проверка |

## Ограничения

- WIP: максимум 1–2 задачи
- Изменения: 100–300 строк за шаг
- Коммиты: только по явной просьбе
- Секреты: только CI Variables/Secrets

## Документация

- CI/CD: `docs/ci-cd/README.md`
- Backlog: `docs/BACKLOG.md`
- Сессии: `docs/SESSION-LOG.md`
- ADR: `docs/adr/`
