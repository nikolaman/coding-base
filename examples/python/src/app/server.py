"""Минимальный HTTP-сервер для smoke-тестов после деплоя."""

from __future__ import annotations

import json
from http.server import BaseHTTPRequestHandler, HTTPServer

from app.calculator import add
from app.version import get_app_version


class Handler(BaseHTTPRequestHandler):
    def do_GET(self) -> None:  # noqa: N802
        if self.path == "/health":
            payload: dict[str, str] = {"status": "ok", "version": get_app_version()}
        else:
            payload = {
                "service": "python-example",
                "version": get_app_version(),
                "add": str(add(2, 3)),
            }

        body = json.dumps(payload).encode()
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


def main() -> None:
    server = HTTPServer(("0.0.0.0", 8080), Handler)
    server.serve_forever()


if __name__ == "__main__":
    main()
