#!/bin/bash
set -e

if [ "$1" = 'supervisord' ]; then
    python manage.py syncdb
    python manage.py migrate
    python manage.py collectstatic --noinput

    /etc/init.d/nginx restart
fi


exec "$@"
