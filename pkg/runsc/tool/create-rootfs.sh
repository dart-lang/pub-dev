#!/bin/bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -rf "$DIR/../rootfs"
mkdir -p "$DIR/../rootfs"
"$DIR/../crane" export gcr.io/distroless/base-debian12 - | tar -xf - -C "$DIR/../rootfs"

# CONTAINER=$(docker create gcr.io/distroless/base-debian12 sh)
# rm -rf "$DIR/../rootfs"
# mkdir -p "$DIR/../rootfs"
# docker export "$CONTAINER" | tar -xf - -C "$DIR/../rootfs"
# docker rm "$CONTAINER"
