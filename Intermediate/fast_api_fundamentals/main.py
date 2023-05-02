# Python
from typing import Optional, Dict
from enum import Enum

# Pydantic
from pydantic import BaseModel, Field

# FastAPI
from fastapi import FastAPI, Body, Query, Path

app = FastAPI()

# Models


class HairColor(Enum):
    white = "white"
    brown = "brown"
    black = "black"
    blonde = "blonde"
    red = "red"


class Person(BaseModel):
    first_name: str = Field(..., min_length=1, max_length=50, example="Marlon")
    last_name: str = Field(..., min_length=1, max_length=50, example="Menendez")
    age: int = Field(..., gt=0, le=99, example=31)
    hair_color: Optional[HairColor] = Field(
        default=None, example="black"
    )
    is_married: Optional[bool] = Field(default=None, example=False)


class Location(BaseModel):
    city: str = Field(..., min_length=1, max_length=50, example="Santa Tecla")
    state: str = Field(..., min_length=1, max_length=50, example="La Libertad")
    country: str = Field(..., min_length=3, max_length=50, example="El Salvador")


@app.get("/")
def home():
    return {"Hello": "World"}


# Request and Response Body
@app.post("/user/new")
def create_user(person: Person = Body(...)) -> Person:
    # The three dots in fastAPI means that it is obligatory
    return person


# Validate Path Parameters
@app.get("person/detail/{person_id}")
def get_person_details(
    person_id: int = Path(
        ...,
        gt=0,
        title="Person ID",
        description="The identifier number of the person. This is obligatory.",
    ),
    name: Optional[str] = Query(
        default=None,
        min_length=1,
        max_length=50,
        title="Person Name",
        description="This is the name of the person. It's between 1 and 50 chars lenght",
    ),
    age: Optional[int] = Query(
        default=None, title="Person Age", description="This is the age of the person."
    ),
) -> Dict:
    return {person_id: "This person exists!", name: age}


# Validations of the Request Body
@app.put("/person/{person_id}")
def update_person(
    person_id: int = Path(
        ..., title="Person Id", description="This is the Id of the person", gt=0
    ),
    person: Person = Body(...),
    location: Location = Body(...),
):
    result = person.dict()
    result.update(location.dict())
    return result
