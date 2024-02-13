from fastapi import FastAPI, Request
from fastapi import HTTPException
import psycopg2
from pydantic import BaseModel
import secrets

MAX_LENGTH = 256

connection = psycopg2.connect(dbname="taxi", host="postgres", user="postgres", password="sql@sql", port="5432")
connection.autocommit = True
cursor = connection.cursor()

app = FastAPI()


class SignupUser(BaseModel):
    username: str
    password: str
    email: str


class LoginUser(BaseModel):
    username: str
    password: str


class LogoutUser(BaseModel):
    username: str


def user_exists(username: str, email: str):
    cursor.execute('SELECT EXISTS(SELECT 1 FROM public."Users" WHERE "UserName" = %s OR "Email" = %s)',
                   (username, email))
    exists = cursor.fetchone()[0]
    return exists


def username_exists(username):
    sql = """
    SELECT EXISTS(SELECT 1 FROM public."Users" WHERE "UserName" = %s)
    """
    cursor.execute(sql, (username,))
    exists = cursor.fetchone()[0]
    return exists


def getToken():
    pass


def clearToken():
    pass


@app.post("/login/")
def login(LoginData: LoginUser):
    username = LoginData.username
    password = LoginData.password

    user_data = get_user_by_username(username)
    if user_data is None:
        raise HTTPException(status_code=400,
                            detail="Пользователь с указанным именем пользователя или адресом электронной почты не найден")
    if password != user_data[3]:
        raise HTTPException(status_code=400, detail="Неверный пароль")

    token = generate_token()

    update_user_login_and_token(username, True, token)

    return {"notice": {"token": token}}


def generate_token():
    return secrets.token_hex(16)


def get_user_by_username(username):
    sql = f"""
    SELECT "UserID", "UserName", "Email", "Password", "Login", "Token"
    FROM public."Users"
    WHERE "UserName" = '{username}'
    """
    cursor.execute(sql)
    user_data = cursor.fetchone()
    return user_data


def update_user_login_and_token(username, login, token):
    sql = """
    UPDATE public."Users"
    SET "Login" = %s, "Token" = %s
    WHERE "UserName" = %s
    """
    cursor.execute(sql, (login, token, username))


@app.post("/logout/")
def logout(LogoutData: LogoutUser):
    username = LogoutData.username
    if not username_exists(username):
        raise HTTPException(status_code=404, detail="Пользователь не найден")
    update_user_login_and_token(username, False, "")
    return {"message": "Вы успешно вышли из системы"}


@app.post("/signup/")
def signup(SignupData: SignupUser):
    if len(SignupData.username) > MAX_LENGTH:
        raise HTTPException(status_code=400, detail=f"Длина имени пользователя должна быть меньше {MAX_LENGTH}")

    # Проверка длины адреса электронной почты
    if len(SignupData.email) > MAX_LENGTH:
        raise HTTPException(status_code=400, detail=f"Длина адреса электронной почты должна быть меньше {MAX_LENGTH}")

    # Проверка длины пароля
    if len(SignupData.password) > MAX_LENGTH:
        raise HTTPException(status_code=400, detail=f"Длина пароля должна быть меньше {MAX_LENGTH}")

    if user_exists(SignupData.username, SignupData.email):
        raise HTTPException(status_code=400,
                            detail="Пользователь с таким именем пользователя или адресом электронной почты уже существует")

    cursor.execute('SELECT COALESCE(MAX("UserID"), 1) AS last_user_id FROM public."Users";')
    last_user_id = cursor.fetchone()[0]
    sql = """
    INSERT INTO public."Users" ("UserID", "UserName", "Email", "Password", "Login", "Token")
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    user_data_to_insert = (last_user_id + 1, SignupData.username, SignupData.email, SignupData.password, False, "")
    cursor.execute(sql, user_data_to_insert)
    return {"message": "Пользователь успешно зарегистрирован"}


# if __name__ == "__main__":
    # import uvicorn

    # uvicorn.run(app, host="0.0.0.0", port=3425)
