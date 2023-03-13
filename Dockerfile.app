# Keep version in-sync with .mono_repo.yml and app/lib/shared/versions.dart
FROM dart:2.19.0

# After install we remove the apt-index again to keep the docker image diff small.
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y git unzip webp && \
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
RUN /project/tool/setup-dart.sh /tool/stable 2.19.4
RUN /project/tool/setup-dart.sh /tool/preview 3.0.0-305.0.dev

# Setup analysis Flutter SDKs
RUN /project/tool/setup-flutter.sh /tool/stable 3.7.7
RUN /project/tool/setup-flutter.sh /tool/preview 3.8.0-10.1.pre
RUN /project/tool/setup-flutter.sh /tool/future master

# Clear out any arguments the base images might have set
CMD []
ENTRYPOINT /usr/lib/dart/bin/dart bin/server.dart "$GAE_SERVICE"
