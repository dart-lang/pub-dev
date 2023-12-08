# Keep version in-sync with .mono_repo.yml and app/lib/shared/versions.dart
FROM dart:3.2.0

# After install we remove the apt-index again to keep the docker image diff small.
RUN apt-get update && \
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

WORKDIR /project/pkg/web_app
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_app
RUN ./build.sh

WORKDIR /project/pkg/web_css
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_css
RUN ./build.sh

WORKDIR /project/app
RUN dart /project/tool/pub_get_offline.dart /project/app

RUN /project/tool/setup-webp.sh /usr/local/bin

# Clear out any arguments the base images might have set
CMD []
ENTRYPOINT /usr/lib/dart/bin/dart bin/server.dart "$GAE_SERVICE"
