#!/bin/bash
# Копирует VERSION в контексты сборки examples/* (monorepo)
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cp "$ROOT/VERSION" "$ROOT/examples/php/VERSION"
cp "$ROOT/VERSION" "$ROOT/examples/python/VERSION"
echo "VERSION copied to examples/php and examples/python"
