from bitnami/minideb:buster

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

RUN install_packages locales ntp && rm -rf /var/lib/apt/lists/* \
    && localedef -i pt_BR -f UTF-8 pt_BR.UTF-8

ENV LANG pt_BR.utf8

RUN rm /etc/localtime && cp /usr/share/zoneinfo/America/Campo_Grande /etc/localtime

COPY ntpd.conf /etc/ntpd.conf

CMD ["ntpd","-d","-f","/etc/ntpd.conf","-s"]
