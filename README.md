📧 Flutter Email Service

A full-stack email notification and data-logging system built using Flutter, Python, and SQL.
The Flutter app collects user data → sends it to the backend → backend stores it in the database → SQL trigger automatically sends an email using the Python worker.

🚀 Features
📱 Flutter Frontend

Clean & responsive UI

User form for email + data

Sends data to Python API

Works on Android, Web, Windows

🐍 Python Backend

Handles API requests

Inserts data into SQL database

Python worker sends email using SMTP

Uses environment variables for security

HTML templates supported

🗄️ SQL Database

Stores email + form data

Trigger-based email system

Automatically notifies backend worker

Ensures reliable delivery and logging

📂 Project Structure
flutter-email-service/
│── lib/                
│── web/
│── android/
│── ios/
│── windows/

│── python_backend/
│     │── main.py          # API
│     │── email_worker.py  # Email sending worker
│     │── requirements.txt
│     │── templates/       
│     │── database.sql     
│     │── .env (ignored)

│── pubspec.yaml
│── README.md

🔧 Backend Setup
Install dependencies
cd python_backend
pip install -r requirements.txt

Create .env
EMAIL=your_email
APP_PASSWORD=your_app_password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=email_service

Import SQL
SOURCE database.sql;

Run backend
python main.py

▶️ Flutter Setup
flutter pub get
flutter run

🧪 How System Works

Flutter sends form data → Backend

Backend inserts into SQL

SQL trigger notifies worker

Worker sends email using SMTP

Response returned to app

🔐 Security

.env ignored

venv ignored

DB passwords not pushed

🤝 Contributing

Feel free to fork & contribute to backend, SQL or UI.
