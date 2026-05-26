#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

ENV_FILE=".env.prod"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "缺少 $ENV_FILE，请先配置生产环境变量" >&2
  exit 1
fi

if ! docker network inspect private_chef_network >/dev/null 2>&1; then
  echo "未找到 Docker 网络 private_chef_network，请先启动基础设施：" >&2
  echo "  cd ../docker_infrastracture && docker compose up -d" >&2
  exit 1
fi

docker compose -f docker-compose.yml -p fastapi-prod --env-file ./.env.prod up -d --build
