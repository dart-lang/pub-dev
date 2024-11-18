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
mkdir -p "${OUTPUT_DIR}/lcov"
mkdir -p "${OUTPUT_DIR}/puppeteer"
mkdir -p "${OUTPUT_DIR}/raw"

cd "${CODE_COVERAGE_DIR}"
dart pub get

## Run coverage in pkg/
dart bin/code_coverage.dart

## Collect coverage for app tests.

echo "Generate ${APP_ALL_TEST_PATH}..."
cd "${CODE_COVERAGE_DIR}"
dart lib/generate_all_tests.dart \
  --dir "${APP_DIR}/test" \
  --name ${ALL_TEST_NAME}

cd "${APP_DIR}"
dart \
  --pause-isolates-on-exit \
  --enable-vm-service=20202 \
  --disable-service-auth-codes \
  ${APP_ALL_TEST_PATH} &
APP_TEST_PID=$!

sleep 15;

cd "${CODE_COVERAGE_DIR}"
dart run coverage:collect_coverage \
  --uri=http://localhost:20202 \
  -o "${OUTPUT_DIR}/raw/app_unit.json" \
  --wait-paused \
  --resume-isolates &
COVERAGE_PID=$!

echo "Waiting for app_unit test to complete..."
wait ${APP_TEST_PID}

echo "Waiting for app_unit code coverage to complete..."
wait ${COVERAGE_PID}

cd "${APP_DIR}"
echo "Delete ${APP_ALL_TEST_PATH}..."
rm ${APP_ALL_TEST_PATH}

echo "Exporting to LCOV"
cd "${APP_DIR}"
dart run coverage:format_coverage \
  --packages "${PROJECT_DIR}/.dart_tool/package_config.json" \
  -i "${OUTPUT_DIR}/raw/app_unit.json" \
  --base-directory "${PROJECT_DIR}" \
  --lcov \
  --out "${OUTPUT_DIR}/lcov/app_unit.json.info"

## Collect coverage for integration tests.

cd "${CODE_COVERAGE_DIR}"
ls -1 "${PUB_INTEGRATION_DIR}/test" | grep .dart$ | xargs -n 1 -I ZZZ dart \
  lib/test_runner.dart \
  --package "${PUB_INTEGRATION_DIR}" \
  --test test/ZZZ \
  --prefix ZZZ \
  --app-dir "${APP_DIR}"

## Processing coverage

echo "Converting browser coverages to LCOV"
dart lib/source_map_coverage.dart

echo "Generating report..."
dart lib/format_lcov.dart
