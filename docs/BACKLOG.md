# Backlog

> Источник правды для задач проекта.

**WIP-лимит:** 1–2 задачи в `in_progress` одновременно.

## В работе (in_progress)

_Пусто_

## Очередь (backlog)

### [3] GitHub Environments (staging/production)
- **Статус**: backlog
- **Приоритет**: P1
- **Критерии готовности**:
  - [ ] Environment `staging` создан
  - [ ] Environment `production` с required reviewers
  - [ ] Secrets настроены (SLACK_WEBHOOK_URL, DB_PASSWORD)

### [4] Dependabot для Actions и Docker
- **Статус**: backlog
- **Приоритет**: P2
- **Критерии готовности**:
  - [ ] `.github/dependabot.yml` создан
  - [ ] Авто-PR на обновление actions и base images

## Заблокировано (blocked)

_Пусто_

## Готово (done)

### [7] Исправление CI (PHP lock + pip-audit)
- **Статус**: done
- **Приоритет**: P0
- **Дата**: 2026-06-29
- **Критерии готовности**:
  - [x] PHP 8.4 в CI и Dockerfile
  - [x] black 26.3.1, pytest 9.0.3
  - [x] pip-audit без уязвимостей

### [6] Автоматическое SemVer-версионирование
- **Статус**: done
- **Приоритет**: P1
- **Дата**: 2026-06-29
- **Критерии готовности**:
  - [x] VERSION, CHANGELOG.md, release.yml
  - [x] Conventional Commits hook + commits.mdc
  - [x] Интеграция в examples/php и examples/python
  - [x] ADR-0002

### [1] CI/CD PHP/Python pipeline
- **Статус**: done
- **Приоритет**: P0
- **Дата**: 2026-06-29
- **Критерии готовности**:
  - [x] Reusable workflows: lint → analyse → test → security → build
  - [x] Deploy: staging auto, production manual
  - [x] Примеры PHP/Python с тестами
  - [x] GitLab CI + Jenkins шаблоны
  - [x] ADR-0001, docs/ci-cd/

### [2] Docker-окружение
- **Статус**: done
- **Приоритет**: P1
- **Дата**: 2026-06-29
- **Критерии готовности**:
  - [x] `docker compose up` — php, python, postgres
  - [x] `docker-compose.deploy.yml` для staging/prod
  - [x] `.env.example` документирован

### [0] Настройка Cursor: правила, скиллы, хуки
- **Статус**: done
- **Приоритет**: P0
- **Дата**: 2026-06-29

### [5] Переименование и GitHub
- **Статус**: done
- **Приоритет**: P0
- **Дата**: 2026-06-29
- **Ветка**: main → https://github.com/nikolaman/coding-base
