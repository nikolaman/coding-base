# CI/CD Best Practices (PHP / Python)

Базовый стандарт pipeline для соло- и pet-проектов на GitHub Actions, GitLab CI и Jenkins.

## Минимальный pipeline

```
Checkout → Lint + Format → Static Analysis → Unit Tests → Security Scan
  → Build Docker Image → Deploy Staging → Smoke Tests → Manual Approval → Deploy Production
```

## Структура репозитория

```
.github/
  actions/setup-php/          # composite: PHP + Composer + cache
  actions/setup-python/       # composite: Python + pip + cache
  workflows/
    ci.yml                    # PR + push: lint → analyse → test → security → build
    deploy.yml                # staging auto, production manual
    reusable-php-pipeline.yml
    reusable-python-pipeline.yml
examples/php/                 # рабочий PHP-пример
examples/python/              # рабочий Python-пример
scripts/ci/                   # только orchestration (без бизнес-логики)
  deploy.sh
  smoke.sh
  migrate.sh
  notify-failure.sh
templates/
  gitlab-ci.yml
  Jenkinsfile
docker-compose.yml            # dev
docker-compose.deploy.yml     # staging/prod (один image — много сред)
```

## Инструменты

| Этап | PHP | Python |
|------|-----|--------|
| Lint / Format | PHP-CS-Fixer, PHPCS | Ruff, Black |
| Static Analysis | PHPStan, Psalm | MyPy, Ruff |
| Tests | PHPUnit / Pest | Pytest |
| Coverage | ≥80% (настраивается) | ≥80% (бизнес-логика) |
| Security | `composer audit` | `pip-audit` |
| Lock-файлы | `composer.lock` | `requirements.txt`, `requirements-dev.txt` |

## GitHub Actions

### Триггеры
- **PR и push в main** — полный CI (п.1)
- **Push в main** — дополнительно build Docker + deploy workflow

### Reusable workflows
Копируй `reusable-*-pipeline.yml` в свой проект и передай `working-directory`:

```yaml
jobs:
  php:
    uses: ./.github/workflows/reusable-php-pipeline.yml
    with:
      working-directory: .
      coverage-threshold: 80
      run-build: true
    secrets: inherit
```

### Окружения (п.13–14)
Создай в GitHub → Settings → Environments:
- **staging** — автодеплой с `main`
- **production** — required reviewers (manual approval)

### Секреты (п.12)
Только в GitHub Secrets / Variables — никогда в репозитории:

| Secret | Назначение |
|--------|------------|
| `SLACK_WEBHOOK_URL` | Уведомления о падениях |
| `DB_PASSWORD` | Продакшен БД |
| `MIGRATION_CMD` | Команда миграций (CI Variable) |

### Кэширование (п.10)
- Composer: `vendor/` + `~/.composer/cache`
- pip: `cache: pip` в setup-python
- Docker: `cache-from/to: type=gha`

### Supply chain (п.24)
SBOM генерируется при build (`anchore/sbom-action`), артефакты загружаются в Actions.

## Docker (п.8, п.7)

- **Dev:** `docker compose up -d` (сборка локально)
- **Deploy:** `docker-compose.deploy.yml` — тот же image tag для staging и prod
- Образы: `ghcr.io/<owner>/<repo>/php-example:<sha>`

## Деплой

### Staging
Автоматически после зелёного CI на `main`.

### Production
1. Manual approval (GitHub Environment `production`)
2. Миграции: `scripts/ci/migrate.sh production`
3. Rolling deploy: `DEPLOY_STRATEGY=rolling`
4. Smoke tests: `scripts/ci/smoke.sh production`

### Zero-downtime (п.15)
Шаблон поддерживает `rolling` / `blue-green` / `canary` через `DEPLOY_STRATEGY` в `deploy.sh` — адаптируй под свой orchestrator (K8s, ECS, Compose).

### Миграции (п.16)
Задай `MIGRATION_CMD` в CI Variables. Миграции должны быть обратимыми (`down` / `rollback`).

## Feature flags (п.18)

Не держи долгоживущие ветки — выкатывай за флагом. См. `docs/ci-cd/feature-flags.md`.

## Уведомления (п.19)

`scripts/ci/notify-failure.sh` — Slack/Teams webhook из секретов.

## Метрики деплоя (п.20)

`build/deploy-metadata.json` — environment, image tag, commit, timestamp. Артефакт в production deploy.

## Скорость pipeline (п.22)

- Параллель PHP + Python
- Кэш зависимостей и Docker layers
- Concurrency: отмена устаревших PR-builds
- Цель: **<10 мин** на PR

## Обновление инструментов (п.25)

- Dependabot / Renovate для GitHub Actions и базовых образов
- Еженедельный `weekly-tech-audit` скилл

## Версионирование (SemVer)

- **Источник правды:** `VERSION` + `CHANGELOG.md`
- **Workflow:** `.github/workflows/release.yml` — bump и тег `vX.Y.Z` на push в `main`
- **Коммиты:** `fix:` patch, `feat:` minor, `BREAKING` / `feat!:` major
- **Hook:** `.githooks/commit-msg`
- **Docker:** образы тегируются `sha`, `latest`, SemVer
- **Подготовка сборки:** `./scripts/ci/prepare-version.sh`
- ADR-0002

## Локальный запуск

```bash
# PHP
cd examples/php && composer install && composer lint && composer analyse && composer test

# Python
cd examples/python && python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements-dev.txt && pip install -e .
ruff check . && black --check . && mypy src && pytest

# Docker
docker compose up -d
./scripts/ci/smoke.sh staging
```

## GitLab / Jenkins

Скопируй `templates/gitlab-ci.yml` или `templates/Jenkinsfile` в корень проекта.
