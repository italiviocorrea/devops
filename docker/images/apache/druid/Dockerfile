
FROM icorrea/openjdk:8u181-jre-alpine3.8
MAINTAINER Italivio Correa <italiviocorrea@gmail.com>



ENV DRUID_VERSION=0.12.3

# Druid env variable
ENV DRUID_XMX=1g
ENV DRUID_XMS=1g
ENV DRUID_NEWSIZE=250m
ENV DRUID_MAXNEWSIZE=250m
ENV DRUID_HOSTNAME='-'
ENV DRUID_LOGLEVEL='-'
ENV DRUID_USE_CONTAINER_IP='-'

RUN apk add --update wget tar bash

RUN mkdir -p /opt

RUN wget -q --no-check-certificate --no-cookies -O - \
    http://static.druid.io/artifacts/releases/druid-$DRUID_VERSION-bin.tar.gz | tar -xzf - -C /opt \
    && ln -s /opt/druid-$DRUID_VERSION /opt/druid

COPY conf /opt/druid-$DRUID_VERSION/conf
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN mkdir -p /tmp/druid \
    /tmp/druid/persistent/task \
    /var/tmp \
    /var/druid/indexing-logs \
    /var/druid/segments \
    /var/druid/segment-cache \
    /var/druid/task \
    /var/druid/hadoop-tmp \
    /var/druid/pids

EXPOSE 8081 8082 8083 8090 8091

ENTRYPOINT ["/docker-entrypoint.sh"]
