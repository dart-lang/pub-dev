#!/usr/bin/env bash
# Runs the fake_pub_server pub integration test with the downloaded local Dart SDKs.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PUB_INTEGRATION_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"
PROJECT_DIR="$( cd ${PUB_INTEGRATION_DIR}/../.. && pwd )"
LOCAL_DART_SDKS_DIR="${PUB_INTEGRATION_DIR}/.local-dart-sdks"

# Change to pkg/pub_integration
ls -1 ${LOCAL_DART_SDKS_DIR} | while read i;
do
  echo "Running tests using ${i}..."
  PUB_INTEGRATION_CLIENT_SDK_DIR="${LOCAL_DART_SDKS_DIR}/${i}" pub run test test/pub_integration_test.dart
done
