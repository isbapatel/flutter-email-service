import time
import mysql.connector
from mysql.connector import Error
import yagmail
from dotenv import load_dotenv
import os

# Load environment variables from .env
load_dotenv()

DB_HOST = os.getenv("DB_HOST")
DB_USER = os.getenv("DB_USER")
DB_PASS = os.getenv("DB_PASS")
DB_NAME = os.getenv("DB_NAME")

EMAIL_SENDER = os.getenv("EMAIL_SENDER")
EMAIL_APP_PASSWORD = os.getenv("EMAIL_APP_PASSWORD")

def get_db():
    return mysql.connector.connect(
        host=DB_HOST,
        user=DB_USER,
        password=DB_PASS,
        database=DB_NAME
    )

print("Email worker started...")

while True:
    try:
        db = get_db()
        cursor = db.cursor(dictionary=True)

        cursor.execute("SELECT * FROM email_queue WHERE status='pending'")
        emails = cursor.fetchall()

        if not emails:
            print("No pending emails...")
        else:
            print(f"Found {len(emails)} pending emails")

        for email in emails:
            print(f"Sending email to {email['email']}")

            yag = yagmail.SMTP(EMAIL_SENDER, EMAIL_APP_PASSWORD)
            yag.send(
                to=email["email"],
                subject=email["subject"],
                contents=email["message"]
            )

            cursor.execute(
                "UPDATE email_queue SET status='sent' WHERE id=%s",
                (email["id"],)
            )
            db.commit()

        cursor.close()
        db.close()

    except Exception as e:
        print("Worker error:", e)

    time.sleep(3)
