FROM vfarcic/docker-flow-monitor:latest

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

COPY ntpd.conf /etc/ntpd.conf

USER root

RUN rm /etc/localtime && cp /usr/share/zoneinfo/America/Campo_Grande /etc/localtime

USER nobody

ENV LANG=pt_BR.UTF-8

CMD ["ntpd","-v","-d","-f","/etc/ntpd.conf","-s"]


