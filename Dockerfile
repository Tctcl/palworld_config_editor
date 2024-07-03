FROM python:3-alpine

LABEL org.opencontainers.image.source="https://github.com/Tctcl/palworld_config_editor"

RUN apk add --virtual .build-dependencies \
            --no-cache \
            python3-dev \
            build-base \
            linux-headers \
            pcre-dev

RUN apk add --no-cache pcre

WORKDIR /app
COPY /app /app
COPY ./requirements.txt /app

RUN pip install -r /app/requirements.txt

RUN apk del .build-dependencies && rm -rf /var/cache/apk/*

EXPOSE 80
CMD ["uwsgi", "--ini", "/app/wsgi.ini"]