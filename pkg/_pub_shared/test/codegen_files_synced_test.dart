// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';
import 'package:test/test.dart';

void main() {
  // ./tool/codegen.sh will run build_runner, and copy pubapi.client.dart
  // into _pub_shared
  // This test ensures that this happened, if it fails, just run:
  // ./tool/codegen.sh
  test('pubapi.client.dart have been sync', () {
    final root = '../..';
    final orig = File('$root/app/lib/frontend/handlers/pubapi.client.dart')
        .readAsStringSync();
    final clone = File('$root/pkg/_pub_shared/lib/src/pubapi.client.dart')
        .readAsStringSync();
    if (orig != clone) {
      fail('Expected "pkg/_pub_shared/lib/src/pubapi.client.dart" to match '
          'app/lib/frontend/handlers/pubapi.client.dart\n\n'
          'Please run: `./tool/codegen.sh`');
    }
  });
}
