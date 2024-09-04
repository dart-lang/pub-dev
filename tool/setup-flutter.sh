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
if [[ "$2" == "master" ]]
then
  git clone -b "$2" --single-branch https://github.com/flutter/flutter.git "$1"
else
  CHANNEL=${3:-stable}

  # Create a temporary directory to extract the archive to.
  WORK_DIR=`mktemp -d`
  if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
    echo "Could not create temporary directory."
    exit 1
  fi

  # Download and extract Flutter SDK
  cd "$WORK_DIR"
  curl -sS "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_$2-${CHANNEL}.tar.xz" >flutter.tar.xz
  tar xf flutter.tar.xz
  rm flutter.tar.xz

  # Move from temp to destination.
  DEST_PARENT=`dirname "$1"`
  mkdir -p "$DEST_PARENT"
  mv "$WORK_DIR/flutter" "$1"
fi

# When using `git clone` above, the first command downloads the Dart SDK (adds ~400MB),
# which should be already included in the tar archive. However, the tar archive requires
# to run `flutter doctor` to work properly.
cd "$1"
./bin/flutter --no-version-check config --no-analytics --no-cli-animations
./bin/flutter --no-version-check doctor
