"""Чтение SemVer из корневого VERSION."""

from __future__ import annotations

from pathlib import Path


def get_app_version() -> str:
    base = Path(__file__).resolve().parent
    candidates = [
        base.parent.parent / "VERSION",  # examples/python/VERSION (Docker)
        base.parent.parent.parent.parent / "VERSION",  # корень monorepo
    ]
    for path in candidates:
        if path.is_file():
            return path.read_text(encoding="utf-8").strip()
    return "dev"
