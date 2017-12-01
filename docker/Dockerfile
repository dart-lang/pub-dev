FROM google/dart-runtime-base:2.0.0-dev.8.0

# `apt-mark hold dart` ensures that Dart is not upgraded with the other packages
#   We want to make sure SDK upgrades are explicit.

# After install we remove the apt-index again to keep the docker image diff small.
RUN apt-mark hold dart &&\
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git unzip && \
    rm -rf /var/lib/apt/lists/*

# Let the pub server know that this is not a "typical" pub client but rather a bot.
ENV PUB_ENVIRONMENT="bot.pub_dartlang_org.docker"

ENV FLUTTER_SDK="/flutter"

RUN git clone -b 0.0.18 --single-branch https://github.com/flutter/flutter.git /flutter && \
  cd /flutter && \
  /flutter/bin/flutter config --no-analytics
