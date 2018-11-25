FROM icorrea/jenkins:v2.121.1-alpine3.8

ENV BLUEOCEAN_VERSION=1.9.0
USER root

# Add the docker binary so running Docker commands from the master works nicely
RUN apk -U add docker

USER jenkins

RUN install-plugins.sh antisamy-markup-formatter matrix-auth blueocean:$BLUEOCEAN_VERSION
