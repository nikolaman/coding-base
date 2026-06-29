# coding-base

Базовое окружение соло- и вайб-кодинга в Cursor + CI/CD для PHP/Python.

## Быстрый старт

1. Открой проект в Cursor — правила и хуки подхватятся автоматически
2. Проверь `docs/BACKLOG.md` — текущие задачи
3. CI/CD: `docs/ci-cd/README.md`

## Структура

```
.cursor/
  rules/          # соло-workflow, вайб-кодинг, infra-ops
  skills/         # vibe-coding, backlog, adr, ci-cd-php-python
  hooks/          # sessionStart, stop
examples/
  php/            # PHPUnit, PHPStan, Psalm, PHP-CS-Fixer
  python/         # Pytest, Ruff, Black, MyPy
.github/
  actions/        # setup-php, setup-python
  workflows/      # ci, deploy, reusable pipelines
docs/
  ci-cd/          # CI/CD best practices
  adr/            # Architecture Decision Records
scripts/ci/       # deploy, smoke, migrate, notify
templates/        # GitLab CI, Jenkinsfile
docker-compose.yml
AGENTS.md
```

## CI/CD Pipeline

```
Lint → Static Analysis → Tests (≥80%) → Security → Build → Staging → Smoke → Prod
```

Запускается на каждый PR и push в `main`. Подробности: [docs/ci-cd/README.md](docs/ci-cd/README.md).

## Локально

```bash
# PHP
cd examples/php && composer install && composer lint && composer test

# Python
cd examples/python && python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements-dev.txt && pip install -e . && pytest

# Docker
docker compose up -d
```

## Скиллы

| Команда | Скилл |
|---------|-------|
| «вайб-кодинг сессия» | vibe-coding-session |
| «настрой CI/CD» | ci-cd-php-python |
| «техаудит» | weekly-tech-audit |

## GitHub

https://github.com/nikolaman/coding-base

Настрой Environments: `staging` (auto), `production` (manual approval).

## Версионирование

- **SemVer:** `VERSION` + `CHANGELOG.md`
- **Коммиты:** `fix:` → patch, `feat:` → minor, `BREAKING` → major
- **Релиз:** push в `main` → GitHub Action `release.yml` → тег `vX.Y.Z`
- **Hook:** `.githooks/commit-msg` (уже настроен через `core.hooksPath`)

GitHub → Settings → Actions → **Read and write** permissions.

```bash
# перед локальной Docker-сборкой
./scripts/ci/prepare-version.sh
```
