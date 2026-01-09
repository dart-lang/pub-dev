#!/bin/bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -rf "$DIR/../input"
rm -rf "$DIR/../rootfs"
rm -rf "$DIR/../crane"
rm -rf "$DIR/../runsc"
rm -rf "$DIR/../dart-sdk"
