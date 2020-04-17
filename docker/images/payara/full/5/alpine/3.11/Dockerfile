FROM icorrea/openjdk:8u242-jdk-alpine3.11

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ENV OPTIONS keyserver-options http-proxy=$http_proxy

# Default payara ports to expose
# 4848: admin console
# 9009: debug port (JPDA)
# 8080: http
# 8443: https
EXPOSE 4848 9009 8080 8443

# Payara version (5.183+)
ARG PAYARA_VERSION=5.201
ARG PAYARA_PKG=https://search.maven.org/remotecontent?filepath=fish/payara/distributions/payara/${PAYARA_VERSION}/payara-${PAYARA_VERSION}.zip
ARG PAYARA_SHA1=ea86d69233826b4d35612260ea4e8f81a9b992f2
ARG TINI_VERSION=v0.18.0

# Initialize the configurable environment variables
ENV HOME_DIR=/opt/payara\
    PAYARA_DIR=/opt/payara/appserver\
    SCRIPT_DIR=/opt/payara/scripts\
    CONFIG_DIR=/opt/payara/config\
    DEPLOY_DIR=/opt/payara/deployments\
    PASSWORD_FILE=/opt/payara/passwordFile\
    # Payara Server Domain options
    DOMAIN_NAME=production\
    ADMIN_USER=admin\
    ADMIN_PASSWORD=admin \
    # Utility environment variables
    JVM_ARGS=\
    PAYARA_ARGS=\
    DEPLOY_PROPS=\
    POSTBOOT_COMMANDS=/opt/payara/config/post-boot-commands.asadmin\
    PREBOOT_COMMANDS=/opt/payara/config/pre-boot-commands.asadmin
ENV PATH="${PATH}:${PAYARA_DIR}/bin"

# Create and set the Payara user and working directory owned by the new user
RUN mkdir -p ${DEPLOY_DIR} && \
    mkdir -p ${CONFIG_DIR} && \
    mkdir -p ${SCRIPT_DIR} && \
    mkdir -p /tmp

# Install tini as minimized init system
RUN apk add --no-cache --update wget unzip bash 

# USER payara
WORKDIR ${HOME_DIR}

# Download and unzip the Payara distribution
RUN wget --no-verbose -O payara.zip ${PAYARA_PKG} && \
    echo "${PAYARA_SHA1} *payara.zip" | sha1sum -c - && \
    unzip -qq payara.zip -d ./ && \
    mv payara*/ appserver && \
    # Configure the password file for configuring Payara
    echo "AS_ADMIN_PASSWORD=" > /tmp/tmpfile && \
    echo "AS_ADMIN_NEWPASSWORD=${ADMIN_PASSWORD}" >> /tmp/tmpfile && \
    echo "AS_ADMIN_PASSWORD=${ADMIN_PASSWORD}" >> ${PASSWORD_FILE} && \
    # Configure the payara domain
    ${PAYARA_DIR}/bin/asadmin --user ${ADMIN_USER} --passwordfile=/tmp/tmpfile change-admin-password --domain_name=${DOMAIN_NAME} && \
    ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} start-domain ${DOMAIN_NAME} && \
    ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} enable-secure-admin && \
    for MEMORY_JVM_OPTION in $(${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} list-jvm-options | grep "Xm[sx]"); do\
       ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} delete-jvm-options $MEMORY_JVM_OPTION;\
    done && \
    # FIXME: when upgrading this container to Java 10+, this needs to be changed to '-XX:+UseContainerSupport' and '-XX:MaxRAMPercentage'
    ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} create-jvm-options '-XX\:+UnlockExperimentalVMOptions:-XX\:+UseCGroupMemoryLimitForHeap:-XX\:MaxRAMFraction=1' && \
    # FIXME: waiting on fix to https://github.com/payara/Payara/issues/3506
    #${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes com.sun.enterprise.server.logging.GFFileHandler.logtoFile=false && \
    # ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes com.sun.enterprise.server.logging.GFFileHandler.logtoConsole=true && \
    # ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes com.sun.enterprise.server.logging.GFFileHandler.formatter='fish.payara.enterprise.server.logging.JSONLogFormatter' && \
    # ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes java.util.logging.FileHandler.formatter='fish.payara.enterprise.server.logging.JSONLogFormatter' && \
    # ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes java.util.logging.ConsoleHandler.formatter='fish.payara.enterprise.server.logging.JSONLogFormatter' && \
    # ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set-log-attributes fish.payara.enterprise.server.logging.PayaraNotificationFileHandler.formatter='fish.payara.enterprise.server.logging.JSONLogFormatter' && \
    ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-2.port=8443 && \
    ${PAYARA_DIR}/bin/asadmin --user=${ADMIN_USER} --passwordfile=${PASSWORD_FILE} stop-domain ${DOMAIN_NAME} && \
    # Cleanup unused files
    rm -rf \
        /tmp/tmpFile \
        payara.zip \
        ${PAYARA_DIR}/glassfish/domains/${DOMAIN_NAME}/osgi-cache \
        ${PAYARA_DIR}/glassfish/domains/${DOMAIN_NAME}/logs \
        ${PAYARA_DIR}/glassfish/domains/domain1

# Copy across docker scripts
COPY bin/*.sh ${SCRIPT_DIR}/
RUN mkdir -p ${SCRIPT_DIR}/init.d && \
    chmod +x ${SCRIPT_DIR}/*

CMD ["scripts/entrypoint.sh"]

