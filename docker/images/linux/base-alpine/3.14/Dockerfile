FROM alpine:3.14.0

LABEL maintainer="Italívio Corrêa <italiviocorrea@gmail.com>"

ADD https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.1/s6-overlay-amd64-installer /tmp/
RUN chmod +x /tmp/s6-overlay-amd64-installer \
    && /tmp/s6-overlay-amd64-installer / \
    && rm -rf /tmp/s6-overlay-amd64-installer \
    && apk upgrade --update --no-cache \
    && rm -rf /var/cache/apk/* 
#    && apk add --no-cache chrony tzdata \
#    && mkdir -p /etc/services.d/chrony \
#    && apk del tzdata

#   && apk add  --no-cache openntpd tzdata \

# place default conf which can be overridden with volume
# COPY run /etc/services.d/chrony/.
# COPY finish /etc/services.d/chrony/.
# COPY chrony.conf /etc/chrony/.

    
# Init
ENTRYPOINT [ "/init" ]


