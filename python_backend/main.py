from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import mysql.connector
from mysql.connector import Error
from dotenv import load_dotenv
import os

load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_NAME = os.getenv("DB_NAME")

app = FastAPI()   # ← THIS MUST EXIST

def get_db_connection():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME
    )

class RegisterData(BaseModel):
    name: str
    email: str

@app.post("/register")
def register_user(data: RegisterData):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        sql = "INSERT INTO users (name, email) VALUES (%s, %s)"
        cursor.execute(sql, (data.name, data.email))
        conn.commit()

        cursor.close()
        conn.close()

        return {"message": "User registered! Email will be sent automatically"}

    except Error as e:
        raise HTTPException(status_code=500, detail=str(e))
