FROM icorrea/alpine:3.12

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ENV JAVA_VERSION='jdk-14.0.2+12' \
    ESUM='7d5ee7e06909b8a99c0d029f512f67b092597aa5b0e78c109bd59405bbfa74fe' \
    BINARY_URL='https://github.com/AdoptOpenJDK/openjdk14-binaries/releases/download/jdk-14.0.2%2B12/OpenJDK14U-jdk_x64_linux_hotspot_14.0.2_12.tar.gz'

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
CMD ["jshell"]
