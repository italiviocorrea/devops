FROM ubuntu:20.04

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive
ARG TMZ_LOCATION=America 
ARG TMZ_NAME=Campo_Grande

ARG INPUTFILE=pt_BR 
ARG CHARMAP=UTF-8

ENV LANG=${INPUTFILE}.${CHARMAP} \
    LC_ALL=${INPUTFILE}.${CHARMAP}

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.8.0/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / --exclude='./bin' && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /usr ./bin

RUN apt-get update && \
    apt-get install -y software-properties-common locales apt-utils tzdata ntp && \
    rm -rf /var/lib/apt/lists/*   && \
    echo "tzdata tzdata/Areas select $TMZ_LOCATION" > timezone.txt && \
    echo "tzdata tzdata/Zones/$TMZ_LOCATION select $TMZ_NAME" >> timezone.txt && \
    debconf-set-selections timezone.txt && \
    rm /etc/timezone && \
    rm /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata  && \
    localedef --i $INPUTFILE -c -f $CHARMAP -A /usr/share/locale/locale.alias $LANG

ENTRYPOINT ["/init"]

COPY ntpd.conf /etc/ntpd.conf

CMD ["ntpd","-v","-d","-s","-f","/etc/ntpd.conf"]

