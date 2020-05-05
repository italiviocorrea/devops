FROM icorrea/alpine:3.11

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ENV JAVA_VERSION='jdk-11.0.6+10' \
    ESUM='c5a4e69e2be0e3e5f5bb7c759960b20650967d0f571baad4a7f15b2c03bda352' \
    BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.6%2B10/OpenJDK11U-jre_x64_linux_hotspot_11.0.6_10.tar.gz'

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

