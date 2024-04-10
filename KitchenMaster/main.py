from fastapi import FastAPI, File, Query, UploadFile, status, HTTPException
from fastapi.responses import FileResponse
import psycopg2
import httpx
from typing import List
import datetime

import models as m

MAX_LENGTH = 256
# uvicorn main:app --reload --host 192.168.0.12 --port 3426
# connection = psycopg2.connect(dbname="KitchenMaster", host="postgres", user="postgres", password="sql@sql", port="5432")
connection = psycopg2.connect(dbname="KitchenMaster", host="localhost", user="postgres", password="sql@sql", port="5433")
connection.autocommit = True
cursor = connection.cursor()

app = FastAPI()

@app.get("/products/")
async def get_recipes() -> m.List[m.Product]:
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

        products.append(m.Product(
            id=id,
            title= title,
            product_type=product_type
        ))
    return products

@app.get("/products/{id}")
async def get_product(id: int) -> m.Product:
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
    return m.Product(
            id=id,
            title= title,
            product_type=product_type
        )

@app.get("/recipes/")
async def get_recipes(products: List[int] = Query(None)) -> List[m.Recipe]:
    if(products == None):
        return db_get_recipes()
    return db_get_filtered_recipes(products)

@app.get("/recipes/{id}")
async def get_recipe(id: int) -> m.DetailRecipe:
    cursor.execute("SELECT * FROM \"Recipe\" Where id = %s", (id,))
    data = cursor.fetchone()
    id, title, cooking_time, kkal, id_CreatorUser = data[:5]
    return m.DetailRecipe(
        id=id,
        title=title,
        cooking_time=cooking_time.strftime("%H:%M:%S"),
        kkal=kkal,
        id_CreatorUser=id_CreatorUser,
        ingredients=get_recipe_ingredients(id),
        recipe_steps=[]
    )

@app.get("/recipes/{id}/ingredients")
async def get_ingredients(id: int) -> List[m.Ingredient]:
    return get_recipe_ingredients(id)

@app.get("/recipes/{id}/steps")
async def get_steps(id: int) -> List[m.RecipeStep]:
    return get_recipe_steps(id)


@app.get("/image/", responses={200: {"content": {"image/jpg": {}}}})
async def get_image():
    return FileResponse("test3.jpg")


@app.post("/upload_image/")
async def upload_image(file: UploadFile = File(...)):
    # Используем httpx для отправки файла на другой сервер
    async with httpx.AsyncClient() as client:
        # Готовим файл для отправки
        # Важно! file.file - это файловый объект, который уже открыт,
        # поэтому мы можем сразу его передать.
        # file.filename дает нам имя файла для использования в форме.
        files = {"file": (file.filename, file.file)}
        # Отправляем файл
        response = await client.post("https://telegra.ph/upload", files=files)

    # Закрываем файл
    await file.close()

    # Возвращаем ответ от внешнего сервера
    return {
        "path":"https://telegra.ph/file/",
        "name":response.json()[0]["src"][6::]
        }


@app.get("/product_types/", response_model=List[m.ProductType])
async def get_product_types() -> List[m.ProductType]:
    cursor.execute("SELECT id, \"Title\" FROM \"ProductType\"")
    product_types_data = cursor.fetchall()
    return [m.ProductType(id=row[0], title=row[1]) for row in product_types_data]


@app.post("/product_types/", response_model=m.ProductType, status_code=status.HTTP_201_CREATED)
async def create_product_type(product_type: m.ProductTypeCreate) -> m.ProductType:
    # Здесь код для добавления записи в базу данных. Псевдокод ниже.
    # Предполагается, что у вас есть функция или метод для добавления записи и получения её ID.
    # Например, используя SQLAlchemy или другой ORM/драйвер базы данных.
    # Например: new_product_type_id = add_product_type_to_db(product_type.title)
    
    # Псевдокод для выполнения запроса. Настоящий код будет зависеть от вашего подключения к БД.
    cursor.execute("INSERT INTO \"ProductType\" (\"Title\") VALUES (%s) RETURNING id", (product_type.title,))
    new_product_type_id = cursor.fetchone()[0]
    
    # Возвращаем созданный ProductType, включая его новый ID.
    return m.ProductType(id=new_product_type_id, title=product_type.title)


@app.get("/check_product_type/")
async def check_product_type(title: str) -> dict:
    cursor.execute("SELECT EXISTS(SELECT 1 FROM \"ProductType\" WHERE \"Title\" = %s)", (title,))
    exists = cursor.fetchone()[0]
    
    if exists:
        return {"exists": True, "message": f"ProductType with title '{title}' already exists."}
    else:
        return {"exists": False, "message": f"ProductType with title '{title}' does not exist."}


@app.post("/product/", response_model=m.ProductModel, status_code=status.HTTP_201_CREATED)
async def create_product(product: m.ProductCreate) -> m.ProductModel:
    # Проверяем, существует ли тип продукта, к которому мы хотим привязать наш продукт
    cursor.execute("SELECT EXISTS(SELECT 1 FROM \"ProductType\" WHERE id = %s)", (product.id_productType,))
    exists = cursor.fetchone()[0]
    
    if not exists:
        raise HTTPException(status_code=404, detail="ProductType not found")
    
    # Добавляем продукт в базу данных
    cursor.execute("INSERT INTO \"Product\" (\"id_productType\", \"Title\") VALUES (%s, %s) RETURNING id", (product.id_productType, product.title))
    new_product_id = cursor.fetchone()[0]
    connection.commit()  # Не забудьте подтвердить транзакцию, если используете транзакции

    # Возвращаем созданный продукт
    return m.ProductModel(id=new_product_id, id_productType=product.id_productType, title=product.title)

@app.post("/products/", response_model=List[m.ProductModel], status_code=status.HTTP_201_CREATED)
async def create_products(products: List[m.ProductCreate]) -> List[m.ProductModel]:
    created_products = []
    for product in products:
        # Проверяем, существует ли тип продукта, к которому мы хотим привязать наш продукт
        cursor.execute("SELECT EXISTS(SELECT 1 FROM \"ProductType\" WHERE id = %s)", (product.id_productType,))
        exists = cursor.fetchone()[0]
        
        if not exists:
            raise HTTPException(status_code=404, detail=f"ProductType with id {product.id_productType} not found")
        
        # Добавляем продукт в базу данных
        cursor.execute("INSERT INTO \"Product\" (\"id_productType\", \"Title\") VALUES (%s, %s) RETURNING id", (product.id_productType, product.title))
        new_product_id = cursor.fetchone()[0]
        created_products.append(m.ProductModel(id=new_product_id, id_productType=product.id_productType, title=product.title))
        
    connection.commit()  # Подтверждаем транзакцию после добавления всех продуктов

    return created_products


@app.post("/recipes/", response_model=m.RecipeModel, status_code=status.HTTP_201_CREATED)
async def create_recipe(recipe_data: m.RecipeCreate) -> m.RecipeModel:
    # Добавление рецепта в базу данных с новыми полями
    cursor.execute(
        "INSERT INTO \"Recipe\" (title, image_url, cooking_time, kkal, \"id_CreatorUser\") VALUES (%s, %s, %s, %s, %s) RETURNING id", 
        (recipe_data.title, recipe_data.imageUrl, recipe_data.cookingTime, recipe_data.calories, recipe_data.creatorUserId)
    )
    new_recipe_id = cursor.fetchone()[0]
    
    # Добавление ингредиентов рецепта
    for ingredient in recipe_data.ingredients:
        cursor.execute(
            "INSERT INTO \"RecipeIngredient\" (\"id_Product\", \"id_Recipe\", \"id_MeasureType\", count) VALUES (%s, %s, %s, %s)", 
            (ingredient.productId, new_recipe_id, ingredient.measureTypeId, ingredient.quantity)
        )
    
    # Добавление шагов приготовления
    for step_index, step in enumerate(recipe_data.steps, start=1):
        cursor.execute(
            "INSERT INTO \"CookStep\" (\"id_Recipe\", step_num, step_text, step_image) VALUES (%s, %s, %s, %s)", 
            (new_recipe_id, step_index, step.text, step.imageUrl)
        )

    connection.commit()
    
    # Возвращаем модель созданного рецепта. Необходимо определить RecipeModel, которая будет включать все поля рецепта.
    return m.RecipeModel(
        id=new_recipe_id,
        title=recipe_data.title,
        imageUrl=recipe_data.imageUrl,
        cookingTime=recipe_data.cookingTime,
        calories=recipe_data.calories,
        creatorUserId=recipe_data.creatorUserId,
        ingredients=recipe_data.ingredients,
        steps=recipe_data.steps
    )

@app.post("/users/", status_code=status.HTTP_201_CREATED)
async def create_user(user_data: m.UserCreate):
    # Добавляем пользователя в базу данных
    cursor.execute(
        "INSERT INTO \"User\" (\"id_userRole\", name, region, birth_date, created_date) VALUES (%s, %s, %s, %s, %s) RETURNING id", 
        (user_data.id_userRole, user_data.name, user_data.region, user_data.birth_date, user_data.created_date)
    )
    new_user_id = cursor.fetchone()[0]
    connection.commit()
    
    # Возвращаем ID созданного пользователя
    return {"id": new_user_id, "name": user_data.name}

@app.post("/user_roles/", status_code=status.HTTP_201_CREATED)
async def create_user_role(role_data: m.UserRoleCreate):
    # Добавляем роль пользователя в базу данных
    cursor.execute(
        "INSERT INTO \"UserRole\" (title) VALUES (%s) RETURNING id", 
        (role_data.title,)
    )
    new_role_id = cursor.fetchone()[0]
    connection.commit()
    
    # Возвращаем ID и название созданной роли пользователя
    return {"id": new_role_id, "title": role_data.title}

@app.get("/users/", response_model=List[m.User])
async def list_users():
    cursor.execute("SELECT id, id_userRole, name, region, birth_date, created_date FROM \"User\"")
    users_data = cursor.fetchall()
    users = [m.User(id=row[0], id_userRole=row[1], name=row[2], region=row[3], birth_date=row[4], created_date=row[5]) for row in users_data]
    return users


@app.get("/user_roles/", response_model=List[m.UserRole])
async def list_user_roles():
    cursor.execute("SELECT id, title FROM \"UserRole\"")
    roles_data = cursor.fetchall()
    roles = [m.UserRole(id=row[0], title=row[1]) for row in roles_data]
    return roles





def db_get_recipes() -> List[m.Recipe]:
    cursor.execute("SELECT * FROM \"Recipe\";")
    data = cursor.fetchall()
    recipes = []
    for recipe_data in data:
        id, title, cooking_time, kkal, id_CreatorUser = recipe_data[:5]

        recipes.append(m.Recipe(
            id=id,
            title= title,
            cooking_time= cooking_time.strftime("%H:%M:%S"),
            kkal= kkal,
            id_CreatorUser= id_CreatorUser,
            ingredients= get_recipe_ingredients(id)
        ))
    return recipes

def db_get_filtered_recipes(id_products: List[int]) -> List[m.Recipe]:
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

        recipes.append(m.Recipe(
            id=id,
            title= title,
            cooking_time= cooking_time.strftime("%H:%M:%S"),
            kkal= kkal,
            id_CreatorUser= id_CreatorUser,
            ingredients= get_recipe_ingredients(id)
        ))
    return recipes

def get_recipe_steps(recipe_id: int) -> List[m.RecipeStep]:
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
        steps.append(m.RecipeStep(
            step_num=step_num,
            step_text=step_text,
            step_image=step_image
        ))
    return steps



def get_recipe_ingredients(recipe_id: int) -> List[m.Ingredient]:
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
        ingredients.append(m.Ingredient(
            id=id,
            title=title,
            count= count,
            measureType=measureType_title
        ))
    return ingredients


