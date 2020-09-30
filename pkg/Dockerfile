#===============================================================================
# FROMFREEZE docker.io/library/debian:9
FROM docker.io/library/debian@sha256:e7157902df9c7549eea5eb7b896cdca02d917e2ba0e339cd4a5087e2b53eb1d7

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        jq \
        libgmp-dev \
        netbase \
        netcat \
        wget && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/bin && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
COPY lib/ /usr/local/lib/
COPY bin/ ${HOME}/bin/
COPY --chown=x:x [ \
    "bin/.bashrc", \
    "${HOME}/"]
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}

ENV PORT=3001 \
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH \
    PATH=${HOME}/bin:$PATH \
    CRD_DATA=/var/lib/cardano \
    CARDANO_NODE_SOCKET_PATH=/var/lib/cardano/socket/cardano-node.socket

CMD cardano-node-relay

HEALTHCHECK --start-period=600s CMD cardano-node-healthcheck
#===============================================================================
