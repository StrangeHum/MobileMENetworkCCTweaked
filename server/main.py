import json
from fastapi import FastAPI, Request
from pydantic import BaseModel
from typing import List


class Item(BaseModel):
    id: str
    count: int
    craftable: bool = False


class Storage:
    def __init__(self):
        self.items: List[Item] = []

    def set_items(self, items: List[Item]):
        self.items = items

    def get_items(self) -> List[Item]:
        return self.items


class Payload(BaseModel):
    items: List[Item]


def ReadJSONData():
    with open("items/testData.json", "r") as f:
        data = json.load(f)
    return data


app = FastAPI()
secret = "somePassword"  # TODO: Защита

storage = Storage()
storage.set_items(ReadJSONData())


@app.post("/init")
async def init(payload: Payload):

    return {"status": "ok"}


@app.post("/upload")
async def upload(payload: Payload):
    print(f"Получено {len(payload.items)} предметов")
    storage.set_items(payload.items)
    return {"status": "ok"}


@app.post("/craft")
async def craftItem(itemID):

    return {"status": "ok"}  # TODO: On Succes


@app.get("/update")
async def update():
    return storage.get_items()
