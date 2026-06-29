#!/bin/bash
# Оркестрация деплоя — без бизнес-логики
set -euo pipefail

ENVIRONMENT="${1:-staging}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
DEPLOY_STRATEGY="${DEPLOY_STRATEGY:-rolling}"
REPO="${GITHUB_REPOSITORY:-coding-base/coding-base}"

mkdir -p build

APP_VERSION="dev"
if [[ -f VERSION ]]; then
  APP_VERSION=$(tr -d '[:space:]' < VERSION)
fi

export PHP_IMAGE="ghcr.io/${REPO}/php-example:${IMAGE_TAG}"
export PYTHON_IMAGE="ghcr.io/${REPO}/python-example:${IMAGE_TAG}"
export DEPLOY_ENV="${ENVIRONMENT}"

echo "Deploying to ${ENVIRONMENT} with strategy ${DEPLOY_STRATEGY}"
echo "PHP image: ${PHP_IMAGE}"
echo "Python image: ${PYTHON_IMAGE}"

# В реальном проекте: kubectl rollout, helm upgrade, или docker compose на сервере
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then
  docker compose -f docker-compose.yml -f docker-compose.deploy.yml pull || true
  docker compose -f docker-compose.yml -f docker-compose.deploy.yml up -d --no-build
else
  echo "Docker Compose недоступен — записываем метаданные деплоя для аудита"
fi

cat > build/deploy-metadata.json <<EOF
{
  "environment": "${ENVIRONMENT}",
  "strategy": "${DEPLOY_STRATEGY}",
  "image_tag": "${IMAGE_TAG}",
  "app_version": "${APP_VERSION}",
  "php_image": "${PHP_IMAGE}",
  "python_image": "${PYTHON_IMAGE}",
  "deployed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)",
  "commit": "${GITHUB_SHA:-local}"
}
EOF

echo "Deploy metadata written to build/deploy-metadata.json"
