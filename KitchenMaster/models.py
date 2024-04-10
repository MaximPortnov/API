from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime, date

class Ingredient(BaseModel):
    id: Optional[int]
    title: str
    count: int
    measureType: str
 
class RecipeStep(BaseModel):
    step_num: int
    step_text: str
    step_image: Optional[str]
    

class Recipe(BaseModel):
    id: Optional[int]
    title: str
    cooking_time: Optional[str]
    kkal: Optional[int]
    id_CreatorUser: Optional[int]
    ingredients: List[Ingredient]

class DetailRecipe(BaseModel):
    id: Optional[int]
    title: str
    cooking_time: Optional[str]
    kkal: Optional[int]
    id_CreatorUser: Optional[int]
    ingredients: List[Ingredient]
    recipe_steps: List[RecipeStep]

class Product(BaseModel):
    id: Optional[int]
    title: str
    product_type: Optional[str]

class ProductModel(BaseModel):
    id: Optional[int]
    id_productType: Optional[int]
    title: str

class ProductType(BaseModel):
    id: Optional[int]
    title: str


class ProductTypeCreate(BaseModel):
    title: str


class ProductCreate(BaseModel):
    id_productType: int
    title: str



class StepCreate(BaseModel):
    text: str
    imageUrl: Optional[str] = None

class IngredientCreate(BaseModel):
    productId: int
    measureTypeId: int
    quantity: float

class RecipeCreate(BaseModel):
    title: str
    imageUrl: Optional[str] = None
    cookingTime: Optional[str] = None  # Формат "HH:MM:SS"
    calories: Optional[int] = None
    creatorUserId: int
    ingredients: List[IngredientCreate]
    steps: List[StepCreate]


class StepModel(BaseModel):
    text: str
    imageUrl: Optional[str]

class IngredientModel(BaseModel):
    productId: int
    measureTypeId: int
    quantity: float

class RecipeModel(BaseModel):
    id: int
    title: str
    imageUrl: Optional[str]
    cookingTime: Optional[str]  # Формат "HH:MM:SS"
    calories: Optional[int]
    creatorUserId: int
    ingredients: List[IngredientCreate]
    steps: List[StepCreate]



class UserCreate(BaseModel):
    id_userRole: int
    name: str
    region: Optional[str] = None
    birth_date: date
    created_date: datetime = datetime.now()

class UserRoleCreate(BaseModel):
    title: str

class User(BaseModel):
    id: int
    id_userRole: int
    name: str
    region: Optional[str] = None
    birth_date: date
    created_date: datetime

class UserRole(BaseModel):
    id: int
    title: str

class MeasureTypeCreate(BaseModel):
    title: str

class MeasureTypeModel(BaseModel):
    id: int
    title: str