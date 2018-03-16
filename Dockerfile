# Keep version in-sync with .travis.yml and app/lib/shared/versions.dart
FROM google/dart-runtime-base:2.0.0-dev.37.0

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

ADD pkg /project/pkg

WORKDIR /project/app

ADD static /project/static
ADD app/pubspec.* /project/app/
RUN pub get --no-precompile
ADD app /project/app
RUN pub get --offline --no-precompile

## NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub

# Clear out any arguments the base images might have set and ensure we start
# memcached and wait for it to come up before running the Dart app.
CMD []
ENTRYPOINT /bin/bash /dart_runtime/dart_run.sh
