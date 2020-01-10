FROM icorrea/debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates fontconfig locales \
    && rm -rf /var/lib/apt/lists/*

ENV JAVA_VERSION jdk8u232-b09

COPY slim-java* /usr/local/bin/

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='35799a2fd4b467115aff1bc3a54853b5131ba9068e53e1ab0fbe5521a3f2ba83'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_aarch64_linux_hotspot_8u232b09.tar.gz'; \
         ;; \
       armhf) \
         ESUM='fdd9f61f1b2df74242da54ee3b3231b0123782a917e9673351276da439c7cab1'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_arm_linux_hotspot_8u232b09.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='da87bdc04b47477b42afc76066dbd96efa35ad967238be03a0081f8840e893a8'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_ppc64le_linux_hotspot_8u232b09.tar.gz'; \
         ;; \
       s390x) \
         ESUM='bd20cb8bf4cfab9d3e2b2ccfb9a6f9eda1e4e67b4103b9975d29de12c05ad1f5'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_s390x_linux_hotspot_8u232b09.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='7b7884f2eb2ba2d47f4c0bf3bb1a2a95b73a3a7734bd47ebf9798483a7bcc423'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_linux_hotspot_8u232b09.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    export PATH="/opt/java/openjdk/bin:$PATH"; \
    apt-get update; apt-get install -y --no-install-recommends binutils; \
    /usr/local/bin/slim-java.sh /opt/java/openjdk; \
    apt-get remove -y binutils; \
    rm -rf /var/lib/apt/lists/*; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"

