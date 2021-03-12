FROM ruby:2.3-slim


RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        default-libmysqlclient-dev \
        git \
        libffi-dev \
        libpq-dev \
        libssl-dev \
        mysql-client \
        libgtk2.0-0 \
        libgtk-3-0 \
        libgbm-dev \
        libnotify-dev \
        libgconf-2-4 \
        libnss3 \
        libxss1 \
        libxtst6 \
        xauth \
        xvfb

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
        apt-get install -y nodejs && \
        rm -rf /var/lib/apt/lists/*

# js formatting
RUN npm install --save-dev husky lint-staged prettier
# install cypress
RUN npm install --save-dev cypress
