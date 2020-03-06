#!/bin/bash

set -e

export PASSWORD=""

## if the actual certs don't exist, copy the self-signed ones so nginx can still start
if [ -f "/etc/ssl/certs/cert.pem" ]; then
    cp /etc/ssl/certs/cert.pem /etc/ssl/certs/reapbooster-cert.pem
  else
    openssl x509 -in /etc/ssl/certs/nginx-selfsigned.crt -out /etc/ssl/certs/reapbooster-cert.pem
fi

if [ -f "/etc/ssl/private/privkey.pem" ]; then
    cp /etc/ssl/private/privkey.pem /etc/ssl/private/reapbooster-privkey.pem
  else
    openssl pkcs12 -export -in /etc/ssl/certs/nginx-selfsigned.crt \
     -nodes \
     -inkey /etc/ssl/private/nginx-selfsigned.key \
     -out /etc/ssl/private/nginx-selfsigned.p12 \
     -password pass:${PASSWORD}
    openssl pkcs12 -in /etc/ssl/private/nginx-selfsigned.p12 \
     -nodes \
     -password pass:${PASSWORD} \
     -out /etc/ssl/private/reapbooster-privkey.pem
fi

/usr/bin/supervisord
