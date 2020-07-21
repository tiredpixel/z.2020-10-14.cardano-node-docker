#===============================================================================
# FROMFREEZE docker.io/library/haskell:8.6.5
FROM docker.io/library/haskell@sha256:6ae86033bfa75027fc36a63bb69e7fa41d4e7df6ae4a78baeb77dafc94488d81

ARG USER=x
ARG HOME=/home/x
#-------------------------------------------------------------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        daemontools && \
    rm -rf /var/lib/apt/lists/*

RUN useradd ${USER} -d ${HOME} && \
    mkdir -p ${HOME}/repo && \
    chown -R ${USER}:${USER} ${HOME}
#-------------------------------------------------------------------------------
USER ${USER}

WORKDIR ${HOME}/repo

ENV PATH ${HOME}/.cabal/bin:$PATH

COPY --chown=x:x [ \
    "cabal.config", \
    "*.cabal", \
    "./"]

RUN cabal v1-update && \
    cabal v1-install -j --only-dependencies --enable-tests
#-------------------------------------------------------------------------------
#ENV ADDRESS=0.0.0.0 \
#    PORT=8000
#
#CMD cabal v1-run isx-plugin-crawler-html -- -b ${ADDRESS} -p ${PORT}
#
#EXPOSE ${PORT}
#
#HEALTHCHECK CMD curl -fs http://${ADDRESS}:${PORT} || false
#===============================================================================
