FROM icorrea/alpine:3.8

ENV PORTAINER_VERSION="1.19.2"
ENV PORTAINER_FILENAME="portainer-$PORTAINER_VERSION-linux-amd64.tar.gz" 

ENV PORTAINER_URL="https://github.com/portainer/portainer/releases/download/$PORTAINER_VERSION/${PORTAINER_FILENAME}"

RUN mkdir -p /opt/portainer/data && cd /opt/portainer

#ADD portainer-1.19.2-linux-amd64.tar.gz /opt
ADD "${PORTAINER_URL}" /opt/portainer


VOLUME /opt/portainer/data

EXPOSE 9000

CMD ["/opt/portainer/portainer","--template-file","/opt/portainer/templates.json","--data","/opt/portainer/data"]

    



