FROM icorrea/alpine:3.8	

ADD  "https://github.com/containous/traefik/releases/download/v1.7.3/traefik_linux-amd64" traefik

RUN  mv  traefik /usr/local/bin/traefik  &&  chmod +x /usr/local/bin/traefik

COPY entrypoint.sh /

EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

CMD ["traefik"]

# Metadata
LABEL org.label-schema.vendor="Containous" \
      org.label-schema.url="https://traefik.io" \
      org.label-schema.name="Traefik" \
      org.label-schema.description="A modern reverse-proxy" \
      org.label-schema.version="v1.7.3" \
      org.label-schema.docker.schema-version="1.0"
