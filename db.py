import os
from collections.abc import Generator
from datetime import datetime

from dotenv import load_dotenv
from sqlalchemy import BigInteger, DateTime, String, create_engine, select
from sqlalchemy.orm import DeclarativeBase, Mapped, Session, mapped_column, sessionmaker

from pydantic import BaseModel

load_dotenv()

DATABASE_URL = os.getenv("SQLALCHEMY_DATABASE_URL")
if not DATABASE_URL:
    raise RuntimeError("缺少 SQLALCHEMY_DATABASE_URL，请配置环境变量或 .env 文件")

engine = create_engine(DATABASE_URL, pool_pre_ping=True)
SessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)


class Base(DeclarativeBase):
    pass


class SysUser(Base):
    __tablename__ = "user"

    id: Mapped[int] = mapped_column(BigInteger, primary_key=True, autoincrement=True)
    username: Mapped[str] = mapped_column(String(30))


def get_db() -> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


def list_sys_users(db: Session) -> list[SysUser]:
    return list(db.scalars(select(SysUser)).all())

class UserCreate(BaseModel):
    username: str

def create_sys_user(db: Session, user: UserCreate) -> SysUser:
    row = SysUser(username=user.username)
    db.add(row)
    db.commit()
    db.refresh(row)
    return row
