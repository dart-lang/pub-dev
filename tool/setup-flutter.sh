#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

if [[ -z "$2" ]];
then
  echo "Flutter version argument is missing."
  exit 1
fi

# Download and extract Flutter SDK into the target directory.
git clone -b "$2" --single-branch https://github.com/flutter/flutter.git "$1"

# Downloads the Dart SDK and disables analytics tracking – which we always want.
# This will add 400 MB.
cd "$1"
./bin/flutter --no-version-check config --no-analytics
