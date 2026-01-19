#!/usr/bin/env bash

# Compile a single dartdoc executable from sources.
# Usage: setup-dartdoc.sh /target/path <dartdoc-version>

set -e

TARGET_PATH=$1
DARTDOC_VERSION=$2

# Create a temporary directory
WORK_DIR=`mktemp -d`
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory."
  exit 1
fi
trap 'rm -rf "$WORK_DIR"' EXIT

# Download dartdoc
dart pub unpack "dartdoc:${DARTDOC_VERSION}" --output=${WORK_DIR}

# Compile executable
cd "${WORK_DIR}/dartdoc-${DARTDOC_VERSION}"
dart compile exe -o "${TARGET_PATH}" bin/dartdoc.dart
