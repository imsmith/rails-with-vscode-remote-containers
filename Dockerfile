#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM ruby:3.0

# Install ruby-debug-ide and debase
RUN gem install ruby-debug-ide debase solargraph

# Install git, process tools
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get update && \
    apt-get -y install git procps nodejs

RUN npm install -g yarn

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Set the default shell to bash instead of sh
ENV SHELL /bin/bash

WORKDIR /usr/src/app
COPY ./Gemfile ./Gemfile.lock ./
RUN bundle update --bundler && bundle install

EXPOSE 3000
