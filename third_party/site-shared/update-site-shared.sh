#!/bin/bash
set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEMP_DIR=$(mktemp -d)

# Clone dartdoc repository
git clone https://github.com/dart-lang/site-shared "$TEMP_DIR"

# Delete resources/
rm -rf "$SCRIPT_DIR/dash_design"

# Copy css, js, png files to dash_design/
mkdir "$SCRIPT_DIR/dash_design"
cp -r "$TEMP_DIR"/pkgs/dash_design/lib/ "$SCRIPT_DIR/dash_design/"

# Copy license
cp "$TEMP_DIR/pkgs/dash_design/LICENSE" "$SCRIPT_DIR/dash_design/LICENSE"

# Update the last updated file:
cd "$TEMP_DIR"/pkgs/dash_design/ && git show --summary | grep commit | head -1 >"$SCRIPT_DIR/last-updated.txt"
date -Iminutes >>"$SCRIPT_DIR/last-updated.txt"

# Cleanup
cd "$SCRIPT_DIR"
rm -rf "$TEMP_DIR"
