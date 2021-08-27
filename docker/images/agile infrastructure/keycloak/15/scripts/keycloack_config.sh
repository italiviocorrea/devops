#!/bin/bash
#
# Keycloak library

jboss-cli.sh <<EOF
embed-server --server-config=standalone-ha.xml --std-out=echo
batch
/subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=interval, value=600000) 
/subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=max-idle, value=90000000) 
/subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=lifespan, value=3600000)
/subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/memory=off-heap:add(size=2,size-unit="GB")  
run-batch
stop-embedded-server
EOF

# fontes: https://docs.wildfly.org/23/wildscribe/index.html 
#         https://www.keycloak.org/docs/latest/server_installation/#cache-configuration
# Exemplos de configuração
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=interval, value=3000000)  # 5 minutos
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=max-idle, value=90000000) # 24 horas
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/component=expiration/: write-attribute(name=lifespan, value=3600000)  # 1 hora 
#
# outros exemplos
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/memory=object:add(size=100000)
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/memory=off-heap:add(size=2147483648)
# /subsystem=infinispan/cache-container=keycloak/distributed-cache=actionTokens/memory=off-heap:add(size=2,size-unit="GB")

