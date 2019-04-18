#!/usr/bin/env bash
# Compiles script.dart to JavaScript and places the output in the static/js directory.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_APP_DIR="${SCRIPT_DIR}"
PROJECT_DIR="$( cd ${WEB_APP_DIR}/../.. && pwd )"
STATIC_DIR="${PROJECT_DIR}/static"

# Change to web_app folder
cd "${WEB_APP_DIR}";

dart2js \
  --csp \
  --dump-info \
  --minify \
  --trust-primitives \
  --omit-implicit-checks \
  "${WEB_APP_DIR}/lib/script.dart" \
  -o \
  "${STATIC_DIR}/js/script.dart.js"
