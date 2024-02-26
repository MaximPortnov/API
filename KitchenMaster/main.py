from fastapi import FastAPI, Query
from fastapi.responses import FileResponse
import psycopg2
from pydantic import BaseModel
from typing import List, Optional

MAX_LENGTH = 256
# uvicorn main:app --reload --host 192.168.0.12 --port 3426
connection = psycopg2.connect(dbname="KitchenMaster", host="postgres", user="postgres", password="sql@sql", port="5432")
connection.autocommit = True
cursor = connection.cursor()

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



app = FastAPI()

@app.get("/products/")
async def get_recipes() -> List[Product]:
    cursor.execute("""
    SELECT 
        "Product".id,
        "Product"."Title",
        "ProductType"."Title"
    FROM public."Product"
    Left join "ProductType" on "ProductType".id = "Product"."id_productType"
                   """)
    data = cursor.fetchall()
    products = []
    for recipe_data in data:
        id, title, product_type= recipe_data[:3]

        products.append(Product(
            id=id,
            title= title,
            product_type=product_type
        ))
    return products

@app.get("/products/{id}")
async def get_product(
    id: int
) -> Product:
    cursor.execute("""
    SELECT 
        "Product".id,
        "Product"."Title",
        "ProductType"."Title"
    FROM public."Product"
    Left join "ProductType" on "ProductType".id = "Product"."id_productType"
    where "Product".id = %s
                   """, (id,))
    data = cursor.fetchone()
    id, title, product_type= data[:3]
    return Product(
            id=id,
            title= title,
            product_type=product_type
        )

@app.get("/recipes/")
async def get_recipes(
    products: List[int] = Query(None)
) -> List[Recipe]:
    if(products == None):
        return db_get_recipes()
    return db_get_filtered_recipes(products)

@app.get("/recipes/{id}")
async def get_recipe(
    id: int,
) -> DetailRecipe:
    cursor.execute("SELECT * FROM \"Recipe\" Where id = %s", (id,))
    data = cursor.fetchone()
    id, title, cooking_time, kkal, id_CreatorUser = data[:5]
    return DetailRecipe(
        id=id,
        title=title,
        cooking_time=cooking_time.strftime("%H:%M:%S"),
        kkal=kkal,
        id_CreatorUser=id_CreatorUser,
        ingredients=get_recipe_ingredients(id),
        recipe_steps=[]
    )

@app.get("/recipes/{id}/ingredients")
async def get_ingredients(
    id: int
) -> List[Ingredient]:
    return get_recipe_ingredients(id)

@app.get("/recipes/{id}/steps")
async def get_steps(
    id: int
) -> List[RecipeStep]:
    return get_recipe_steps(id)


@app.get("/image/", responses={200: {"content": {"image/jpg": {}}}})
async def get_image():
    return FileResponse("test3.jpg")



def db_get_recipes() -> List[Recipe]:
    cursor.execute("SELECT * FROM \"Recipe\";")
    data = cursor.fetchall()
    recipes = []
    for recipe_data in data:
        id, title, cooking_time, kkal, id_CreatorUser = recipe_data[:5]

        recipes.append(Recipe(
            id=id,
            title= title,
            cooking_time= cooking_time.strftime("%H:%M:%S"),
            kkal= kkal,
            id_CreatorUser= id_CreatorUser,
            ingredients= get_recipe_ingredients(id)
        ))
    return recipes

def db_get_filtered_recipes(id_products: List[int]) -> List[Recipe]:
    cursor.execute("""
SELECT *
FROM public."Recipe"
Where (select count(*) from "RecipeIngredient" 
	   where "id_Recipe" = "Recipe".id)
	   = 
	   (select count(*) from "RecipeIngredient"
		where "id_Recipe" = "Recipe".id and 
	   		"id_Product" in %s)
                   """, (tuple(id_products),))
    data = cursor.fetchall()
    recipes = []
    for recipe_data in data:
        id, title, cooking_time, kkal, id_CreatorUser = recipe_data[:5]

        recipes.append(Recipe(
            id=id,
            title= title,
            cooking_time= cooking_time.strftime("%H:%M:%S"),
            kkal= kkal,
            id_CreatorUser= id_CreatorUser,
            ingredients= get_recipe_ingredients(id)
        ))
    return recipes

def get_recipe_steps(recipe_id: int) -> List[RecipeStep]:
    cursor.execute("""
        SELECT 
            step_num, 
            step_text, 
            step_image
            
        FROM public."CookStep"
        Where "id_Recipe" = %s
        ORDER BY step_num
""", (recipe_id,))
    recipe_step_data = cursor.fetchall()
    steps = []  
    for data in recipe_step_data:
        step_num, step_text, step_image = data[:3]
        steps.append(RecipeStep(
            step_num=step_num,
            step_text=step_text,
            step_image=step_image
        ))
    return steps



def get_recipe_ingredients(recipe_id: int) -> List[Ingredient]:
    cursor.execute("""
        SELECT 
            "Product".id,
            "Product"."Title",
            "MeasureType"."title",
            count

        FROM public."RecipeIngredient" 
        inner join public."Product" on "id_Product" = "Product".id
        inner join public."MeasureType" on "id_MeasureType" = "MeasureType".id
        where "id_Recipe" = %s;
    """, (recipe_id,))
    ingredients_data = cursor.fetchall()
    ingredients = []
    for ingredient_data in ingredients_data:
        id, title, measureType_title, count = ingredient_data[:4]
        ingredients.append(Ingredient(
            id=id,
            title=title,
            count= count,
            measureType=measureType_title
        ))
    return ingredients