FROM debian:jessie

MAINTAINER Lior Goikhburg <goikhburg@gmail.com>

LABEL org.label-schema.vcs-type="Git" \
  org.label-schema.vcs-url="https://github.com/zerthimon/nettools"

RUN apt-get -y update \
  && apt-get -y --no-install-recommends -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    bash \
    wget \
    curl \
    ca-certificates \
    netcat \
    net-tools \
    iproute2 \
    telnet \
    procps \
    less \
    iputils-ping \
    jq \
    nmap \
    dnsutils \
    netcat-openbsd \
    traceroute \
  && apt-get clean all \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/* \
