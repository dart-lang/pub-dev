#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CODE_COVERAGE_DIR="${SCRIPT_DIR}"
PROJECT_DIR="$( cd ${CODE_COVERAGE_DIR}/../.. && pwd )"
APP_DIR="${PROJECT_DIR}/app"
ALL_TEST_NAME="_all_tests.dart"
APP_ALL_TEST_PATH="${APP_DIR}/test/${ALL_TEST_NAME}"
PUB_INTEGRATION_DIR="${PROJECT_DIR}/pkg/pub_integration"
PUB_INTEGRATION_ALL_TEST_PATH="${PUB_INTEGRATION_DIR}/test/${ALL_TEST_NAME}"

OUTPUT_DIR="${CODE_COVERAGE_DIR}/build"

rm -rf ${OUTPUT_DIR}
mkdir -p "${OUTPUT_DIR}/raw"

cd "${CODE_COVERAGE_DIR}"
pub get

## Collect coverage for app tests.

echo "Generate ${APP_ALL_TEST_PATH}..."
cd "${CODE_COVERAGE_DIR}"
dart lib/generate_all_tests.dart \
  --dir "${APP_DIR}/test" \
  --name ${ALL_TEST_NAME}

pub run coverage:collect_coverage \
  --uri=http://localhost:20202 \
  -o "${OUTPUT_DIR}/raw/app_unit.json" \
  --wait-paused \
  --resume-isolates &
COVERAGE_PID=$!

cd "${APP_DIR}"
dart \
  --pause-isolates-on-exit \
  --enable-vm-service=20202 \
  --disable-service-auth-codes \
  ${APP_ALL_TEST_PATH}

echo "Delete ${APP_ALL_TEST_PATH}..."
rm ${APP_ALL_TEST_PATH}

echo "Waiting for app_unit code coverage to complete..."
wait ${COVERAGE_PID}

## Collect coverage for integration tests.

echo "Generate ${PUB_INTEGRATION_ALL_TEST_PATH}..."
cd "${CODE_COVERAGE_DIR}"
dart lib/generate_all_tests.dart \
  --dir "${PUB_INTEGRATION_DIR}/test" \
  --name ${ALL_TEST_NAME}

cd "${CODE_COVERAGE_DIR}"
pub run coverage:collect_coverage \
  --uri=http://localhost:29999 \
  -o "${OUTPUT_DIR}/raw/pub_integration_fake_pub_server.json" \
  --wait-paused \
  --resume-isolates &
COVERAGE_PID=$!

cd "${PUB_INTEGRATION_DIR}"
pub get
dart \
  --pause-isolates-on-exit \
  --enable-vm-service=29999 \
  --disable-service-auth-codes \
  ${PUB_INTEGRATION_ALL_TEST_PATH}

echo "Waiting for pub_integration_fake_pub_server code coverage to complete..."
wait ${COVERAGE_PID}

echo "Delete ${PUB_INTEGRATION_ALL_TEST_PATH}..."
rm ${PUB_INTEGRATION_ALL_TEST_PATH}

## Processing coverage

cd "${CODE_COVERAGE_DIR}"
mkdir -p "${OUTPUT_DIR}/lcov"
echo "Exporting to LCOV"
ls -1 "${OUTPUT_DIR}/raw" | xargs -n 1 -I ZZZ pub run coverage:format_coverage \
  --packages "${APP_DIR}/.packages" \
  -i "${OUTPUT_DIR}/raw/ZZZ" \
  --base-directory "${PROJECT_DIR}" \
  --lcov \
  --out "${OUTPUT_DIR}/lcov/ZZZ.info"

echo "Generating report..."
dart lib/format_lcov.dart
