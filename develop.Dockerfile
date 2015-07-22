FROM python:2.7

MAINTAINER Paweł Kucmus <pkucmus@gmail.com>

ADD ./requirements/ /var/gunnery/requirements/

RUN pip install -r /var/gunnery/requirements/development.txt


RUN mkdir -p /var/gunnery/gunnery/
WORKDIR /var/gunnery/gunnery/

ENV DJANGO_SETTINGS_MODULE="gunnery.settings.development"
ENV SECRET_KEY="408372hg857k274hm8xrf2v7f4yvk9d8"

ENTRYPOINT ["python", "manage.py"]
CMD ["runserver", "0.0.0.0:8000"]
