#!/bin/sh

set -e

exec gunicorn conduit.wsgi:application \
    --bind 0.0.0.0:8000
    