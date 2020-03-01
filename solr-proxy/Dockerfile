FROM nginx:alpine

COPY solr-proxy.conf /etc/nginx/conf.d/default.conf

USER root

RUN apk add openssl; \ 
    openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -subj "/C=US/ST=CA/O=Milken Institute/CN=milken-dev.reapbooster.com" \
    -addext "subjectAltName=DNS:milken-dev.reapbooster.com" \
    -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt;

