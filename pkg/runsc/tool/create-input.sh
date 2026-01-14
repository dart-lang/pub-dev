#!/bin/bash

# Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

rm -rf "$DIR/../input/"
mkdir -p "$DIR/../input/package/"
curl -sL https://pub.dev/api/archives/retry-3.1.2.tar.gz | tar -xzf - -C "$DIR/../input/package/"


cd "$DIR/../input/package/"
PUB_CACHE="../pub-cache/" "$DIR/../dart-sdk/bin/dart" pub get
