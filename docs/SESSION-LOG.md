# Session Log

Журнал решений по сессиям вайб-кодинга.

---

## 2026-06-29 — Исправление CI

**Задача:** Починить падение CI после первого push.

**Причины:**
- PHP: `composer.lock` под 8.4, CI на 8.3 → Symfony 8.1 несовместим
- Python: `pip-audit` — уязвимости в black 25.1.0, pytest 8.3.5

**Решения:**
- PHP 8.4 в CI, Dockerfile, composer.json
- black 26.3.1, pytest 9.0.3

**Следующий шаг:** Проверить зелёный CI на GitHub

---

## 2026-06-29 — Автоматическое SemVer-версионирование

**Задача:** Настроить автоверсионирование (теги, CHANGELOG, Conventional Commits).

**Решения:**
- Kit `auto-versioning`: VERSION, CHANGELOG.md, release.yml, .githooks/commit-msg
- Правило `.cursor/rules/commits.mdc`
- Версия в examples/php (APP_VERSION) и examples/python (get_app_version)
- Docker-теги: sha + SemVer из VERSION
- ADR-0002, `scripts/ci/prepare-version.sh`

**Открытые вопросы:**
- GitHub Actions → Read and write permissions
- Первый push создаст тег v1.0.0

**Следующий шаг:** ~~Коммит + push~~ → выполнено в `007ba82`

---

## 2026-06-29 — CI/CD Best Practices PHP/Python

**Задача:** Реализовать полный CI/CD стандарт для PHP и Python проектов.

**Решения:**
- Reusable GitHub Actions: lint → analyse → test (≥80%) → security → build
- Deploy workflow: staging auto, production manual approval
- Примеры: `examples/php`, `examples/python` с рабочими тестами
- Composite actions: setup-php, setup-python с кэшированием
- Docker: compose dev + deploy override (один build — много сред)
- Скрипты orchestration: deploy, smoke, migrate, notify
- Шаблоны: GitLab CI, Jenkinsfile
- ADR-0001, скилл `ci-cd-php-python`, docs/ci-cd/

**Открытые вопросы:**
- Настроить GitHub Environments (staging/production) вручную
- Dependabot для actions и base images

**Следующий шаг:** Push и проверка CI на GitHub

---

## 2026-06-29 — Переименование и публикация

**Задача:** Переименовать в coding-base, git init, GitHub.

**Решения:**
- Репозиторий: https://github.com/nikolaman/coding-base
- Первый коммит на main

---

## 2026-06-29 — Настройка соло/вайб-кодинг окружения

**Задача:** Лучшие практики соло-программирования и вайб-кодинга в Cursor.

**Решения:**
- Правила, скиллы, хуки, шаблоны ADR/CI/Docker

---

## Шаблон записи

```markdown
## YYYY-MM-DD — Краткое название

**Задача:** ...

**Решения:**
- ...

**Открытые вопросы:**
- ...

**Следующий шаг:** ...
```
