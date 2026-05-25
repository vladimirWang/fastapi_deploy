from datetime import datetime
from contextlib import asynccontextmanager

from fastapi import Depends, FastAPI
from pydantic import BaseModel, ConfigDict
from sqlalchemy.orm import Session

from db import SysUser, UserCreate, get_db, list_sys_users, Base, engine, create_sys_user


@asynccontextmanager
async def lifespan(app: FastAPI):
    Base.metadata.create_all(bind=engine)  # 启动时：表不存在则创建
    yield

app = FastAPI(lifespan=lifespan)

class SysUserOut(BaseModel):
    model_config = ConfigDict(from_attributes=True)

    id: int
    username: str


@app.get("/")
def read_root():
    return {"Hello": "World"}

@app.post("/user", response_model=SysUserOut)
def create_user(user: UserCreate, db: Session = Depends(get_db)):
    return create_sys_user(db, user)

@app.get("/users", response_model=list[SysUserOut])
def read_users(db: Session = Depends(get_db)):
    return list_sys_users(db)


@app.get("/items/{item_id}")
def read_item(item_id: int, q: str | None = None):
    return {"item_id": item_id, "q": q}


if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=6000)
