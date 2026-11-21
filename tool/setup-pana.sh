#!/usr/bin/env bash

# Extract pana sources to the directory (for linking the license files)
# Usage: setup-pana.sh /target/path <pana-version>
#
# Note: when pana-version is not set, it will try to detect the resolved pana in the current directory

set -e

TARGET_DIR=$1

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
LOCAL_PANA="${SCRIPT_DIR}/../third_party/pana"
if [[ -d "${LOCAL_PANA}" ]]; then
  cp -R "${LOCAL_PANA}" "${TARGET_DIR}"
  exit 0
fi

PANA_VERSION=${2:-$(dart pub deps -s compact | grep pana | head -n 1 | cut -d' ' -f3)}

if [[ ! "$PANA_VERSION" ]]; then
  echo "Pana version is missing."
  exit 1
fi

# Create a temporary directory
WORK_DIR=`mktemp -d`
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory."
  exit 1
fi
trap 'rm -rf "$WORK_DIR"' EXIT

# Download and move pana
dart pub unpack "pana:${PANA_VERSION}" --output=${WORK_DIR}
mv "${WORK_DIR}/pana-${PANA_VERSION}" "${TARGET_DIR}"
