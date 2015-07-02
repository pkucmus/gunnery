FROM python:2.7

MAINTAINER Paweł Kucmus <pkucmus@gmail.com>

RUN apt-get update && apt-get install -y nginx supervisor

RUN mkdir -p /var/gunnery/gunnery/
RUN mkdir -p /var/gunnery/log/
RUN mkdir -p /var/gunnery/run/
RUN mkdir -p /var/gunnery/secure/

ADD ./gunnery/ /var/gunnery/gunnery/
ADD ./requirements/ /var/gunnery/requirements/

RUN pip install -r /var/gunnery/requirements/production.txt

WORKDIR /var/gunnery/gunnery/

ENV DJANGO_SETTINGS_MODULE="gunnery.settings.production"
ENV SECRET_KEY="408372hg857k274hm8xrf2v7f4yvk9d8"

RUN mkdir -p /etc/uwsgi/apps-enabled
COPY etc/uwsgi.ini /etc/uwsgi/apps-enabled/gunnery.ini

COPY etc/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY etc/nginx /etc/nginx/conf.d
RUN rm /etc/nginx/sites-enabled/default
RUN /etc/init.d/nginx restart

COPY etc/supervisord.conf /etc/supervisor/conf.d/gunnery.conf

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000

CMD ["supervisord", "-n"]
