#!/usr/bin/env bash
#
docker compose -p fastapi-prod --env-file ./.env.prod down
