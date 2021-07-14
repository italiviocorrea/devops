FROM alpine:3.14.0

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

# timezone support
ENV TMZ_LOCATION=America \
    TMZ_NAME=Campo_Grande \
    LANG='pt_BR.UTF-8'  \ 
    LANGUAGE='pt_BR.UTF-8' \
    LC_ALL='pt_BR.UTF-8' \
    LOCALE='pt_BR' \
    GLIBC_VER="2.33-r0" \
    PATH=/usr/glibc-compat/sbin:/usr/glibc-compat/bin:$PATH

# install latest certs, config localtime and timezone
RUN apk --no-cache --virtual .build-deps add ca-certificates wget binutils &&\
    update-ca-certificates &&\
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-${GLIBC_VER}.apk &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-bin-${GLIBC_VER}.apk &&\
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VER}/glibc-i18n-${GLIBC_VER}.apk &&\
    apk add glibc-${GLIBC_VER}.apk glibc-bin-${GLIBC_VER}.apk glibc-i18n-${GLIBC_VER}.apk &&\
    /usr/glibc-compat/bin/localedef -i ${LOCALE} -f UTF-8 ${LOCALE}.UTF-8 &&\
    apk del --purge .build-deps wget &&\
    rm -rf /var/cache/apk/* &&\
    apk add --update tzdata --no-cache &&\
    cp /usr/share/zoneinfo/$TMZ_LOCATION/$TMZ_NAME /etc/localtime &&\
    echo "$TMZ_LOCATION/$TMZ_NAME" >  /etc/timezone &&\
    apk add --no-cache chrony && mkdir -p /etc/chrony &&\
    apk del tzdata

# place default conf which can be overridden with volume
COPY chrony.conf /etc/chrony/.

# start
CMD [ "/usr/sbin/chronyd", "-d", "-s"]
