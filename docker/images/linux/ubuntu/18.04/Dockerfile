FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y locales && \
    apt-get install -y tzdata && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i pt_BR -f UTF-8 pt_BR.UTF-8

ENV LANG pt_BR.utf8


RUN ln -sf /usr/share/zoneinfo/America/Campo_Grande /etc/localtime 

RUN apt-get update && apt-get -y install  ntp

COPY ntpd.conf /etc/ntpd.conf

CMD ["ntpd","-v","-d","-s","-f","/etc/ntpd.conf"]

