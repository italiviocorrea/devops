FROM alpine:3.10.3

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

ENV TMZ_LOCATION=America \
    TMZ_NAME=Campo_Grande

ENV INPUTFILE=pt_BR \
    CHARMAP=UTF-8

ENV LANG=${INPUTFILE}.${CHARMAP}

# Instal GNU libc (aka glibc) and set pt_BR.UTF-8 locale as default.

RUN GLIBC_VERSION="2.29-r0" && \
    apk add --no-cache  --virtual=.build-dependencies ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-$GLIBC_VERSION.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-bin-$GLIBC_VERSION.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC_VERSION/glibc-i18n-$GLIBC_VERSION.apk && \
    apk add --no-cache \
        glibc-$GLIBC_VERSION.apk \
        glibc-bin-$GLIBC_VERSION.apk \
        glibc-i18n-$GLIBC_VERSION.apk && \
    ( /usr/glibc-compat/bin/localedef -f -i $INPUTFILE --charmap $CHARMAP $LANG || true ) && \
    echo "export LANG=$LANG" > /etc/profile.d/locale.sh && \
    /usr/glibc-compat/sbin/ldconfig /lib /usr/glibc-compat/lib && \
    apk del glibc-i18n && \
    apk add  --no-cache \
        openntpd \
        tzdata && \
    cp /usr/share/zoneinfo/$TMZ_LOCATION/$TMZ_NAME /etc/localtime && \
    echo "$TMZ_LOCATION/$TMZ_NAME" >  /etc/timezone && \
    apk del tzdata && \
    rm "/root/.wget-hsts" && \
    apk del .build-dependencies && \
    rm \
        /etc/apk/keys/sgerrand.rsa.pub \
        glibc-$GLIBC_VERSION.apk \
        glibc-bin-$GLIBC_VERSION.apk \
        glibc-i18n-$GLIBC_VERSION.apk && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

COPY ntpd.conf /etc/ntpd.conf

CMD ["ntpd","-d","-f","/etc/ntpd.conf","-s"]

