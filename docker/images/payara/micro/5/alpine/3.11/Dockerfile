FROM icorrea/openjdk:11-jre-alpine3.11

# Default payara ports to expose
EXPOSE 6900 8080

# Configure environment variables
ENV PAYARA_HOME=/opt/payara\
    DEPLOY_DIR=/opt/payara/deployments


# Download specific
ARG PAYARA_VERSION="5.201"
ENV PAYARA_VERSION="$PAYARA_VERSION"
RUN mkdir -p ${DEPLOY_DIR} && \
    wget --no-verbose -O ${PAYARA_HOME}/payara-micro.jar https://repo1.maven.org/maven2/fish/payara/extras/payara-micro/${PAYARA_VERSION}/payara-micro-${PAYARA_VERSION}.jar
