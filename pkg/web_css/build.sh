#!/usr/bin/env bash
# Compiles style.scss to style.css and places the output in the static/css directory.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
WEB_CSS_DIR="${SCRIPT_DIR}"
PROJECT_DIR="$( cd ${WEB_CSS_DIR}/../.. && pwd )"
STATIC_DIR="${PROJECT_DIR}/static"
OUTPUT_DIR="${STATIC_DIR}/css"

mkdir -p ${OUTPUT_DIR}

# Change to web_css folder
cd "${WEB_CSS_DIR}";

pub run sass \
  --style=compressed \
  "${WEB_CSS_DIR}/lib/style.scss" \
  "${OUTPUT_DIR}/style.css"
