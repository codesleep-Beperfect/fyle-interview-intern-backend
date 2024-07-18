::!/bin/bash

:: to stop on first error
::set -e
@echo off
:: Delete older .pyc files
:: find . -type d \( -name env -o -name venv  \) -prune -false -o -name "*.pyc" -exec rm -rf {} \;

:: Run required migrations
set FLASK_APP=core.server.py
 ::flask db init -d core/migrations/
 ::flask db migrate -m "Initial migration." -d core/migrations/
::flask db upgrade -d core/migrations/

:: Run server
::Run the Flask application with Waitress
waitress-serve  --host=0.0.0.0 --port=7755 core.server:app        
::gunicorn -c gunicorn_config.py core.server:app  
