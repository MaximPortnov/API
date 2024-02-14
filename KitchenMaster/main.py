from fastapi import FastAPI, Request
from fastapi import HTTPException
import psycopg2
from pydantic import BaseModel, validator
import secrets
from datetime import date
from typing import List, Optional

MAX_LENGTH = 256
# uvicorn main:app --reload --host localhost --port 3426
connection = psycopg2.connect(dbname="KitchenMaster", host="185.221.214.178", user="dimon", password="dimon@s@ql", port="5432")
connection.autocommit = True
cursor = connection.cursor()

app = FastAPI()

@app.post("/signup/")
def signup():
    # Выполнение запроса к базе данных
    cursor.execute("""
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema = 'public'
        ORDER BY table_name;
    """)
    tables = cursor.fetchall()  # Получение всех строк результатов запроса

    # Преобразование результатов в словарь для ответа
    res = {"tables": [table[0] for table in tables]}  # Создание списка имен таблиц

    return {"message": "Пользователь успешно зарегистрирован", "tables": res}