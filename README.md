# solr-ssl
Solr server for Drupal with SSL through Nginx

```bash
cp .env.dist .env

cp /etc/letsencrypt/live/milken-dev.reapbooster.com/cert.pem solr-proxy/cert.pem
cp /etc/letsencrypt/live/milken-dev.reapbooster.com/privkey.pem solr-proxy/privkey.pem

docker-compose down && docker system prune --all -f && docker-compose up -d

```
