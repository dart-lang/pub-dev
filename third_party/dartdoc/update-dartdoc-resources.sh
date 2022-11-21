#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEMP_DIR=$(mktemp -d)

# Clone dartdoc repository
git clone https://github.com/dart-lang/dartdoc "$TEMP_DIR"

# Delete resources/
rm -rf "$SCRIPT_DIR/resources"

# Copy css, js, png files to resources/
mkdir "$SCRIPT_DIR/resources"
cp -r "$TEMP_DIR"/lib/resources/*.{js,css,png,svg,map} "$SCRIPT_DIR/resources/"

# Copy license
cp "$TEMP_DIR/LICENSE" "$SCRIPT_DIR/"

# Cleanup
rm -rf "$TEMP_DIR"
