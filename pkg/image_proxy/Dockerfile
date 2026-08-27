# Use latest stable channel SDK.
FROM mirror.gcr.io/library/dart:3.13.0 AS build

ENV PUB_ENVIRONMENT="bot"
ENV PUB_CACHE="/project/.pub-cache"

# Resolve app dependencies.
WORKDIR /app
COPY . .
RUN dart pub get --enforce-lockfile
RUN dart compile exe pkg/image_proxy/bin/server.dart -o server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/server /app/bin/

# Set Dart VM options for container execution:
# - --old_gen_heap_size=768 caps the old generation heap to trigger GC before container cgroup limits.
ENV DART_VM_OPTIONS="--old_gen_heap_size=768"

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
