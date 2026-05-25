#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

ENV_FILE=".env.dev"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "缺少 $ENV_FILE，请先配置 SQLALCHEMY_DATABASE_URL" >&2
  exit 1
fi

MESSAGE="${1:-Create initial user table}"

uv run --env-file "$ENV_FILE" alembic revision -m "$MESSAGE" --autogenerate
