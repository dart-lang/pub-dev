#!/usr/bin/env bash

# Fetch a distroless image and extract it for use as rootfs in gvisor sandbox.

set -e

# See: https://github.com/google/go-containerregistry/releases
CRANE_VERSION='v0.20.7'

# Docker image to use for rootfs
# TODO: investigate how we could shrink this to `gcr.io/distroless/base-debian12`
DOCKER_IMAGE='mirror.gcr.io/library/debian:12-slim'

# Check we have a target directory
if [[ -z "$1" ]];
then
  echo "Target directory argument is missing."
  exit 1
fi
TARGET_DIRECTORY="$1"


# Create a temporary directory
WORK_DIR=`mktemp -d`
if [[ ! "$WORK_DIR" || ! -d "$WORK_DIR" ]]; then
  echo "Could not create temporary directory."
  exit 1
fi
trap 'rm -rf "$WORK_DIR"' EXIT

# Download crane
OS=$(uname -s)
ARCH=$(uname -m)
curl -sL "https://github.com/google/go-containerregistry/releases/download/${CRANE_VERSION}/go-containerregistry_${OS}_${ARCH}.tar.gz" | tar -xzf - -C "$WORK_DIR" crane

# Download and extract rootfs
mkdir -p "$TARGET_DIRECTORY"
"$WORK_DIR/crane" export "$DOCKER_IMAGE" - | tar -xf - -C "$TARGET_DIRECTORY"
