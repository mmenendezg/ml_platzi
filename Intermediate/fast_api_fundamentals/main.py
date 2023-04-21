# Python
from typing import Optional

# Pydantic
from pydantic import BaseModel

# FastAPI
from fastapi import FastAPI, Body

app = FastAPI()

# Models


class Person(BaseModel):
    first_name: str
    last_name: str
    age: int
    hair_color: Optional[str] = None
    is_married: Optional[bool] = None


@app.get("/")
def home():
    return {"Hello": "World"}


# Request and Response Body
@app.post("/user/new")
def create_user(person: Person = Body(...)):
    return person
