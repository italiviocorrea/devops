FROM icorrea/alpine:3.14

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

ENV JAVA_VERSION jdk-11.0.11+9
   
RUN set -eux; \
    apk add --no-cache --virtual .fetch-deps openjdk11; \
    apk del --purge .fetch-deps; \
    rm -rf /var/cache/apk/*; 

#ENV JAVA_HOME=/opt/java/openjdk \
#    PATH="/opt/java/openjdk/bin:$PATH"
#CMD ["jshell"]
