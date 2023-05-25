#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

TARGET_DIRECTORY=${1}
LIBWEBP_VERSION="1.3.0"
LIBWEBP_TAR_URI="https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-${LIBWEBP_VERSION}-linux-x86-64.tar.gz"
EXPECTED_FILES=(cwebp dwebp webpinfo gif2webp webpmux)

function ensure_target_directory() {
    mkdir -p ${TARGET_DIRECTORY}
    if [ "$?" != "0" ]; then
        exit -1
    fi
}

function download_and_extract() {
    curl --retry 8 -L "${LIBWEBP_TAR_URI}" | \
      tar -xzv --strip-components=2 -C "${TARGET_DIRECTORY}" --\
      "libwebp-${LIBWEBP_VERSION}-linux-x86-64/bin"

}

function check_expected_files_in_target_exists() {
  for file in ${EXPECTED_FILES[@]}; do
    PATH2CHECK="${TARGET_DIRECTORY}/${file}"
    [ ! -f "${PATH2CHECK}" ] &&
      ( echo "file ${PATH2CHECK} is missing" ; exit -1 );
  done
  echo "setup-webp successfully installed binaries: ${EXPECTED_FILES[@]}"
}

# Entry
ensure_target_directory
download_and_extract
check_expected_files_in_target_exists
