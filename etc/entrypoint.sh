#!/bin/bash
set -e

if [ "$1" = 'uwsgi' ]; then
    python manage.py syncdb
    python manage.py migrate
    python manage.py collectstatic --noinput
fi

/etc/init.d/nginx restart

exec "$@"
