#!/usr/bin/env bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Builds the app-JIT snapshot of the server, with the native assets mapping of
# `package:sigstore` and `package:boring` embedded.
#
# `package:sigstore` calls into a native library (`libsigstore_ffi.so`) through
# `@Native` bindings, and routes its cryptography through the BoringSSL of
# `package:boring` (`libbssl_dart.so`), another native library. The Dart VM
# resolves `@Native` bindings through a native assets mapping (asset id ->
# library path). `dart run` produces that mapping by executing the build hooks
# of the dependencies and embeds it in the kernel it runs; `dart compile
# jit-snapshot` does not, so a snapshot created by it has no way to find the
# libraries at runtime.
#
# This script does what `dart run` does, with a mapping that points at the
# location of the library in the production image:
#
#  1. compile `bin/server.dart` to kernel,
#  2. compile the mapping to a kernel component with the frontend server,
#  3. concatenate the two, and
#  4. create the app-JIT snapshot from the result (the VM keeps the mapping in
#     the snapshot, no build hooks or sources are needed at runtime).
#
# The libraries themselves are built from the sources bundled with the
# packages, see `Dockerfile.app`.
#
# Usage: build-server-snapshot.sh <output snapshot> \
#          <path of libsigstore_ffi.so at runtime> \
#          <path of libbssl_dart.so at runtime>

set -euo pipefail

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <output snapshot> <path of libsigstore_ffi.so at runtime> <path of libbssl_dart.so at runtime>" >&2
  exit 1
fi
OUTPUT="$1"
SIGSTORE_LIBRARY="$2"
BORING_LIBRARY="$3"

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
APP_DIR="$SCRIPT_DIR/../app"

DART_SDK="$(cd -- "$(dirname -- "$(readlink -f "$(command -v dart)")")/.." && pwd)"
DART_AOT_RUNTIME="$DART_SDK/bin/dartaotruntime"
FRONTEND_SERVER="$DART_SDK/bin/snapshots/frontend_server_aot.dart.snapshot"
if [ ! -x "$DART_AOT_RUNTIME" ] || [ ! -f "$FRONTEND_SERVER" ]; then
  echo "Could not find the frontend server in the Dart SDK at $DART_SDK" >&2
  exit 1
fi

case "$(uname -m)" in
  x86_64) DART_ARCH="x64" ;;
  aarch64 | arm64) DART_ARCH="arm64" ;;
  *)
    echo "Unsupported architecture: $(uname -m)" >&2
    exit 1
    ;;
esac

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

cd "$APP_DIR"

# 1. The server as kernel.
dart compile kernel -o "$WORK_DIR/server.dill" bin/server.dart

# 2. The native assets mapping as kernel component. The asset ids are the ones
#    the build hooks of the packages register: for `package:sigstore` the
#    library URI of its `@Native` bindings, for `package:boring` the
#    `@DefaultAsset` of its bindings.
cat > "$WORK_DIR/native_assets.yaml" <<EOF
{
  "format-version": [1, 0, 0],
  "native-assets": {
    "linux_$DART_ARCH": {
      "package:sigstore/src/bindings/lib.g.dart": ["absolute", "$SIGSTORE_LIBRARY"],
      "package:boring/boring.dart": ["absolute", "$BORING_LIBRARY"]
    }
  }
}
EOF
"$DART_AOT_RUNTIME" "$FRONTEND_SERVER" \
  --native-assets-only \
  --native-assets="$WORK_DIR/native_assets.yaml" \
  --output-dill="$WORK_DIR/native_assets.dill"

# 3. Kernel files can be concatenated.
cat "$WORK_DIR/server.dill" "$WORK_DIR/native_assets.dill" > "$WORK_DIR/server_with_native_assets.dill"

# 4. The app-JIT snapshot. The training run is started with `--help` to make it
#    exit right away.
dart --snapshot-kind=app-jit --snapshot="$OUTPUT" \
  "$WORK_DIR/server_with_native_assets.dill" --help

echo "Created $OUTPUT with native assets mapping:"
cat "$WORK_DIR/native_assets.yaml"
