# Keep version in-sync with .mono_repo.yml and app/lib/shared/versions.dart
FROM google/dart-runtime-base:2.14.1

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
ENV PUB_CACHE="/project/.pub-cache"

COPY app /project/app
COPY pkg /project/pkg
COPY static /project/static
COPY doc /project/doc
COPY third_party /project/third_party
COPY tool /project/tool

WORKDIR /project/pkg/pub_dartdoc
RUN dart /project/tool/pub_get_offline.dart /project/pkg/pub_dartdoc

WORKDIR /project/pkg/web_app
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_app
RUN ./build.sh

WORKDIR /project/pkg/web_css
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_css
RUN ./build.sh

WORKDIR /project/app
RUN dart /project/tool/pub_get_offline.dart /project/app

# Setup analysis Dart SDKs
RUN /project/tool/setup-dart.sh /tool/stable https://storage.googleapis.com/dart-archive/channels/stable/raw/2.15.0/sdk/dartsdk-linux-x64-release.zip
RUN /project/tool/setup-dart.sh /tool/preview https://storage.googleapis.com/dart-archive/channels/dev/release/2.16.0-63.0.dev/sdk/dartsdk-linux-x64-release.zip

# Setup analysis Flutter SDKs
RUN /project/tool/setup-flutter.sh /tool/stable 2.5.3
RUN /project/tool/setup-flutter.sh /tool/preview 2.8.0-3.3.pre

# Clear out any arguments the base images might have set
CMD []
ENTRYPOINT /usr/bin/dart bin/server.dart "$GAE_SERVICE"
