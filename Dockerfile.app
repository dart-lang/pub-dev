# Stage 0: Build signature verifier
FROM golang:latest AS go-build
RUN apt-get update && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*
WORKDIR /project
COPY pkg/signature_verifier /project/pkg/signature_verifier
RUN cd /project/pkg/signature_verifier && ./build.sh

# Keep version in-sync with .github/workflows/all-test.yml and app/lib/shared/versions.dart
FROM mirror.gcr.io/library/dart:3.11.0 AS build

# After install we remove the apt-index again to keep the docker image diff small.
RUN apt-get update && \
  apt-get upgrade -y && \
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
COPY pubspec.lock /project/pubspec.lock
COPY pubspec.yaml /project/pubspec.yaml

WORKDIR /project/pkg/web_app
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_app
RUN ./build.sh

WORKDIR /project/pkg/web_css
RUN dart /project/tool/pub_get_offline.dart /project/pkg/web_css
RUN ./build.sh

WORKDIR /project/app
RUN dart /project/tool/pub_get_offline.dart /project/app

RUN /project/tool/download-sdk-index-jsons.sh

# Generate JIT snapshot. We run it with --help to make it exit.
RUN dart compile jit-snapshot -o server.jit bin/server.dart --help

# Create /tmp directory for the runtime.
RUN mkdir -p /project/tmp && chmod 1777 /project/tmp

# Compile isolate entrypoints to kernel snapshots.
RUN dart compile kernel -o search_index.dill lib/service/entrypoint/search_index.dart
RUN dart compile kernel -o sdk_isolate_index.dill lib/service/entrypoint/sdk_isolate_index.dart

# Build minimal serving image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /project/tmp /tmp
COPY --from=build /usr/lib/dart /usr/lib/dart
COPY --from=build /project/app/server.jit /project/app/
COPY --from=build /project/static /project/static
COPY --from=build /project/app/config /project/app/config
COPY --from=build /project/app/migrations /project/app/migrations
COPY --from=build /project/third_party /project/third_party
COPY --from=build /project/doc /project/doc
COPY --from=build /project/app/lib/frontend/templates /project/app/lib/frontend/templates
COPY --from=build /project/app/.dart_tool/pub-search-data /project/app/.dart_tool/pub-search-data
COPY --from=build /project/.dart_tool/package_config.json /project/.dart_tool/package_config.json
COPY --from=go-build /project/pkg/signature_verifier/signature_verifier /project/app/signature_verifier
# Put the kernel snapshots at the same place as the source files for Isolate.spawnUri to work transparently.
COPY --from=build /project/app/search_index.dill /project/app/search_index.dill
COPY --from=build /project/app/sdk_isolate_index.dill /project/app/sdk_isolate_index.dill

WORKDIR /project/app
EXPOSE 8080
ENTRYPOINT ["/usr/lib/dart/bin/dart", "/project/app/server.jit"]
