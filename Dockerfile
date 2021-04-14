FROM ubuntu/nginx

MAINTAINER Lior Goikhburg <goikhburg@gmail.com>

RUN apt-get -y update \
  && echo "tzdata tzdata/Areas select Europe" | debconf-set-selections \
  && echo "tzdata tzdata/Zones/Etc select UTC" | debconf-set-selections \
  && echo "tzdata tzdata/Zones/Europe select Moscow" | debconf-set-selections \
  && echo "locales locales/default_environment_locale select en_US.UTF-8" | debconf-set-selections \
  && echo "locales locales/locales_to_be_generated multiselect en_US.UTF-8 UTF-8, ru_RU.UTF-8 UTF-8" | debconf-set-selections \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    locales \
    tzdata \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    software-properties-common \
    apt-transport-https \
    debconf-utils \
    wget \
    curl \
    gnupg \
    ca-certificates \
    lsb-release \
    bash \
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
    vim \
    lynx \
  && wget -qO - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && echo "deb [ arch=amd64 ] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
  && add-apt-repository -y ppa:chris-lea/redis-server \
  && wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - \
  && echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb.list \
  && wget -qO - https://baltocdn.com/helm/signing.asc | apt-key add - \
  && echo "deb [ arch=amd64 ] https://baltocdn.com/helm/stable/debian/ all main" > /etc/apt/sources.list.d/helm.list \
  && wget -qO - https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb [ arch=amd64 ] https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list \
  && wget -qO /tmp/mysql-apt-config_0.8.16-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.16-1_all.deb \
  && echo "mysql-apt-config mysql-apt-config/select-product select Ok" | debconf-set-selections \
  && DEBIAN_FRONTEND=noninteractive dpkg -i /tmp/mysql-apt-config_0.8.16-1_all.deb \
  && rm -rf /tmp/mysql-apt-config_0.8.16-1_all.deb \
  && apt-get -y update \
  && DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install \
    helm \
    kubectl \
    postgresql-client \
    redis-tools \
    mongodb-org-shell \
    mysql-client \
  && apt-get clean all \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*
  && echo 'source <(/usr/bin/kubectl completion bash)' >> /etc/bash.bashrc \
  && echo 'source <(/usr/sbin/helm completion bash)' >> /etc/bash.bashrc
