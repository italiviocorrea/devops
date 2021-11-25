FROM icorrea/alpine:3.10

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV ALPINE_EDGE_COMMUNITY_REPO=http://dl-cdn.alpinelinux.org/alpine/edge/community \
    CONDA_REPO=https://repo.continuum.io \
    CONDA_TYPE=archive \
    CONDA_INSTALLER=Anaconda3-2021.05-Linux-x86_64.sh \
    CONDA_DIR=/opt/conda \
    CONDA_USER=conda \
    CONDA_USER_HOME=/home/conda \
    PATH=/opt/conda/bin:$PATH

# Here we use several hacks collected from https://github.com/gliderlabs/docker-alpine/issues/11
# 1. install GLibc (which is not the cleanest solution at all)
# 2. hotfix /etc/nsswitch.conf, which is apperently required by glibc and is not used in Alpine Linux
RUN apk add --no-cache --virtual=build-dependencies \
    bash \
    bzip2 \
    ca-certificates \
    curl \
    wget \
    git \
    glib \
    expat \
    jq \
    less \
    libgcc \
    libsm \
    libstdc++ \
    libxext \
    libxrender \
    ncurses-terminfo-base \
    ncurses-terminfo \
    ncurses-libs \
    openssh-client \
    readline \
    unzip \
    && apk add --update --repository ${ALPINE_EDGE_COMMUNITY_REPO} tini \
    && cd /tmp \
    && wget "${CONDA_REPO}/${CONDA_TYPE}/${CONDA_INSTALLER}" \
    && bash ./"${CONDA_INSTALLER}" -b -p /opt/conda \
    && cd \
    && rm -rf /tmp/* /var/cache/apk/* \
    && echo 'export PATH=/opt/conda/bin:$PATH' >> /etc/profile.d/conda.sh

#\
#    && conda update --quiet --yes --all \
#    && conda clean --yes --tarballs \
#    && conda clean --yes --packages

# RUN conda create --quiet -n conda3 --clone=${CONDA_DIR}

# Add local files as late as possible to stay cache friendly
COPY conda.sh /usr/local/bin/

ENTRYPOINT ["tini", "--"]
CMD ["conda.sh"]


