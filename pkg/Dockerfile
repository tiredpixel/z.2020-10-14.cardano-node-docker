#===============================================================================
# FROMFREEZE docker.io/library/debian:9
FROM docker.io/library/debian@sha256:9db90d8ea0e09374bbd206cde64e3539f1e761be051cc6d1710070de95e914c3

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        netbase && \
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
    CRD_CONF=/etc/cardano \
    CRD_DATA=/var/lib/cardano

ENV CARDANO_NODE_SOCKET_PATH=/var/run/cardano-node.socket

CMD cardano-node-relay
#===============================================================================
