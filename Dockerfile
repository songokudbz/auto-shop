FROM nginx:alpine

MAINTAINER madaras_adrian@yahoo.com

COPY deployment/nginx.conf /etc/nginx/nginx.conf

WORKDIR /usr/share/nginx/html
COPY dist/terraform/ .
