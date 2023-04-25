# Python
from typing import Optional, Dict

# Pydantic
from pydantic import BaseModel

# FastAPI
from fastapi import FastAPI, Body, Query, Path

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


# Validate Path Parameters
@app.get("person/detail/{person_id}")
def get_person_details(
    person_id: int = Path(
        ...,
        gt=0,
        title="Person ID",
        description="The identifier number of the person. This is obligatory."
    ),
    name: Optional[str] = Query(
        default=None,
        min_length=1,
        max_length=50,
        title="Person Name",
        description="This is the name of the person. It's between 1 and 50 chars lenght",
    ),
    age: Optional[int] = Query(
        default=None,
        title="Person Age",
        description="This is the age of the person."
    )
) -> Dict:
    return {
        person_id: "This person exists!",
        name: age
    }
