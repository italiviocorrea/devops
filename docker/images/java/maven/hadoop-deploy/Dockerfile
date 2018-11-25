FROM icorrea/alpine:3.8

RUN apk update \
  && apk add build-base \
  && apk add openssh-client

CMD ["gcc", "/root/src/hadoop-deploy.c", "-o", "/root/bin/hadoop-deploy"]
