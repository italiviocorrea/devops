#!/bin/sh

BASEDIR="$(cd "`dirname "$0"`"; pwd)"

docker build -t swarm-dep1oy:1.2 $BASEDIR
docker run -v $BASEDIR/src:/root/src -v $BASEDIR/bin:/root/bin -it swarm-dep1oy:1.2
