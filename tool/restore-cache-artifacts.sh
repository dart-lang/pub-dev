#!/bin/bash
# Restores compiled artifacts from $PUB_CACHE/artifacts
# Should be used only in travis.

set -e

ARTIFACT_DIR="$HOME/.pub-cache/artifacts"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_DIR="$( cd ${SCRIPT_DIR}/.. && pwd )"

if [[ -e "${ARTIFACT_DIR}/js/script.dart.js" ]]; then
  mkdir -p ${PROJECT_DIR}/static/js
  cp ${ARTIFACT_DIR}/js/script.dart.js* ${PROJECT_DIR}/static/js/
fi

if [[ -e "${ARTIFACT_DIR}/css/style.css" ]]; then
  mkdir -p ${PROJECT_DIR}/static/css
  cp ${ARTIFACT_DIR}/css/style.css* ${PROJECT_DIR}/static/css/
fi
