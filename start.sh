#! /usr/bin/env bash
set -eu
if [ ${MODE:-""} == "development" ]; then 
    if [ -f /app/requirements.txt ]; then pip install -r /app/requirements.txt; fi
    exec flask --app web.py run --debug --port 80 --host "0.0.0.0"
else 
    exec gunicorn 'web:app' -b '0.0.0.0:80' --pythonpath "/usr/src/app:/app" --timeout 100
fi
