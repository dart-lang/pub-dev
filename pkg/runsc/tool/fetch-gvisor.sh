#!/bin/bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ARCH=$(uname -m)
URL=https://storage.googleapis.com/gvisor/releases/release/latest/${ARCH}

cd "$DIR/../"

wget ${URL}/runsc ${URL}/runsc.sha512
sha512sum -c runsc.sha512
rm -f runsc.sha512

chmod a+rx runsc
