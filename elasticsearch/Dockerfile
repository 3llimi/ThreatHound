FROM wazuh/wazuh-elasticsearch:3.13.6_7.9.2

# 1. Fix NSS vulnerabilities
RUN yum update -y nss nss-sysinit nss-tools && \
    yum clean all

# 2. Update OWASP HTML Sanitizer
RUN find /usr/share/elasticsearch/lib/ -name "*owasp-java-html-sanitizer*.jar" -delete && \
    curl -o /usr/share/elasticsearch/lib/owasp-java-html-sanitizer-20211018.1.jar \
    https://repo1.maven.org/maven2/com/googlecode/owasp-java-html-sanitizer/owasp-java-html-sanitizer/20211018.1/owasp-java-html-sanitizer-20211018.1.jar

# 3. Fix Log4j vulnerabilities
RUN find /usr/share/elasticsearch/lib/ -name "log4j-core-*.jar" -delete && \
    curl -o /tmp/apache-log4j-2.17.1-bin.zip \
    https://archive.apache.org/dist/logging/log4j/2.17.1/apache-log4j-2.17.1-bin.zip && \
    unzip /tmp/apache-log4j-2.17.1-bin.zip -d /tmp/ && \
    cp /tmp/apache-log4j-2.17.1-bin/log4j-core-2.17.1.jar /usr/share/elasticsearch/lib/ && \
    rm -rf /tmp/apache-log4j-2.17.1*