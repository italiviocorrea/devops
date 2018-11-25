FROM icorrea/alpine:3.8

ENV NODE_EXPORT_VERSION=0.16.0

RUN mkdir /opt

ADD node_exporter-${NODE_EXPORT_VERSION}.linux-amd64.tar.gz /opt

RUN cd /opt && \
    ln -s node_exporter-${NODE_EXPORT_VERSION}.linux-amd64 node_exporter

WORKDIR /opt/node_exporter

EXPOSE 9100

CMD ["./node_exporter"]


