FROM python:3.5.2

WORKDIR /app

COPY backend/requirements.txt ./requirements.txt

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn==20.1.0 \
    && pip install --no-cache-dir psycopg2-binary==2.8.6

COPY backend/ /app/
COPY docker/backend/settings_docker.py /app/conduit/settings_docker.py
COPY docker/backend/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]