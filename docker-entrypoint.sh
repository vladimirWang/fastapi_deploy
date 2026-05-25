#!/bin/sh
set -e

echo "Running alembic upgrade head..."
uv run alembic upgrade head

exec "$@"