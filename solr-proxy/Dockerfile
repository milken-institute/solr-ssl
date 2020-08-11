FROM nginx:mainline-perl
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp

RUN mkdir -p /var/www/public;

RUN apt-get update -y --fix-missing && apt-get install -y \
      gnupg2 \
      curl

RUN curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list

RUN apt-get update -y --fix-missing && apt-get install -y \
      syncthing \
      supervisor \
      gvfs \
      vim \
      procps \
      apt-utils \
      zip \
      unzip \
      xvfb \
      libxi6 \
      libgconf-2-4 \
      gnupg2 \
      google-chrome-stable \
      iputils-ping

# copy operations must copy at least one file
# optionally copy the live certs if they exist
ADD ./dummy.txt cert.* /etc/ssl/certs/
ADD ./dummy.txt privkey.* /etc/ssl/private/
# the entryfile will rename them correctly


RUN cp /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.dist
COPY solr-proxy.conf /etc/nginx/conf.d/default.conf
COPY fastcgi_params /etc/nginx/fastcgi_params

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

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

EXPOSE 8483

COPY milken.conf /etc/supervisor/conf.d/milken.conf

STOPSIGNAL SIGTERM

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "/usr/bin/supervisord" ]
