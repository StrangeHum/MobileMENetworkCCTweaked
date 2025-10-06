import json
from fastapi import FastAPI, Request
from pydantic import BaseModel
from typing import List

import pickle


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

    def ToJSON(self):

        return [
            {"id": item.id, "count": item.count, "craftable": item.craftable}
            for item in self.items
        ]


def ReadJSONData():
    with open("items/testSaveJSONData.json", "r") as f:
        data = json.load(f)
    return data


# poetry run uvicorn main:app --host 0.0.0.0 --port 8081 --reload


def WriteClassJSONData(data):
    with open("items/testSaveJSONData.json", "w") as file:
        json.dump(data, file)
    return {"status": "ok"}


def SaveJSONData(data):
    with open("items/testSaveData.json", "wb") as file:
        pickle.dump(data, file)
    return {"status": "ok"}


app = FastAPI()
secret = "somePassword"  # TODO: Защита

storage = Storage()
storage.set_items(ReadJSONData())


@app.post("/init")
async def init(payload: Payload):
    print(payload.ToJSON())
    WriteClassJSONData(payload.ToJSON())
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
