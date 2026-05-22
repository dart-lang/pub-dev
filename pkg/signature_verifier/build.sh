#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# 1. Build the CLI executable using Dart's build command to support native assets
dart build cli --output=build -t bin/signature_verifier.dart

# 2. Extract the binary and its native assets.
# The binary expects libwebcrypto.so at '../lib/libwebcrypto.so' relative to its internal path,
# but when flattened, placing it in a 'lib' sibling directory is the standard bundle structure
# that works without a wrapper.
cp ./build/bundle/bin/signature_verifier ./signature_verifier
mkdir -p lib
cp ./build/bundle/lib/libwebcrypto.so ./lib/libwebcrypto.so

# 3. Set execution permissions
chmod +x ./signature_verifier
