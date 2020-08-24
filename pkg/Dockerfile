#===============================================================================
# FROMFREEZE docker.io/library/debian:9
FROM docker.io/library/debian@sha256:15ddab04de32435c7fd51a15dffa8643ee605a0c9a2fd0ac4f5aac2cf0a95e69

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq \
        netbase \
        wget && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/bin && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
COPY lib/ /usr/local/lib/
COPY bin/ ${HOME}/bin/
COPY .version ${HOME}/.version
COPY bin/.bashrc ${HOME}/.bashrc
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}

ENV PORT=3001 \
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
    PATH=${HOME}/bin:$PATH \
    CRD_DATA=/var/lib/cardano \
    CARDANO_NODE_SOCKET_PATH=/var/lib/cardano/socket/cardano-node.socket

CMD cardano-node-relay
#===============================================================================
