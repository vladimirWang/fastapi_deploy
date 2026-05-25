## 安装
uv add alembic
## 初始化
uv run alembic init -t async alembic

## 修改alembic.ini
修改sqlalchemy.url
env.py导入Base,赋值给
target_metadata = Base.metadata

## 生成迁移代码
```shell
uv run alembic revision -m "Create initial user table" --autogenerate
uv run alembic upgrade head
```