# Python
from typing import Optional

# Pydantic
from pydantic import BaseModel

# FastAPI
from fastapi import FastAPI, Body, Query

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
def create_user(person: Person = Body(...)) -> Person:
    # The three dots in fastAPI means that it is obligatory
    return person

# Validate Query Parameters
@app.get("/person/detail")
def get_person_details(
    name: Optional[str] = Query(default=None, min_length=1, max_length=50),
    age: Optional[int] = Query(default=None)
):
    return {
        name: age
    }