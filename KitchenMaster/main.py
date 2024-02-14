from fastapi import FastAPI, Request
from fastapi import HTTPException
import psycopg2
from pydantic import BaseModel, validator
import secrets
from datetime import date
from typing import List, Optional

MAX_LENGTH = 256

connection = psycopg2.connect(dbname="medic", host="185.221.214.178", user="dimon", password="dimon@s@ql", port="5432")
connection.autocommit = True
cursor = connection.cursor()

app = FastAPI()

