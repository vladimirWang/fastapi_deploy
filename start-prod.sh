#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

docker compose -f docker-compose.yml -p fastapi-prod up --env-file .env.prod -d --build