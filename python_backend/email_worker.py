import time
import mysql.connector
import yagmail
from dotenv import load_dotenv
import os

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
        rows = cursor.fetchall()

        print(f"Found {len(rows)} pending emails")

        for row in rows:
            email = row["email"]
            subject = row["subject"]
            message = row["message"]

            print(f"Sending email to {email}")

            try:
                yag = yagmail.SMTP(EMAIL_SENDER, EMAIL_APP_PASSWORD)
                yag.send(to=email, subject=subject, contents=message)

                cursor.execute("UPDATE email_queue SET status='sent' WHERE id=%s", (row["id"],))
                db.commit()

                print("Email sent!")

            except Exception as e:
                print("Email send error:", e)
                cursor.execute("UPDATE email_queue SET status='failed' WHERE id=%s", (row["id"],))
                db.commit()

        time.sleep(5)

    except KeyboardInterrupt:
        print("Stopping worker...")
        break
