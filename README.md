<<<<<<< HEAD
<<<<<<< HEAD
# email

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# flutter-email-service
=======
📧 Flutter Email Service

>>>>>>> 23ea724314b0dc280e5059a53c4f490e8f7b8801
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

<<<<<<< HEAD
Feel free to fork and contribute improvements to backend, SQL, or Flutter app.
>>>>>>> 2a13b9fcaab03e80964b8c596366f76c1a2e8b32
=======
Feel free to fork & contribute to backend, SQL or UI.
>>>>>>> 23ea724314b0dc280e5059a53c4f490e8f7b8801
