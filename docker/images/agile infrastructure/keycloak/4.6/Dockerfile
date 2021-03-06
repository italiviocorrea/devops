FROM icorrea/openjdk:8u181-jdk-alpine3.8

# Create a user and group used to launch processes
RUN addgroup -S -g 9999 jboss && adduser -S -G jboss -u 999 jboss
RUN mkdir -p /opt/jboss && chgrp jboss /opt/jboss && chmod 775 /opt/jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

ENV KEYCLOAK_VERSION 4.6.0.Final

# Enables signals getting passed from startup script to JVM
# ensuring clean shutdown when container is stopped.
ENV LAUNCH_JBOSS_IN_BACKGROUND 1
ENV PROXY_ADDRESS_FORWARDING false

USER root

RUN apk --no-cache add --update curl  bash

USER jboss

ARG KEYCLOAK_DIST=https://downloads.jboss.org/keycloak/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.tar.gz

ADD build-keycloak.sh /opt/jboss/build-keycloak.sh
RUN /opt/jboss/build-keycloak.sh

ADD docker-entrypoint.sh /opt/jboss/

ADD cli /opt/jboss/keycloak/cli
RUN cd /opt/jboss/keycloak && bin/jboss-cli.sh --file=cli/standalone-configuration.cli && rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history
RUN cd /opt/jboss/keycloak && bin/jboss-cli.sh --file=cli/standalone-ha-configuration.cli && rm -rf /opt/jboss/keycloak/standalone/configuration/standalone_xml_history

ENV JDBC_POSTGRES_VERSION 42.2.2
ENV JDBC_MYSQL_VERSION 5.1.46
ENV JDBC_MARIADB_VERSION 2.2.3

ADD databases/change-database.sh /opt/jboss/keycloak/bin/change-database.sh

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main; cd /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main && curl -O http://central.maven.org/maven2/mysql/mysql-connector-java/$JDBC_MYSQL_VERSION/mysql-connector-java-$JDBC_MYSQL_VERSION.jar
ADD databases/mysql/module.xml /opt/jboss/keycloak/modules/system/layers/base/com/mysql/jdbc/main/module.xml

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; cd /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main; curl -L http://central.maven.org/maven2/org/postgresql/postgresql/$JDBC_POSTGRES_VERSION/postgresql-$JDBC_POSTGRES_VERSION.jar > postgres-jdbc.jar
ADD databases/postgres/module.xml /opt/jboss/keycloak/modules/system/layers/base/org/postgresql/jdbc/main

RUN mkdir -p /opt/jboss/keycloak/modules/system/layers/base/org/mariadb/jdbc/main; cd /opt/jboss/keycloak/modules/system/layers/base/org/mariadb/jdbc/main; curl -L http://central.maven.org/maven2/org/mariadb/jdbc/mariadb-java-client/$JDBC_MARIADB_VERSION/mariadb-java-client-$JDBC_MARIADB_VERSION.jar > mariadb-jdbc.jar
ADD databases/mariadb/module.xml /opt/jboss/keycloak/modules/system/layers/base/org/mariadb/jdbc/main

ENV JBOSS_HOME /opt/jboss/keycloak


EXPOSE 8080

ENTRYPOINT [ "/opt/jboss/docker-entrypoint.sh" ]

CMD ["-b", "0.0.0.0"]
