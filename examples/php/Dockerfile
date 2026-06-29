# syntax=docker/dockerfile:1

FROM composer:2 AS vendor
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

FROM php:8.4-cli-alpine AS runtime
WORKDIR /app

RUN addgroup -g 1000 app && adduser -u 1000 -G app -D app

COPY --from=vendor /app/vendor ./vendor
COPY src ./src
COPY public ./public
COPY includes ./includes
COPY VERSION ./VERSION

USER app
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8080/health || exit 1

CMD ["php", "-S", "0.0.0.0:8080", "-t", "public"]
