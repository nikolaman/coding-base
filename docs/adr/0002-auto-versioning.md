# ADR-0002: Автоматическое SemVer-версионирование

- **Статус**: accepted
- **Дата**: 2026-06-29

## Контекст

Нужно единое автоматическое версионирование релизов: теги, CHANGELOG, Conventional Commits.

## Решение

Использовать kit `auto-versioning`:

- `VERSION` + `CHANGELOG.md` — источник правды
- `.github/workflows/release.yml` — bump и тег `vX.Y.Z` на push в `main`
- `.githooks/commit-msg` — проверка `fix:` / `feat:` / `chore:`
- `.cursor/rules/commits.mdc` — правила для агента
- PHP: `includes/app_version.inc.php`, `examples/php/includes/`
- Python: `app/version.py` читает `VERSION`
- Docker-образы: теги `sha`, `latest`, SemVer из `VERSION`

## Bump-правила

| Коммит | Версия |
|--------|--------|
| `fix:` | patch |
| `feat:` | minor |
| `feat!:` / BREAKING | major |
| `chore:`, `docs:` | patch |

## Связанные решения

- ADR-0001 (CI/CD)
- Скилл `~/.cursor/skills/auto-versioning/`
