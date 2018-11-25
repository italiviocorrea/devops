# docker-cassandra

Apache Cassandra docker image baseado no alpine linux 3.8 e openjdk jre-8u181

# network 
docker network create -d bridge --subnet 172.42.5.0/24 cassandra-net

# startup cassandra
docker run --net cassandra-net --name cassandra -d icorrea/cassandra:3.11-alpine3.8 

# tail logs
docker logs -f cassandra

# acesso via cqlsh 
docker run -it --rm --net cassandra-net icorrea/cassandra:3.11-alpine3.8  cqlsh cassandra.cassandra-net

Connected to Test Cluster at cassandra.cassandra-net:9042.
[cqlsh 5.0.1 | Cassandra 3.11.3 | CQL spec 3.4.4 | Native protocol v4]
Use HELP for help.
cqlsh> 
cqlsh> SELECT release_version, cluster_name FROM system.local;

 release_version | cluster_name
-----------------+--------------
            3.11 | cluster-cassandra-1

(1 rows)
cqlsh> exit
```

# Iniciando o cluster cassandra
docker-compose up -d 

# verificando os logs 
docker-compose logs -f 

# checando os serviços com ps
docker-compose ps

   Name                Command             State                        Ports                       
---------------------------------------------------------------------------------------------------
cassandra-1   entrypoint.sh cassandra -f   Up      7000/tcp, 7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp 
cassandra-2   entrypoint.sh cassandra -f   Up      7000/tcp, 7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp 
cassandra-3   entrypoint.sh cassandra -f   Up      7000/tcp, 7001/tcp, 7199/tcp, 9042/tcp, 9160/tcp

# checar o status dos nós
docker-compose exec cassandra-1 nodetool status

Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens    Owns (effective)  Host ID                               Rack
UN  172.18.0.2  103.66 KiB  256      66.3%             30e50198-03ef-46dc-a521-9b77c11b185b  rack1
UN  172.18.0.3  100.4 KiB   256      62.5%             aa610862-ac91-4be7-9495-de54773752b3  rack1
UN  172.18.0.4  80.23 KiB   256      71.2%             d624fec9-1a5d-48ce-a229-20ad5a691757  rack1

# parar cassandra  
docker-compose stop

# removendo os container 
docker-compose rm -v

```

