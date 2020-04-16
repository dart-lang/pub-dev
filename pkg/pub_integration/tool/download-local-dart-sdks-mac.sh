#!/usr/bin/env bash
# Downloads Dart SDKs for Mac to test old (and bleeding edge) pub clients for potential breaking changes.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PUB_INTEGRATION_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"
PROJECT_DIR="$( cd ${PUB_INTEGRATION_DIR}/../.. && pwd )"
LOCAL_DART_SDKS_DIR="${PUB_INTEGRATION_DIR}/.local-dart-sdks"

# Change to pkg/pub_integration/.dart-sdks folder
mkdir ${LOCAL_DART_SDKS_DIR}
cd ${LOCAL_DART_SDKS_DIR}

# Clear previously downloaded SDKs
rm -rf ${LOCAL_DART_SDKS_DIR}/*

# Last 1.X stable
curl -sS https://storage.googleapis.com/dart-archive/channels/stable/release/1.24.3/sdk/dartsdk-macos-x64-release.zip >dartsdk.zip
unzip -q dartsdk.zip && rm -f dartsdk.zip
mv dart-sdk dart-sdk-1.24.3

# Current bleeding edge
curl -sS https://storage.googleapis.com/dart-archive/channels/dev/release/2.8.0-dev.20.0/sdk/dartsdk-macos-x64-release.zip >dartsdk.zip
unzip -q dartsdk.zip && rm -f dartsdk.zip
mv dart-sdk dart-sdk-2.8.0-dev.20.0
