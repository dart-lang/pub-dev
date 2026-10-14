#!/bin/bash
set -e
shopt -s nullglob

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSIONS_FILE="$SCRIPT_DIR/../../app/lib/shared/versions.dart"
DARTDOC_VERSION=$(sed -n "s/^final String dartdocVersion = '\(.*\)';/\1/p" "$VERSIONS_FILE")

if [[ -z "$DARTDOC_VERSION" ]]; then
  echo "Could not extract dartdocVersion from $VERSIONS_FILE" >&2
  exit 1
fi

TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

# Download dartdoc at the pinned version
PUB_CACHE="$TEMP_DIR/pub-cache" dart pub unpack "dartdoc:${DARTDOC_VERSION}" --no-resolve --output="$TEMP_DIR"
UNPACKED_DIR="$TEMP_DIR/dartdoc-${DARTDOC_VERSION}"

# Delete resources/
rm -rf "$SCRIPT_DIR/resources"

# Copy css, js, png files to resources/
mkdir "$SCRIPT_DIR/resources"
cp -r "$UNPACKED_DIR"/lib/resources/*.{js,css,png,svg,map} "$SCRIPT_DIR/resources/"

# Copy license
cp "$UNPACKED_DIR/LICENSE" "$SCRIPT_DIR/"
