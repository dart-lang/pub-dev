// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

void main() {
  // code coverage will call main as test groups, which shouldn't be async
  test('_test.dart files should have non-async main methods', () {
    final files = Directory('test')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('_test.dart'));
    for (final file in files) {
      final lines = file.readAsLinesSync();
      final main = lines
          .firstWhere((line) => line.contains(' main(') && line.contains('{'));
      expect(main.contains('Future<'), isFalse);
      expect(main.contains(' async '), isFalse);
      expect(main.contains('void '), isTrue);
    }
  });

  test('redis: separators in prefixes', () {
    final file = File('lib/shared/redis_cache.dart');
    final lines = file.readAsLinesSync();
    for (final line in lines) {
      if (line.contains('withPrefix')) {
        expect(line, contains("/')"));
      }
    }
  });
}
