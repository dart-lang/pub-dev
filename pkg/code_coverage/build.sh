#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CODE_COVERAGE_DIR="${SCRIPT_DIR}"
PROJECT_DIR="$( cd ${CODE_COVERAGE_DIR}/../.. && pwd )"
APP_DIR="${PROJECT_DIR}/app"
APP_TEST_NAME="_all_tests.dart"
APP_TEST_PATH="${APP_DIR}/test/${APP_TEST_NAME}"

OUTPUT_DIR="${CODE_COVERAGE_DIR}/build"

rm -rf ${OUTPUT_DIR}
mkdir -p "${OUTPUT_DIR}/raw"

cd "${CODE_COVERAGE_DIR}"
pub get

echo "Generate ${APP_TEST_PATH}..."
dart lib/generate_all_tests.dart \
  --dir "${APP_DIR}/test" \
  --name ${APP_TEST_NAME}

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
  ${APP_TEST_PATH}

echo "Delete ${APP_TEST_PATH}..."
rm ${APP_TEST_PATH}

# wait on coverage collection to complete
echo "Waiting for code coverage to complete..."
wait ${COVERAGE_PID}

cd "${CODE_COVERAGE_DIR}"
echo "Exporting to LCOV"
pub run coverage:format_coverage \
  --packages "${APP_DIR}/.packages" \
  -i "${OUTPUT_DIR}/raw/app_unit.json" \
  --base-directory "${PROJECT_DIR}" \
  --lcov \
  --out "${OUTPUT_DIR}/lcov.info"

echo "Generating report..."
dart lib/format_lcov.dart
