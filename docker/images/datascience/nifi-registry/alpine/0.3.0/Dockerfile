FROM icorrea/openjdk:8u212-jre-alpine3.9

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ARG UID=1000
ARG GID=1000

ENV LANG=pt_BR.UTF-8

ENV NIFI_REGISTRY_VERSAO=0.3.0 \
    NIFI_REGISTRY_BASE_DIR=/opt/nifi-registry \
    NIFI_REGISTRY_HOME=/opt/nifi-registry 

ADD sh/ ${NIFI_REGISTRY_BASE_DIR}/scripts/


# https://www-eu.apache.org/dist/nifi/nifi-registry/nifi-registry-0.3.0/nifi-registry-0.3.0-bin.tar.gz

RUN apk --no-cache add \
    xmlstarlet \
    jq && \
    cd /opt && \
    wget https://www-eu.apache.org/dist/nifi/nifi-registry/nifi-registry-${NIFI_REGISTRY_VERSAO}/nifi-registry-${NIFI_REGISTRY_VERSAO}-bin.tar.gz && \
    tar -xzf nifi-registry-${NIFI_REGISTRY_VERSAO}-bin.tar.gz && \
    mv nifi-registry-${NIFI_REGISTRY_VERSAO} $NIFI_REGISTRY_HOME && \
    rm -rf nifi-registry-${NIFI_REGISTRY_VERSAO}-bin.tar.gz

VOLUME $NIFI_REGISTRY_HOME/database \
       $NIFI_REGISTRY_HOME/flow_storage
 
# Web HTTP(s) ports
EXPOSE 18080 18443

WORKDIR ${NIFI_REGISTRY_HOME}

# Apply configuration and start NiFi Registry
CMD ${NIFI_REGISTRY_BASE_DIR}/scripts/start.sh
