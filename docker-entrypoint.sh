#!/bin/sh
set -e

if [ -z "${SQLALCHEMY_DATABASE_URL:-}" ]; then
  echo "ERROR: 未设置 SQLALCHEMY_DATABASE_URL，无法执行迁移" >&2
  exit 1
fi

echo "Running alembic upgrade head......"
uv run alembic upgrade head

exec "$@"