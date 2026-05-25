FROM python:3.13.5-slim-bookworm

WORKDIR /app

# 安装 uv（与本地一样用 lock 文件）
COPY --from=ghcr.io/astral-sh/uv:0.11.7 /uv /usr/local/bin/uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY main.py ./

EXPOSE 6000
CMD ["uv", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "6000"]