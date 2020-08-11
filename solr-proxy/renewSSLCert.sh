docker cp /etc/letsencrypt/live/milken-dev.reapbooster.com/cert.pem milkensolr-nginx:/etc/ssl/certs/nginx-selfsigned.crt
docker cp /etc/letsencrypt/live/milken-dev.reapbooster.com/privkey.pem milkensolr-nginx:/etc/ssl/private/nginx-selfsigned.key
