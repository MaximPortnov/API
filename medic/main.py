from fastapi import FastAPI
from fastapi import HTTPException
import psycopg2
from pydantic import BaseModel, validator
from datetime import date
from typing import List, Optional

# uvicorn main:app --reload --host localhost --port 3426

MAX_LENGTH = 256 

connection = psycopg2.connect(dbname="medic", host="postgres", user="postgres", password="sql@sql", port="5432")
connection.autocommit = True
cursor = connection.cursor()

app = FastAPI()

class User(BaseModel):
    id: int
    email: str
    first_name: str
    last_name: str
    patronymic: int
    date_of_birth: date
    gender: str

class UserRegistration(BaseModel):
    email: str
    first_name: str
    last_name: str
    patronymic: str
    date_of_birth: date
    gender: str

    @validator('gender')
    def gender_validator(cls, v):
        if v not in ['male', 'female', 'other']:
            raise ValueError('Gender must be male, female, or other')
        return v

class UserUpdate(BaseModel):
    first_name: str
    last_name: str
    patronymic: str
    date_of_birth: date
    gender: str

class AnalysisGet(BaseModel):
    id: int
    name: str
    cost: float
    days_to_result: int
    description: str
    preparation: str
    biomaterial: str

class AddressCreate(BaseModel):
    address: str
    longitude: Optional[float] = None
    latitude: Optional[float] = None
    elevation: Optional[float] = None
    apartment: str
    entrance: str
    floor: int
    intercom: Optional[str] = None

class AnalysisOrder(BaseModel):
    analysis_id: int
    user_id: int 

class OrderCreate(BaseModel):
    user_id: int
    address_id: int
    order_datetime: date
    phone_number: str
    comment: Optional[str] = None
    analysis_orders: List[AnalysisOrder]

@app.post("/signup/")
async def signup(user_data: UserRegistration):
    # Проверка на существование пользователя с таким же email
    cursor.execute("SELECT COUNT(*) FROM Users WHERE Email = %s", (user_data.email,))
    if cursor.fetchone()[0] > 0:
        raise HTTPException(status_code=400, detail="Пользователь с таким email уже существует")
    
    # Вставка нового пользователя в базу данных и возвращение ID
    cursor.execute(
        "INSERT INTO Users (Email, FirstName, LastName, Patronymic, DateOfBirth, Gender) VALUES (%s, %s, %s, %s, %s, %s) RETURNING ID",
        (user_data.email, user_data.first_name, user_data.last_name, user_data.patronymic, user_data.date_of_birth, user_data.gender)
    )
    user_id = cursor.fetchone()[0]  # Получение возвращенного ID нового пользователя

    return {"message": "Пользователь успешно зарегистрирован", "user_id": user_id}


@app.get("/users/")
async def get_all_users():
    cursor.execute("SELECT Email, FirstName, LastName, Patronymic, DateOfBirth, Gender FROM Users")
    users_data = cursor.fetchall()
    users = [
        {"Email": user[0], "FirstName": user[1], "LastName": user[2], "Patronymic": user[3], "DateOfBirth": user[4], "Gender": user[5]}
        for user in users_data
    ]
    return users

@app.put("/user/{user_id}/")
async def update_user(user_id: int, user_data: UserUpdate):
    # Проверка существования пользователя
    cursor.execute("SELECT COUNT(*) FROM Users WHERE ID = %s", (user_id,))
    if cursor.fetchone()[0] == 0:
        raise HTTPException(status_code=404, detail="Пользователь не найден")

    # Обновление данных пользователя
    cursor.execute("""
        UPDATE Users SET
        FirstName = %s,
        LastName = %s,
        Patronymic = %s,
        DateOfBirth = %s,
        Gender = %s
        WHERE ID = %s
    """, (user_data.first_name, user_data.last_name, user_data.patronymic, user_data.date_of_birth, user_data.gender, user_id))

    return {"message": "Данные пользователя успешно обновлены"}

@app.get("/user/{user_id}/")
async def get_user(user_id: int):
    cursor.execute("SELECT ID, Email, FirstName, LastName, Patronymic, DateOfBirth, Gender FROM Users WHERE ID = %s", (user_id,))
    user = cursor.fetchone()
    if user is None:
        raise HTTPException(status_code=404, detail="Пользователь не найден")
    
    return {
        "id": user[0],
        "email": user[1],
        "first_name": user[2],
        "last_name": user[3],
        "patronymic": user[4],
        "date_of_birth": user[5],
        "gender": user[6]
    }

@app.get("/analyses/", response_model=List[AnalysisGet])
async def get_all_analyses():
    cursor.execute("SELECT ID, Name, Cost, DaysToResult, Description, Preparation, Biomaterial FROM Analysis")
    analyses_data = cursor.fetchall()
    analyses = [
        AnalysisGet(
            id=analysis[0],
            name=analysis[1],
            cost=analysis[2],
            days_to_result=analysis[3] if analysis[3] is not None else 0, 
            description=analysis[4] if analysis[4] is not None else "", 
            preparation=analysis[5] if analysis[5] is not None else "", 
            biomaterial=analysis[6]
        ) for analysis in analyses_data
    ]
    return analyses

@app.post("/addresses/")
async def create_address(address: AddressCreate):
    # Здесь должна быть логика для вставки данных в базу данных
    cursor.execute(
        """
        INSERT INTO Addresses (Address, Longitude, Latitude, Elevation, Apartment, Entrance, Floor, Intercom) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING ID
        """,
        (address.address, address.longitude, address.latitude, address.elevation, address.apartment, address.entrance, address.floor, address.intercom)
    )
    address_id = cursor.fetchone()[0]
    return {"message": "Адрес успешно добавлен", "address_id": address_id}

@app.post("/orders/")
async def create_order(order_data: OrderCreate):
    # Вставка данных о заказе в таблицу Orders и получение ID нового заказа
    cursor.execute(
        "INSERT INTO Orders (UserID, AddressID, OrderDatetime, PhoneNumber, Comment, TotalAmount) VALUES (%s, %s, NOW(), %s, %s, 0) RETURNING ID",
        (order_data.user_id, order_data.address_id, order_data.phone_number, order_data.comment)
    )
    order_id = cursor.fetchone()[0]

    # Вставка связей между заказом и анализами в таблицу AnalysisOrders
    for analysis_order in order_data.analysis_orders:
        cursor.execute(
            "INSERT INTO AnalysisOrders (AnalysisID, UserID, OrderID) VALUES (%s, %s, %s)",
            (analysis_order.analysis_id, order_data.user_id, order_id)
        )
    
    # Здесь можно добавить логику расчёта TotalAmount на основе стоимости анализов, если это необходимо

    return {"message": "Заказ успешно оформлен", "order_id": order_id}