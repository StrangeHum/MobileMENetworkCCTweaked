import json
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List

import pickle

# poetry run uvicorn main:app --host 0.0.0.0 --port 8081 --reload


class Item(BaseModel):
    id: str
    count: int
    craftable: bool = False
    displayName: str


class Storage:
    def __init__(self):
        self.items: List[Item] = []

    def set_items(self, items: List[Item]):
        self.items = items

    def get_items(self) -> List[Item]:
        return self.items

    def to_json(self) -> list[dict]:
        """Возвращает Python-объект, готовый к сериализации в JSON."""
        return [item.model_dump() for item in self.items]


class Payload(BaseModel):
    items: List[Item]

    def to_json(self) -> list[dict]:
        """Возвращает Python-объект, готовый к сериализации в JSON."""
        return [item.model_dump() for item in self.items]

    def to_json_str(self) -> str:
        """Возвращает готовую JSON-строку."""
        return self.model_dump_json()


def ReadSavedData():
    with open("items/testData.json", "r") as f:
        data = json.load(f)
    return data


# poetry run uvicorn main:app --host 0.0.0.0 --port 8081 --reload


def SaveData(data):
    with open("items/testData.json", "w") as file:
        json.dump(data, file)
    return {"status": "ok"}


app = FastAPI()
secret = "somePassword"  # TODO: Защита

storage = Storage()
storage.set_items(ReadSavedData())


@app.post("/init")
async def init(payload: Payload):
    print(payload.ToJSON())
    SaveData(payload.ToJSON())
    return {"status": "ok"}


@app.post("/upload")
async def upload(payload: Payload):
    print(f"Получено {len(payload.items)} предметов")
    storage.set_items(payload.items)
    SaveData(storage.to_json())
    return {"status": "ok"}


@app.post("/craft")
async def craftItem(itemID):

    return {"status": "ok"}  # TODO: On Succes


@app.get("/update")
async def update():

    return storage.get_items()
