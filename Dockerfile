#===============================================================================
# FROMFREEZE docker.io/library/haskell:8.6.5
FROM docker.io/library/haskell@sha256:64352f810b8cbbc79ec55150cc88105586a280c0f0ea0cedfa0ed2e9f1454de1

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        build-essential \
        daemontools \
        g++ \
        git \
        jq \
        libffi-dev \
        libgmp-dev \
        libncursesw5 \
        libssl-dev \
        libsystemd-dev \
        libtinfo-dev \
        libtool \
        make \
        pkg-config \
        tmux \
        wget \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/repo/lib/cardano-node && \
    mkdir -p ${HOME}/repo/lib/libsodium && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo/lib/libsodium

COPY --chown=x:x lib/libsodium ./

RUN ./autogen.sh && \
    ./configure && \
    make
#-------------------------------------------------------------------------------
USER root

RUN make install
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo/lib/cardano-node

COPY --chown=x:x lib/cardano-node ./

ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH

RUN cabal v2-update && \
    cabal v2-install -O2 -j all
#-------------------------------------------------------------------------------
ENV PORT=3001 \
    PATH=${HOME}/repo/bin:${HOME}/.cabal/bin:$PATH \
    CRD_DATA=/var/lib/cardano \
    CARDANO_NODE_SOCKET_PATH=/var/lib/cardano/socket/cardano-node.socket

CMD cardano-node-relay

EXPOSE ${PORT}
#===============================================================================
