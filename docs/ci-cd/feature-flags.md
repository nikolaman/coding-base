# Feature Flags

Вместо долгоживущих feature-веток — короткие ветки + feature flags.

## Принцип

1. Код мержится в `main` за флагом (выключен по умолчанию)
2. Включаешь флаг в staging → smoke tests → production
3. При проблеме — выключаешь флаг, не откатываешь деплой

## Минимальная реализация

### PHP
```php
// config/features.php — флаги из env, не из кода
return [
    'new_checkout' => filter_var(getenv('FEATURE_NEW_CHECKOUT'), FILTER_VALIDATE_BOOL),
];
```

### Python
```python
import os

FEATURES = {
    "new_checkout": os.getenv("FEATURE_NEW_CHECKOUT", "false").lower() == "true",
}
```

## CI/CD

- Флаги — **CI Variables / Secrets** по окружению (staging on, prod off)
- Не храни состояние флагов в репозитории
- Документируй флаги в ADR или `docs/ci-cd/feature-flags.md`

## Инструменты (опционально)

- LaunchDarkly, Unleash, Flagsmith — для зрелых проектов
- Для pet-проектов достаточно env-переменных
