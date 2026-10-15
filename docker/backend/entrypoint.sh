#!/bin/sh

set -e

# Use the Docker-specific Django settings
export DJANGO_SETTINGS_MODULE=conduit.settings_docker

# Wait until PostgreSQL is reachable
echo "Waiting for PostgreSQL..."

until python -c "import os, socket; s = socket.create_connection((os.getenv('POSTGRES_HOST', 'db'), int(os.getenv('POSTGRES_PORT', '5432'))), timeout=2); s.close()" 2>/dev/null; do
    sleep 2
done

echo "PostgreSQL is reachable."

# Apply database migrations
python manage.py migrate

# Start the Django application
exec gunicorn conduit.wsgi:application \
    --bind 0.0.0.0:8000