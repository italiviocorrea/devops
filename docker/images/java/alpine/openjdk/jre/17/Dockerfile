FROM eclipse-temurin:17-jdk-alpine as jre-build

LABEL maintainer="Italivio Correa <italiviocorrea@gmail.com>"

# Create a custom Java runtime 
# 1) Opção com módulos semelhante ao JRE
#    (ALL-MODULE-PATH)
# 2) Opção sem os módulos extras
# java.base,java.compiler,java.datatransfer,java.desktop,java.instrument,java.logging,java.management,java.management.rmi,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.se,java.security.jgss,java.security.sasl,java.smartcardio,java.sql,java.sql.rowset,java.transaction.xa,java.xml,java.xml.crypto,jdk.accessibility,jdk.charsets,jdk.crypto.cryptoki,jdk.crypto.ec,jdk.dynalink,jdk.httpserver,jdk.incubator.foreign,jdk.incubator.vector,jdk.internal.vm.ci,jdk.internal.vm.compiler,jdk.internal.vm.compiler.management,jdk.jdwp.agent,jdk.jfr,jdk.jsobject,jdk.localedata,jdk.management,jdk.management.agent,jdk.management.jfr,jdk.naming.dns,jdk.naming.rmi,jdk.net,jdk.nio.mapmode,jdk.sctp,jdk.security.auth,jdk.security.jgss,jdk.unsupported,jdk.xml.dom,jdk.zipfs 
# 3) Opção resumida
# java.base,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument
# 4) Aplicaçao Spring Boot. Usando jdeps para gerar os módulos necessários para sua aplicação (myapp.jar). Supondo que o myapp.jar encontra-se no diretório /app
# --add-modules  $(jdeps --print-module-deps /app/myapp.jar),java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument
	
RUN apk add --no-cache binutils && \
    $JAVA_HOME/bin/jlink \
         --strip-debug \
         --no-man-pages \
         --no-header-files \
         --compress=2 \
         --output /opt/openjdk \
         --add-modules java.base,java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument
         
   

FROM icorrea/alpine:3.14

ENV JAVA_HOME=/opt/openjdk
ENV PATH="$PATH:$JAVA_HOME/bin"

COPY --from=jre-build "$JAVA_HOME" "$JAVA_HOME"

