FROM icorrea/mongo:3.6

MAINTAINER Debezium Community

COPY init-paises.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init-paises.sh

CMD ["mongod", "--replSet", "rs0", "--auth"]
