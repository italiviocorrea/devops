#!/bin/bash

# Swarm mode using Docker Machine

workers=3

# create worker machines
echo "======> Creating $workers worker machines ...";
for node in $(seq 1 $workers);
do
    echo "======> Creating worker$node machine ...";
    docker-machine create -d virtualbox worker$node;
done

# list all machines
docker-machine ls

# initialize swarm mode and create a manager on worker1
echo "======> Initializing the swarm manager on worker1 ..."
docker-machine ssh worker1 "docker swarm init --listen-addr $(docker-machine ip worker1) --advertise-addr $(docker-machine ip worker1)"

# get worker tokens
export worker_token=`docker-machine ssh worker1 "docker swarm join-token worker -q"`
echo "worker_token: $worker_token"

# show members of swarm
docker-machine ssh worker1 "docker node ls"

# other workers join swarm, worker1 is already a member
for node in $(seq 2 $workers);
do
    echo "======> worker$node joining swarm as worker ..."
    docker-machine ssh worker$node \
    "docker swarm join \
    --token $worker_token \
    --listen-addr $(docker-machine ip worker$node) \
    --advertise-addr $(docker-machine ip worker$node) \
    $(docker-machine ip worker1)"
done

# pull the yugabytedb container
for node in $(seq 1 $workers);
do
    echo "======> pulling yugabytedb/yugabyte container on worker$node ..."
    docker-machine ssh worker$node \
    "docker pull yugabytedb/yugabyte"
done

# show members of swarm
docker-machine ssh worker1 "docker node ls"

