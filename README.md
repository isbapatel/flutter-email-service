# flutter-email-service
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

Automatically calls backend worker

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
│     │── templates/       # Email HTML templates
│     │── database.sql     # Tables + triggers (your file)
│     │── .env             # ignored

│── pubspec.yaml
│── README.md

🔧 Backend Setup
1️⃣ Install dependencies
cd python_backend
pip install -r requirements.txt

2️⃣ Configure .env
EMAIL=your_email
APP_PASSWORD=your_app_password
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=email_service

3️⃣ Import SQL file

Run in your SQL client (MySQL/SQL Server/PostgreSQL depending on your setup):

SOURCE database.sql;


This will:
✔ Create tables
✔ Create SQL trigger
✔ Link to backend workflow

4️⃣ Run backend
python main.py

▶️ Flutter Setup
flutter pub get
flutter run

🧪 How the System Works
1. Flutter App → Backend

User submits form → Flutter sends JSON to Python API.

2. Backend → SQL Database

Python inserts the data into database.

3. SQL Trigger → Python Worker

SQL trigger runs automatically and notifies the backend worker.

4. Email Sent

Python worker reads the entry → sends email using SMTP.

5. Response → App

Backend returns success message to Flutter.

🔐 Security

.env and venv/ are ignored

Database credentials not pushed to GitHub

Email handled through secure app passwords

🤝 Contributing

Feel free to fork and contribute improvements to backend, SQL, or Flutter app.
