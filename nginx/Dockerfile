FROM nginx:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y openssl apache2-utils

COPY config/entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/etc/nginx/conf.d"]

ENV NGINX_NAME="one" \
    NGINX_PWD="two"

ENTRYPOINT [ "/entrypoint.sh" ]
