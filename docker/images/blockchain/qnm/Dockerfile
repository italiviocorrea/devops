FROM icorrea/ubuntu:16.04

#Install Utilities
RUN apt-get update
RUN apt-get install -y --no-install-recommends vim less net-tools inetutils-ping wget curl git telnet nmap socat dnsutils netcat tree htop unzip sudo software-properties-common jq psmisc iproute python ssh rsync gettext-base

# Install QNM
RUN mkdir -p workspace && cd workspace && wget https://raw.githubusercontent.com/ConsenSys/QuorumNetworkManager/v0.8.1-beta/setup.sh && chmod +x setup.sh && ./setup.sh

WORKDIR /workspace/QuorumNetworkManager
ENTRYPOINT ["/bin/bash", "-i", "-c"]
