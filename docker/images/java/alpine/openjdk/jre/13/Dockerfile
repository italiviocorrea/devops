FROM icorrea/alpine:3.11

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ENV JAVA_VERSION='jdk-13.0.2+8' \
    ESUM='897f16fe8e056395209e35d2384013bd1ff250e717465769079e3f4793628c34' \
    BINARY_URL='https://github.com/AdoptOpenJDK/openjdk13-binaries/releases/download/jdk-13.0.2%2B8/OpenJDK13U-jre_x64_linux_hotspot_13.0.2_8.tar.gz'

RUN set -eux; \
    apk add --no-cache --virtual .fetch-deps curl; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/*; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

