#===============================================================================
# FROMFREEZE docker.io/library/haskell:8.6.5
FROM docker.io/library/haskell@sha256:6ae86033bfa75027fc36a63bb69e7fa41d4e7df6ae4a78baeb77dafc94488d81

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
    mkdir -p ${HOME}/repo && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
WORKDIR ${HOME}/repo

COPY --chown=x:x lib/ ./lib/
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo/lib/libsodium

RUN ./autogen.sh && \
    ./configure && \
    make
#-------------------------------------------------------------------------------
USER root

RUN make install
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo/lib/cardano-node

ENV LD_LIBRARY_PATH /usr/local/lib:$LD_LIBRARY_PATH

RUN cabal v2-update && \
    cabal v2-install -j \
        cardano-cli \
        cardano-node
#-------------------------------------------------------------------------------
ENV PATH ${HOME}/.cabal/bin:$PATH

CMD scripts/mainnet.sh --verbose
#===============================================================================
