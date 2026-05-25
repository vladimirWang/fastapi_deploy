#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

ENV_FILE=".env.prod"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "缺少 $ENV_FILE，请先配置生产环境变量" >&2
  exit 1
fi

# # 旧版 docker compose 不支持 CLI 的 --env-file；加载后供 compose 内 ${DATABASE_*} 等替换
# set -a
# # shellcheck disable=SC1091
# source "$ENV_FILE"
# set +a

docker compose -f docker-compose.yml -p fastapi-prod --env-file ./.env.prod up -d --build
