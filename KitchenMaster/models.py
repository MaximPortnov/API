from pydantic import BaseModel
from typing import List, Optional

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
    id_productType: int
    title: str

class ProductType(BaseModel):
    id: Optional[int]
    title: str


class ProductTypeCreate(BaseModel):
    title: str


class ProductCreate(BaseModel):
    id_productType: int
    title: str