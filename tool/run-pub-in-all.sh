#!/bin/bash
# This script runs a 'dart pub {rest of the args}' command in `app/` and in each sub-directory of the 'pkg/' folder.

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/.."

cd "$SCRIPT_DIR/../app"
pwd
dart pub $*

cd "$SCRIPT_DIR/.."
# Find all subdirectories in 'pkg/' and loop through them.
find pkg -mindepth 1 -maxdepth 1 -type d | while read dir; do
  cd "$SCRIPT_DIR/../$dir"
  pwd
  dart pub $*
done
