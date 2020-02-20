#!/bin/bash
# Stores compiled artifacts in $PUB_CACHE/artifacts
# Should be used only in travis.

set -e

ARTIFACT_DIR="$HOME/.pub-cache/artifacts"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"

if [[ -e "${PROJECT_DIR}/static/js/script.dart.js" ]]; then
  mkdir -p ${ARTIFACT_DIR}/js
  cp ${PROJECT_DIR}/static/js/script.dart.js* ${ARTIFACT_DIR}/js
fi

if [[ -e "${PROJECT_DIR}/static/css/style.css" ]]; then
  mkdir -p ${ARTIFACT_DIR}/css
  cp ${PROJECT_DIR}/static/css/style.css* ${ARTIFACT_DIR}/css
fi
