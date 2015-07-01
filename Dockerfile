FROM python:2.7

RUN apt-get update && apt-get install -y rabbitmq-server nginx

RUN mkdir -p /var/gunery/
ADD . /var/gunnery/

# RUN pip install -r /var/gunnery/requirements/production.txt

WORKDIR /var/gunnery/gunnery/

ENV DJANGO_SETTINGS_MODULE="gunnery.settings.production"
ENV SECRET_KEY="408372hg857k274hm8xrf2v7f4yvk9d8"

# RUN python manage.py syncdb
# RUN python manage.py migrate
# RUN python manage.py collectstatic
# RUN python manage.py createsuperuser

RUN useradd celery

RUN cp ../etc/celery.initd /etc/init.d/
RUN cp ../etc/celery.default /etc/default/

# RUN service celeryd start

RUN cp ../etc/uwsgi /etc/init.d/
RUN chmod u+x /etc/init.d/uwsgi

RUN mkdir -p /etc/uwsgi/apps-enabled
RUN cp ../etc/uwsgi.ini /etc/uwsgi/apps-enabled/gunnery.ini

# RUN service uwsgi start

RUN rm -rf /etc/nginx/sites-enabled/default
RUN cp ../etc/nginx.django.conf /etc/nginx/sites-enabled/gunnery

RUN service nginx reload

COPY etc/entrypoint.sh /

ENTRYPOINT ['/entrypoint.sh']
