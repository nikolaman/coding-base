# syntax=docker/dockerfile:1

FROM python:3.12-slim AS runtime

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

RUN groupadd --gid 1000 app && useradd --uid 1000 --gid app --create-home app

COPY requirements.txt requirements-dev.txt pyproject.toml ./
COPY VERSION ./VERSION
COPY src ./src
COPY tests ./tests

RUN pip install --upgrade pip \
    && pip install -r requirements-dev.txt \
    && pip install -e .

USER app
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/health')"

CMD ["python", "-m", "app.server"]
