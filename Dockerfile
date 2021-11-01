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
    curl -fsSL https://deb.nodesource.com/setup_$NODEJS | bash && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /usr/share/keyrings/yarnkey.gpg >/dev/null && \
    echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y nodejs yarn && \
    npm i -g npm@^6 && \
    apt-mark hold nodejs

RUN \
    wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y 	google-chrome-stable
