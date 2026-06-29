---
name: ci-cd-php-python
description: Настраивает и запускает CI/CD pipeline для PHP/Python — lint, static analysis, tests, security, Docker build, deploy staging/prod. Используется при запросах про CI/CD, pipeline, GitHub Actions, деплой, lint, PHPUnit, Pytest, PHPStan, Ruff.
---

# CI/CD PHP/Python

## Быстрый старт

1. Прочитай `docs/ci-cd/README.md` и ADR-0001
2. Определи стек: PHP, Python или оба
3. Скопируй `examples/php` или `examples/python` как основу
4. Подключи reusable workflow из `.github/workflows/`

## Pipeline (строго по порядку)

```
Checkout → Lint → Static Analysis → Tests (≥80%) → Security → Build → Deploy Staging → Smoke → Approval → Deploy Prod
```

## Локальная проверка перед push

### PHP
```bash
cd examples/php  # или корень проекта
composer install
composer lint
composer analyse
composer test
composer security-audit
```

### Python
```bash
cd examples/python
python3 -m venv .venv && source .venv/bin/activate
pip install -r requirements-dev.txt && pip install -e .
ruff check . && ruff format --check . && black --check .
mypy src
pytest
pip-audit -r requirements-dev.txt
```

## Настройка GitHub

1. Environments: `staging`, `production` (required reviewers на prod)
2. Secrets: `SLACK_WEBHOOK_URL`, `DB_PASSWORD`
3. Variables: `MIGRATION_CMD`, `COVERAGE_THRESHOLD`
4. Package permissions: `packages: write` для GHCR

## Адаптация под проект

| Что менять | Где |
|------------|-----|
| Порог покрытия | `coverage-threshold` в ci.yml |
| Пути | `working-directory` в reusable workflow |
| Образы | `docker/metadata-action` images |
| Деплой | `scripts/ci/deploy.sh` |
| Миграции | `MIGRATION_CMD` + `migrate.sh` |

## Антипаттерны

- ❌ Секреты в репозитории
- ❌ Бизнес-логика в CI-скриптах
- ❌ Разные образы для staging и prod
- ❌ Пропуск security scan
- ❌ Деплой без smoke tests

## Дополнительно

- GitLab: `templates/gitlab-ci.yml`
- Jenkins: `templates/Jenkinsfile`
- Feature flags: `docs/ci-cd/feature-flags.md`
