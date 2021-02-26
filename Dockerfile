# Keep version in-sync with .mono_repo.yml and app/lib/shared/versions.dart
FROM google/dart-runtime-base:2.10.0

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
COPY doc /project/doc
COPY third_party /project/third_party

WORKDIR /project/pkg/pub_dartdoc
RUN dart pub get --no-precompile
RUN dart pub get --offline --no-precompile

WORKDIR /project/pkg/web_app
RUN dart pub get --no-precompile
RUN dart pub get --offline --no-precompile
RUN ./build.sh

WORKDIR /project/pkg/web_css
RUN dart pub get --no-precompile
RUN dart pub get --offline --no-precompile
RUN ./build.sh

WORKDIR /project/app
RUN dart pub get --no-precompile
RUN dart pub get --offline --no-precompile

## NOTE: Uncomment the following lines for local testing:
#ADD key.json /project/key.json
#ENV GCLOUD_KEY /project/key.json
#ENV GCLOUD_PROJECT dartlang-pub

RUN /project/app/script/setup-dart.sh /tool/stable https://storage.googleapis.com/dart-archive/channels/stable/release/2.12.0/sdk/dartsdk-linux-x64-release.zip
RUN /project/app/script/setup-dart.sh /tool/preview https://storage.googleapis.com/dart-archive/channels/beta/raw/2.12.0-259.16.beta/sdk/dartsdk-linux-x64-release.zip

RUN /project/app/script/setup-flutter.sh /tool/stable 1.22.6
RUN /project/app/script/setup-flutter.sh /tool/preview 1.26.0-17.8.pre

# Clear out any arguments the base images might have set
CMD []
ENTRYPOINT /usr/bin/dart bin/server.dart "$GAE_SERVICE"
