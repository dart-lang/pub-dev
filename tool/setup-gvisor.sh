#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

TARGET_DIRECTORY=${1}
mkdir -p "${TARGET_DIRECTORY}"
cd "${TARGET_DIRECTORY}"

ARCH=$(uname -m)

# Release dates can be found on https://github.com/google/gvisor/tags
# See more: https://gvisor.dev/docs/user_guide/install/#specific-release
URL=https://storage.googleapis.com/gvisor/releases/release/20260112/${ARCH}

curl -o runsc "${URL}/runsc"
curl -o runsc.sha512 "${URL}/runsc.sha512"
sha512sum -c runsc.sha512
rm -f runsc.sha512

chmod a+rx runsc
