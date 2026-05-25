#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

if [[ ! -d .venv ]]; then
  echo "未找到 .venv，请先安装依赖：" >&2
  echo "  cd fastapi_deploy && uv sync" >&2
  exit 1
fi

echo "启动 FastAPI → http://127.0.0.1:6000"
exec .venv/bin/python main.py
