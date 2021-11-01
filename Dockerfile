ARG NODEJS=12.x

FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG NODEJS
ENV LANG=C.UTF-8

RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        ca-certificates \
        curl \
        git \
        gpg \
        gpg-agent \
        groff \
        openssh-client \
        software-properties-common \
        unzip \
        wget

RUN \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

ARG NVM_DIR=/usr/local/nvm
RUN \
    mkdir -p $NVM_DIR && \
    export NVM_DIR=$NVM_DIR && \
    curl --silent -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install v12
