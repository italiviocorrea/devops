#! /bin/sh


# add the libraries to the JAPPMODELER_CLASSPATH.
# EXEDIR is the directory where this executable is.
# EXEDIR=${0%/*}
EXEDIR="/home/developer/apps/jappmodeler"

DIRLIBS=${EXEDIR}/lib/*.jar
for i in ${DIRLIBS}
do
  if [ -z "$JAPPMODELER_CLASSPATH" ] ; then
    JAPPMODELER_CLASSPATH=$i
  else
    JAPPMODELER_CLASSPATH="$i":$JAPPMODELER_CLASSPATH
  fi
done


JAPPMODELER_CLASSPATH="${EXEDIR}/imagens/":$JAPPMODELER_CLASSPATH
JAPPMODELER_CLASSPATH="${EXEDIR}/conf/":$JAPPMODELER_CLASSPATH

JAPPMODELER_CLASSPATH="${EXEDIR}/./classes":$JAPPMODELER_CLASSPATH
JAPPMODELER_HOME="${EXEDIR}/."
export http_proxy=http://proxy.sgi.ms.gov.br:8081
export https_proxy=http://proxy.sgi.ms.gov.br:8081

java -classpath "$JAPPMODELER_CLASSPATH:$CLASSPATH" -D-server -D-Xms256m -D-Xmx1024 -D-XX:PermSize=32m -D-XX:MaxPermSize=512m -DjAppBuilder.home=$JAPPMODELER_HOME  org.jmycrudframework.jappmodeler.Main "$@"
