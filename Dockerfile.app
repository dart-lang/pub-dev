# Stage 0: Build signature verifier
FROM golang:latest AS go-build
RUN apt-get update && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*
WORKDIR /project
COPY pkg/signature_verifier /project/pkg/signature_verifier
RUN cd /project/pkg/signature_verifier && ./build.sh

# Keep version in-sync with .github/workflows/all-test.yml and app/lib/shared/versions.dart
FROM mirror.gcr.io/library/dart:3.13.0 AS build

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

# Generate the JIT snapshot, with the native assets mapping of package:sigstore
# and package:boring embedded (see tool/build-server-snapshot.sh). The libraries
# are built in the native-build stage below and copied to the given paths in
# the final image.
RUN /project/tool/build-server-snapshot.sh /project/app/server.jit \
  /project/app/libsigstore_ffi.so /project/app/libbssl_dart.so

# Collect what the native-build and final stages need from this one:
#  - the Rust source of package:sigstore's native library, as resolved by pub,
#  - the CMake project and vendored BoringSSL of package:boring, as resolved
#    by pub,
#  - libgcc_s, which the Rust library depends on and which is not part of the
#    minimal /runtime of the Dart image.
RUN set -eux; \
  SIGSTORE_DIRS="$(ls -d /project/.pub-cache/hosted/pub.dev/sigstore-*/)"; \
  [ "$(echo "$SIGSTORE_DIRS" | wc -l)" -eq 1 ]; \
  cp -r "${SIGSTORE_DIRS}rust" /project/sigstore-rust; \
  BORING_DIRS="$(ls -d /project/.pub-cache/hosted/pub.dev/boring-*/)"; \
  [ "$(echo "$BORING_DIRS" | wc -l)" -eq 1 ]; \
  mkdir -p /project/boring; \
  cp -r "${BORING_DIRS}src" "${BORING_DIRS}third_party" /project/boring/; \
  case "$(dpkg --print-architecture)" in \
    amd64) TRIPLET="x86_64-linux-gnu" ;; \
    arm64) TRIPLET="aarch64-linux-gnu" ;; \
    *) echo "Unsupported architecture"; exit 1 ;; \
  esac; \
  mkdir -p "/project/runtime-extra/lib/$TRIPLET"; \
  cp --dereference "/lib/$TRIPLET/libgcc_s.so.1" "/project/runtime-extra/lib/$TRIPLET/libgcc_s.so.1"

# Create /tmp directory for the runtime.
RUN mkdir -p /project/tmp && chmod 1777 /project/tmp

# Compile isolate entrypoints to kernel snapshots.
RUN dart compile kernel -o search_index.dill lib/service/entrypoint/search_index.dart
RUN dart compile kernel -o sdk_isolate_index.dill lib/service/entrypoint/sdk_isolate_index.dart

# Stage: Build the native libraries of package:sigstore and package:boring from
# the sources bundled with the packages (no prebuilt binaries are downloaded):
#  - libsigstore_ffi.so from the Rust crate of package:sigstore, which calls
#    BoringSSL through function pointers it receives from Dart at startup, so
#    it does not link against it;
#  - libbssl_dart.so from the CMake project of package:boring, the same build
#    its `checkout` build mode runs (hook/build.dart), which installs the
#    dynamic (and static) library into the install prefix.
FROM mirror.gcr.io/library/rust:1.99-bookworm AS native-build
RUN apt-get update && \
  apt-get install -y --no-install-recommends cmake && \
  rm -rf /var/lib/apt/lists/*
COPY --from=build /project/sigstore-rust /project/sigstore-rust
WORKDIR /project/sigstore-rust
RUN cargo rustc --release --locked --crate-type=cdylib && \
  test -f target/release/libsigstore_ffi.so
COPY --from=build /project/boring /project/boring
WORKDIR /project/boring
RUN cmake -S src -B build -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/project/boring/install && \
  cmake --build build --target install --parallel && \
  test -f install/libbssl_dart.so

# Build minimal serving image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /project/runtime-extra/ /
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
# Must match the paths given to tool/build-server-snapshot.sh above.
COPY --from=native-build /project/sigstore-rust/target/release/libsigstore_ffi.so /project/app/libsigstore_ffi.so
COPY --from=native-build /project/boring/install/libbssl_dart.so /project/app/libbssl_dart.so
# Put the kernel snapshots at the same place as the source files for Isolate.spawnUri to work transparently.
COPY --from=build /project/app/search_index.dill /project/app/search_index.dill
COPY --from=build /project/app/sdk_isolate_index.dill /project/app/sdk_isolate_index.dill

COPY --from=build /bin/sh /bin/sh
COPY --from=build /bin/sleep /bin/sleep
COPY --from=build /project/tool/run-wrapper.sh /project/tool/run-wrapper.sh

WORKDIR /project/app
EXPOSE 8080
ENTRYPOINT ["/project/tool/run-wrapper.sh", "/usr/lib/dart/bin/dart", "/project/app/server.jit"]
