FROM phusion/baseimage:latest

ARG FILEBEAT_VERSION=9.0.1
ARG WAZUH_VERSION=4.12.0-1

ENV API_USER="one" \
    API_PASS="two"

# Set repositories.
RUN set -x && \
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee /etc/apt/sources.list.d/wazuh.list && \
    curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add - && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    echo "postfix postfix/mailname string wazuh-manager" | debconf-set-selections && \
    echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections && \
    groupadd -g 1000 ossec && \
    useradd -u 1000 -g 1000 -d /var/ossec ossec

RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get install --no-install-recommends --no-install-suggests -y \
    openssl postfix bsd-mailx python3-boto python3-pip \
    apt-transport-https vim expect nodejs python3-cryptography mailutils libsasl2-modules \
    wazuh-manager=${WAZUH_VERSION} wazuh-api=${WAZUH_VERSION} && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -f /var/ossec/logs/alerts/*/*/*.log && \
    rm -f /var/ossec/logs/alerts/*/*/*.json && \
    rm -f /var/ossec/logs/archives/*/*/*.log && \
    rm -f /var/ossec/logs/archives/*/*/*.json && \
    rm -f /var/ossec/logs/firewall/*/*/*.log && \
    rm -f /var/ossec/logs/firewall/*/*/*.json

COPY config/data_dirs.env /data_dirs.env
COPY config/init.bash /init.bash
RUN mkdir /entrypoint-scripts
COPY config/entrypoint.sh /entrypoint.sh
COPY config/00-wazuh.sh /entrypoint-scripts/00-wazuh.sh
COPY config/01-config_filebeat.sh /entrypoint-scripts/01-config_filebeat.sh

RUN chmod 755 /init.bash && \
    sync && /init.bash && \
    sync && rm /init.bash && \
    curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-${FILEBEAT_VERSION}-amd64.deb && \
    dpkg -i filebeat-${FILEBEAT_VERSION}-amd64.deb && \
    rm -f filebeat-${FILEBEAT_VERSION}-amd64.deb && \
    chmod 755 /entrypoint.sh && \
    chmod 755 /entrypoint-scripts/00-wazuh.sh && \
    chmod 755 /entrypoint-scripts/01-config_filebeat.sh

COPY config/filebeat.yml /etc/filebeat/
RUN chmod go-w /etc/filebeat/filebeat.yml

VOLUME ["/var/ossec/data"]
VOLUME ["/etc/filebeat"]
VOLUME ["/etc/postfix"]
VOLUME ["/var/lib/filebeat"]

EXPOSE 55000/tcp 1514/udp 1515/tcp 514/udp 1516/tcp

RUN mkdir /etc/service/wazuh && \
    mkdir /etc/service/wazuh-api && \
    mkdir /etc/service/postfix && \
    mkdir /etc/service/filebeat

COPY config/wazuh.runit.service /etc/service/wazuh/run
COPY config/wazuh-api.runit.service /etc/service/wazuh-api/run
COPY config/postfix.runit.service /etc/service/postfix/run
COPY config/filebeat.runit.service /etc/service/filebeat/run

RUN chmod +x /etc/service/wazuh-api/run && \
    chmod +x /etc/service/wazuh/run && \
    chmod +x /etc/service/postfix/run && \
    chmod +x /etc/service/filebeat/run

ENTRYPOINT ["/entrypoint.sh"]
