FROM icorrea/openjdk:8u212-jre-alpine3.9
                                    
LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ARG UID=1000
ARG GID=1000
ARG GROUP=nifi
ARG USER=nifi
ARG NIFI_VERSION=1.9.2
ARG MIRROR=https://archive.apache.org/dist

ENV NIFI_BASE_DIR=/opt
ENV NIFI_HOME=${NIFI_BASE_DIR}/nifi \
    NIFI_BINARY_URL=/nifi/${NIFI_VERSION}/nifi-${NIFI_VERSION}-bin.tar.gz
ENV NIFI_PID_DIR=${NIFI_HOME}/run
ENV NIFI_LOG_DIR=${NIFI_HOME}/logs

RUN apk --no-cache add jq xmlstarlet procps curl 
 

ADD sh/ ${NIFI_BASE_DIR}/scripts/


WORKDIR ${NIFI_BASE_DIR}

# Download, validate, and expand Apache NiFi binary.
RUN curl -fSL ${MIRROR}/${NIFI_BINARY_URL} -o ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.tar.gz \
    && echo "$(curl https://archive.apache.org/dist/${NIFI_BINARY_URL}.sha256) *${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.tar.gz" | sha256sum -c - \
    && tar -xzf ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}-bin.tar.gz  \
    && mv ${NIFI_BASE_DIR}/nifi-${NIFI_VERSION}/ ${NIFI_HOME} \
    && rm ${NIFI_HOME}-${NIFI_VERSION}-bin.tar.gz

# Clear nifi-env.sh in favour of configuring all environment variables in the Dockerfile
#RUN echo "#!/bin/sh\n" > $NIFI_HOME/bin/nifi-env.sh

# Setup NiFi user and create necessary directories
RUN addgroup -g ${GID} ${GROUP} \
    && adduser -h "$NIFI_HOME" -u ${GID} -G ${GROUP} -s /bin/bash -D ${USER} \
    && mkdir -p ${NIFI_HOME}/conf/templates \
    && mkdir -p $NIFI_HOME/database_repository \
    && mkdir -p $NIFI_HOME/flowfile_repository \
    && mkdir -p $NIFI_HOME/content_repository \
    && mkdir -p $NIFI_HOME/provenance_repository \
    && mkdir -p $NIFI_HOME/state \
    && mkdir -p $NIFI_LOG_DIR \
    && chown -R ${UID}:${GID} $NIFI_BASE_DIR \
    && chmod +x ${NIFI_BASE_DIR}/scripts/*.sh 


USER nifi

WORKDIR ${NIFI_HOME}

VOLUME ${NIFI_LOG_DIR} \
       ${NIFI_HOME}/conf \
       ${NIFI_HOME}/database_repository \
       ${NIFI_HOME}/flowfile_repository \
       ${NIFI_HOME}/content_repository \
       ${NIFI_HOME}/provenance_repository \
       ${NIFI_HOME}/state

# Web HTTP(s) & Socket Site-to-Site Ports
EXPOSE 8080 8443 10000

# Apply configuration and start NiFi
#
# We need to use the exec form to avoid running our command in a subshell and omitting signals,
# thus being unable to shut down gracefully:
# https://docs.docker.com/engine/reference/builder/#entrypoint
#
# Also we need to use relative path, because the exec form does not invoke a command shell,
# thus normal shell processing does not happen:
# https://docs.docker.com/engine/reference/builder/#exec-form-entrypoint-example
CMD ["../scripts/start.sh"]

