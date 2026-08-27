FROM nginx:1.27-alpine

ARG APP_VERSION=local

COPY index.html /usr/share/nginx/html/index.html

RUN sed -i "s/__APP_VERSION__/${APP_VERSION}/g" /usr/share/nginx/html/index.html

EXPOSE 80
