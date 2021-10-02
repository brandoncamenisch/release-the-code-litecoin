FROM    ubuntu:21.04 AS lettherebelite
ARG     LITECOIN_VERSION

# This label will automatically connect this repository to the published docker image without it this becomes a manual step.
LABEL org.opencontainers.image.source https://github.com/brandoncamenisch/release-the-code-litecoin

# RUN command below installs necessary dependencies to install litecoin and are afterwards cleaned up
# gpg key id can be found https://pgp.mit.edu/pks/lookup?op=get&search=0xFE3348877809386C which is linked on https://litecoin.org/ download section
RUN     apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        dirmngr \
        gpg \
        gpg-agent \
        wget \
        && wget -q https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
        && wget -q https://download.litecoin.org/litecoin-${LITECOIN_VERSION}/linux/litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz.asc \
        && gpg --keyserver pgp.mit.edu --recv-key FE3348877809386C \
        && gpg --verify litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz.asc \
        && tar xfz /litecoin-${LITECOIN_VERSION}-x86_64-linux-gnu.tar.gz \
        && mv litecoin-${LITECOIN_VERSION}/bin/* /usr/local/bin/ \
        && rm -rf litecoin-* /root/.gnupg/ \
        && apt-get remove --purge -y \
        ca-certificates \
        dirmngr \
        gpg \
        gpg-agent \
        wget \
        && apt-get autoremove --purge -y \
        && rm -r /var/lib/apt/lists/*

# Add a litecoin user to rund the daemon
RUN useradd -ms /bin/false -u 1001 -U litecoin
USER litecoin
# Run as the litecoind daemon
ENTRYPOINT ["/usr/local/bin/litecoind"]