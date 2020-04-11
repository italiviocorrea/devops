FROM icorrea/debian:buster-slim

RUN apt install glibc libncursese tzdata &&
    wget -qO- https://binaries.cockroachdb.com/cockroach-v19.2.4.linux-amd64.tgz | tar  xvz &&
    cp -i cockroach-v19.2.4.linux-amd64/cockroach /usr/local/bin/


