#!/usr/bin/env bash

# Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
ROOT="${SCRIPT_DIR}/.."

# Create directory for exposing sockets
LOCK_DIR="/tmp/pub_dev_postgres/"
SOCKET_DIR="/tmp/pub_dev_postgres/run/"
mkdir -p "$SOCKET_DIR"

# Use an extra lock file to avoid every creating more than one docker container
LOCKFILE="$LOCK_DIR/.docker.lock"
touch "$LOCKFILE"

CONTAINER_ID=$((
  flock -ox 200
  if ! docker inspect 'pub_dev_postgres' > /dev/null 2>&1; then
    docker run \
      --detach \
      --rm \
      --name pub_dev_postgres \
      -e POSTGRES_PASSWORD=postgres \
      -v "$SOCKET_DIR":/var/run/postgresql/ \
      --mount type=tmpfs,destination=/var/lib/postgresql/data \
      postgres:17 \
      postgres \
        -c fsync=off \
        -c synchronous_commit=off \
        -c full_page_writes=off \
        -c wal_level=minimal \
        -c max_wal_senders=0 \
        -c archive_mode=off
  fi
) 200>"$LOCKFILE")

if [ -n "$CONTAINER_ID" ]; then
  if [ "$1" != '--quiet' ]; then
    echo 'Started postgres test database'
    echo 'Will terminate it in 6 hours, if you do not close this script'
  fi
  trap "/bin/bash -c 'docker kill "$CONTAINER_ID" > /dev/null 2>&1'" EXIT
  sleep 6h;
else
  if [ "$1" != '--quiet' ]; then
    echo 'Found postgres test database already running!'
    echo 'If you want to restart it, you can use with:'
    echo 'docker kill pub_dev_postgres'
  fi
fi
