#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

# Expected version argument formats:
# - stable/raw/hash/<hash>
# - 3.2.5 (stable/release/<version>)
# - 3.2.5-beta (beta/release/<version>)
# - 3.2.5-dev (dev/release/<version>)
if [[ -z "$2" ]];
then
  echo "Version argument is missing."
  exit 1
fi

# Infer the download URL
if [[ "$2" == */raw/hash/* ]]
then
  DOWNLOAD_URL="https://storage.googleapis.com/dart-archive/channels/$2/sdk/dartsdk-linux-x64-release.zip"
elif [[ "$2" == *.* ]]
then
  CHANNEL="stable"
  if [[ "$2" == *beta ]]
  then
    CHANNEL="beta"
  elif [[ "$2" == *dev ]]
  then
    CHANNEL="dev"
  fi
  DOWNLOAD_URL="https://storage.googleapis.com/dart-archive/channels/$CHANNEL/release/$2/sdk/dartsdk-linux-x64-release.zip"
fi

if [[ -z "$DOWNLOAD_URL" ]];
then
  echo "Unable to infer download URL."
  exit 1
fi

# Create a temporary directory to extract the archive to.
WORK_DIR=`mktemp -d`
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory."
  exit 1
fi

# Download and extract Dart SDK
cd "$WORK_DIR"
curl -sS "$DOWNLOAD_URL" >dartsdk.zip
unzip -q dartsdk.zip
rm -f dartsdk.zip

# Move from temp to destination.
DEST_PARENT=`dirname "$1"`
mkdir -p "$DEST_PARENT"
mv "$WORK_DIR/dart-sdk" "$1"

# Initialize and set first run settings
cd "$1"
./bin/dart --disable-analytics

# Cleanup
rm -rf "$WORK_DIR"
