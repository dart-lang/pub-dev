#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# 1. Build the CLI executable using Dart's build command to support native assets
dart build cli --output=build -t bin/signature_verifier.dart

# 2. Extract the binary and its native assets.
# The binary expects libwebcrypto.so at '../lib/libwebcrypto.so' relative to its internal path.
# We keep the bin/ and lib/ structure from the bundle inside a dist/ directory.
mkdir -p dist/bin dist/lib
cp ./build/bundle/bin/signature_verifier ./dist/bin/signature_verifier
cp ./build/bundle/lib/libwebcrypto.so ./dist/lib/libwebcrypto.so
