#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

if [[ ! -d .venv ]]; then
  echo "未找到 .venv，请先安装依赖：" >&2
  echo "  cd fastapi_deploy && uv sync" >&2
  exit 1
fi

if [[ ! -f .env.dev ]]; then
  echo "缺少 .env.dev，请先配置 SQLALCHEMY_DATABASE_URL" >&2
  exit 1
fi

echo "启动 FastAPI → http://127.0.0.1:6000"
exec uv run --env-file .env.dev python main.py
