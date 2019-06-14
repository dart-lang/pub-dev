# Keep version in-sync with .travis.yml, .mono_repo.yml and app/lib/shared/versions.dart
FROM google/dart-runtime-base:2.3.2

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

COPY app /project/app
COPY pkg /project/pkg
COPY static /project/static
COPY third_party /project/third_party

WORKDIR /project/pkg/pub_dartdoc
RUN pub get --no-precompile
RUN pub get --offline --no-precompile

WORKDIR /project/pkg/web_app
RUN pub get --no-precompile
RUN pub get --offline --no-precompile
RUN ./build.sh

WORKDIR /project/pkg/web_css
RUN pub get --no-precompile
RUN pub get --offline --no-precompile
RUN ./build.sh

WORKDIR /project/app
RUN pub get --no-precompile
RUN pub get --offline --no-precompile

## NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub

RUN cd / && \
  curl -sS https://storage.googleapis.com/dart-archive/channels/stable/raw/2.3.2/sdk/dartsdk-linux-x64-release.zip >/dartsdk.zip && \
  unzip -q /dartsdk.zip && \
  rm -f /dartsdk.zip

# Clear out any arguments the base images might have set and ensure we start
# memcached and wait for it to come up before running the Dart app.
CMD []
ENTRYPOINT /bin/bash /dart_runtime/dart_run.sh
