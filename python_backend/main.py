from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.templating import Jinja2Templates
import mysql.connector
from dotenv import load_dotenv
import os

# Load templates folder
templates = Jinja2Templates(directory="templates")

# Load .env file
load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_NAME = os.getenv("DB_NAME")

app = FastAPI()

# Allow Flutter
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

def get_db():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME
    )

@app.post("/save_user")
async def save_user(request: Request):
    data = await request.json()

    name = data["name"]
    email = data["email"]

    # Render welcome.html with name
    template = templates.get_template("welcome.html")
    rendered_html = template.render(name=name)

    # FIXED — Create DB connection
    db = get_db()
    cursor = db.cursor()

    cursor.execute("""
        INSERT INTO email_queue (email, subject, message)
        VALUES (%s, %s, %s)
    """, (email, "Welcome to WTWinds!", rendered_html))

    db.commit()
    cursor.close()
    db.close()

    return {"status": "success", "message": "User saved & email queued."}
