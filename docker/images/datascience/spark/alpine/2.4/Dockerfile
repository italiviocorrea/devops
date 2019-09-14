FROM icorrea/anaconda3:2019.07-alpine3.10

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"
 
ENV PYTHONHASHSEED 0
ENV PYTHONIOENCODING UTF-8
ENV PIP_DISABLE_PIP_VERSION_CHECK 1

# JAVA
# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

ENV JAVA_VERSION 8u212
ENV JAVA_ALPINE_VERSION 8.212.04-r0

RUN set -x \
	&& apk add --no-cache \
		openjdk8 \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]


# HADOOP
RUN adduser -Ds /bin/bash hadoop
ENV HADOOP_VERSION 2.8.3
ENV HADOOP_HOME /usr/hadoop-$HADOOP_VERSION
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV PATH $PATH:$HADOOP_HOME/bin
RUN curl -sL --retry 3 \
  "http://archive.apache.org/dist/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz" \
  | tar -xz -C /usr/ \
 && rm -rf $HADOOP_HOME/share/doc \
 && chown -R hadoop:hadoop $HADOOP_HOME

# SPARK
RUN adduser -Ds /bin/bash spark
ENV SPARK_DATA /spark/data
ENV SPARK_VERSION 2.4.4
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/spark-${SPARK_VERSION}
ENV SPARK_DIST_CLASSPATH="$HADOOP_HOME/etc/hadoop/*:$HADOOP_HOME/share/hadoop/common/lib/*:$HADOOP_HOME/share/hadoop/common/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/hdfs/lib/*:$HADOOP_HOME/share/hadoop/hdfs/*:$HADOOP_HOME/share/hadoop/yarn/lib/*:$HADOOP_HOME/share/hadoop/yarn/*:$HADOOP_HOME/share/hadoop/mapreduce/lib/*:$HADOOP_HOME/share/hadoop/mapreduce/*:$HADOOP_HOME/share/hadoop/tools/lib/*"
ENV PATH $PATH:${SPARK_HOME}/bin
RUN curl -sL --retry 3 \
  "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE}.tgz" \
  | tar xz -C /usr/ \
 && mv /usr/$SPARK_PACKAGE $SPARK_HOME \
 && chown -R spark:spark $SPARK_HOME

COPY *.jar $SPARK_HOME/jars/

RUN mkdir -p $SPARK_DATA \
    && chown -R spark:spark $SPARK_DATA \
    && chown -R spark:spark $SPARK_HOME

VOLUME $SPARK_DATA

EXPOSE 4040 6066 7077 8080

USER root
WORKDIR $SPARK_HOME
