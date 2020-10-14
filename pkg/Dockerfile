#===============================================================================
# FROMFREEZE docker.io/library/debian:9
FROM docker.io/library/debian@sha256:7317c3e3f5a1139d5a00407735bba8fbce2cf8f3c5b9c03f71ae21434e34e8cf

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
