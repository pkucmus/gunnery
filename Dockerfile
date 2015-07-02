FROM python:2.7

MAINTAINER Paweł Kucmus <pkucmus@gmail.com>

RUN apt-get update && apt-get install -y nginx postgresql-client

COPY etc/nginx /etc/nginx/conf.d


RUN mkdir -p /var/gunnery/
RUN mkdir -p /var/gunnery/log/
RUN mkdir -p /var/gunnery/run/
ADD . /var/gunnery/

RUN pip install -r /var/gunnery/requirements/docker.txt

WORKDIR /var/gunnery/gunnery/

ENV DJANGO_SETTINGS_MODULE="gunnery.settings.production"
ENV SECRET_KEY="408372hg857k274hm8xrf2v7f4yvk9d8"

RUN mkdir -p /etc/uwsgi/apps-enabled
RUN cp ../etc/uwsgi.ini /etc/uwsgi/apps-enabled/gunnery.ini

COPY etc/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN rm /etc/nginx/sites-enabled/default

RUN /etc/init.d/nginx restart

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8000

CMD ["uwsgi", "--emperor", "/etc/uwsgi/apps-enabled/gunnery.ini"]
