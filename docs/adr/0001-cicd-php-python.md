# ADR-0001: CI/CD pipeline для PHP и Python

- **Статус**: accepted
- **Дата**: 2026-06-29
- **Автор**: coding-base

## Контекст

Нужен воспроизводимый CI/CD стандарт для соло-проектов на PHP и Python с ранним обнаружением проблем, безопасностью и деплоем через Docker.

## Решение

GitHub Actions как основной CI с reusable workflows:

1. **CI на каждый PR/push** — lint → static analysis → tests (≥80% coverage) → security scan
2. **Build once** — Docker image с тегом `git sha`, push в GHCR
3. **Deploy** — staging автоматически, production с manual approval
4. **Orchestration** — только в `scripts/ci/`, бизнес-логика в приложении
5. **Шаблоны** — GitLab CI и Jenkinsfile для переносимости

## Альтернативы

| Вариант | Плюсы | Минусы | Почему отвергнут |
|---------|-------|--------|------------------|
| Монолитный ci.yml | Проще начать | Дублирование, сложно переиспользовать | Нарушает п.23 |
| Только lint+test | Быстрее | Нет security/deploy | Неполный стандарт |
| Travis CI | Знакомый | Устаревший, меньше интеграций | GitHub Actions нативнее |

## Последствия

### Положительные
- Единый стандарт для PHP/Python
- Reusable workflows сокращают копипасту
- SBOM и composer/pip audit из коробки

### Отрицательные / риски
- GitHub Environments нужно настроить вручную
- Deploy-скрипты — шаблон, требуют адаптации под инфраструктуру

### Технический долг
- Cosign-подпись образов — опционально, не включена по умолчанию
- Poetry — используем requirements-dev.txt; poetry.lock — по необходимости

## Связанные решения

- `docs/ci-cd/README.md`
- `docs/ci-cd/feature-flags.md`
