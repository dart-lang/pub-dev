#!/usr/bin/env bash

set -e

if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi

if [[ -z "$2" ]];
then
  echo "Version argument is missing."
  exit 1
fi

CHANNEL="stable"
if [[ "$2" == *beta ]]
then
  CHANNEL="beta"
elif [[ "$2" == *dev ]]
then
  CHANNEL="dev"
elif [[ "$2" == "latest" ]]
then
  CHANNEL="be"
fi

# Create a temporary directory to extract the archive to.
WORK_DIR=`mktemp -d`
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory."
  exit 1
fi

# Download and extract Dart SDK
cd "$WORK_DIR"
curl -sS "https://storage.googleapis.com/dart-archive/channels/$CHANNEL/raw/$2/sdk/dartsdk-linux-x64-release.zip" >dartsdk.zip
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
