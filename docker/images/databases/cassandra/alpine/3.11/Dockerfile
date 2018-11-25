FROM icorrea/openjdk:8u181-jre-alpine3.8

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

## Variáveis de ambiente
ENV CASSANDRA_VERSION 3.11.3

ENV CASSANDRA_HOME /usr/local/apache-cassandra-${CASSANDRA_VERSION}

ENV CASSANDRA_CONF       ${CASSANDRA_HOME}/conf 
ENV CASSANDRA_DATA       ${CASSANDRA_HOME}/data 
ENV CASSANDRA_LOGS       ${CASSANDRA_HOME}/logs

ENV CASSANDRA_CLUSTER_NAME            'cluster-cassandra-1' 
ENV CASSANDRA_DATA_FILE_DIRECTORIES   ["${CASSANDRA_DATA}/data"] 
ENV CASSANDRA_COMMITLOG_DIRECTORY     ${CASSANDRA_DATA}/commitlog 
ENV CASSANDRA_SAVED_CACHES_DIRECTORY  ${CASSANDRA_DATA}/saved_caches 
ENV CASSANDRA_HINTS_DIRECTORY         ${CASSANDRA_DATA}/hints

ENV PATH $PATH:$CASSANDRA_HOME/bin

# Atualizando o Alpine Linux e Instalando o Cassandra
RUN set -x \
    && apk update \
    && apk --no-cache add \
        bash \
        jemalloc \
        ca-certificates \
        python \
        su-exec \
    &&  mirror_url=$( \
         wget -q -O - "http://www.apache.org/dyn/closer.cgi/?as_json=1" \
          | grep "preferred" \
          | sed -n 's#.*"\(http://*[^"]*\)".*#\1#p' \
         ) \
    && wget -q -O - ${mirror_url}/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
        | tar -xzf - -C /usr/local \
    && adduser -D  -g 'cassandra' -s /sbin/nologin cassandra \
    ## cleanup
    && rm -rf \
        ${CASSANDRA_HOME}/bin/*.bat \
        ${CASSANDRA_HOME}/doc \
        ${CASSANDRA_HOME}/javadoc 

RUN chown -R cassandra:cassandra ${CASSANDRA_HOME} ${CASSANDRA_CONFIG} \
    && chmod 777 ${CASSANDRA_HOME} ${CASSANDRA_CONFIG}

COPY docker-entrypoint.sh  /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh # backwards compat


WORKDIR ${CASSANDRA_HOME}

VOLUME ["${CASSANDRA_HOME}"]

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["cassandra", "-f"]
