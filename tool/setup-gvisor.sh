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
URL=https://storage.googleapis.com/gvisor/releases/release/latest/${ARCH}

wget ${URL}/runsc ${URL}/runsc.sha512
sha512sum -c runsc.sha512
rm -f runsc.sha512

chmod a+rx runsc
