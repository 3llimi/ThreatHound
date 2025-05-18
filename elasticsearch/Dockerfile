### Dockerfile.elasticsearch (fully patched)

# Stage 1: base + OS-level CVE fixes
ARG ELASTIC_VERSION=7.17.16
FROM docker.elastic.co/elasticsearch/elasticsearch:${ELASTIC_VERSION} AS base

USER root

# Update NSS libraries (fix CVE-2021-43527)
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --only-upgrade \
       libnss3 libnss3-tools \
    && rm -rf /var/lib/apt/lists/*

# Install S3 plugin
ARG S3_PLUGIN_URL="https://artifacts.elastic.co/downloads/elasticsearch-plugins/repository-s3/repository-s3-${ELASTIC_VERSION}.zip"
RUN bin/elasticsearch-plugin install --batch ${S3_PLUGIN_URL}

# Stage 2: Java-level CVE fixes
# Remove vulnerable OWASP sanitizer and Log4j-core, install fixed versions
RUN rm -f /usr/share/elasticsearch/modules/ingest-attachment/ingest-attachment-20191001.1.jar \
 && curl -fsSL -o /usr/share/elasticsearch/modules/ingest-attachment/ingest-attachment-20211018.1.jar \
      https://repo1.maven.org/maven2/com/googlecode/owasp-java-html-sanitizer/owasp-java-html-sanitizer/20211018.1/owasp-java-html-sanitizer-20211018.1.jar \
 && find /usr/share/elasticsearch -type f -name "log4j-core-*.jar" -delete \
 && curl -fsSL -o /usr/share/elasticsearch/lib/log4j-core-2.17.1.jar \
      https://repo1.maven.org/maven2/org/apache/logging/log4j/log4j-core/2.17.1/log4j-core-2.17.1.jar

# Restore ownership
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

# Stage 3: final image with configs
FROM base

USER elasticsearch

ARG ELASTIC_VERSION
ARG TEMPLATE_VERSION=v4.12.0

# Environment variables
ENV ELASTICSEARCH_URL="http://elasticsearch:9200"
ENV ALERTS_SHARDS="1" ALERTS_REPLICAS="0"
ENV API_USER="admin" API_PASS="admin"
ENV XPACK_ML="true" ENABLE_CONFIGURE_S3="false"
ENV ELASTIC_CLUSTER="false"
ENV CLUSTER_NAME="wazuh" CLUSTER_NODE_MASTER="false" CLUSTER_NODE_DATA="true" CLUSTER_NODE_INGEST="true"
ENV CLUSTER_NODE_NAME="wazuh-elasticsearch" CLUSTER_MASTER_NODE_NAME="master-node"
ENV CLUSTER_MEMORY_LOCK="true" CLUSTER_DISCOVERY_SERVICE="wazuh-elasticsearch"
ENV CLUSTER_NUMBER_OF_MASTERS="2" CLUSTER_MAX_NODES="1" CLUSTER_DELAYED_TIMEOUT="1m"
ENV CLUSTER_INITIAL_MASTER_NODES="wazuh-elasticsearch"

# Copy and set up helper scripts
COPY config/entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

COPY --chown=elasticsearch:elasticsearch config/load_settings.sh ./
RUN chmod +x load_settings.sh

COPY config/configure_s3.sh ./config/configure_s3.sh
RUN chmod 755 ./config/configure_s3.sh

COPY --chown=elasticsearch:elasticsearch config/config_cluster.sh ./
RUN chmod +x config_cluster.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["elasticsearch"]
