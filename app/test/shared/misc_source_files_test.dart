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

  test('clock.now() instead of DateTime.now()', () async {
    final exceptions = [
      './test/shared/misc_source_files_test.dart',
    ];
    final files = Directory('.')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in files) {
      final content = await file.readAsString();
      expect(content.contains('DateTime.now()'), exceptions.contains(file.path),
          reason: '${file.path} contains DateTime.now()');
    }
  });

  test('Platform.environment only in env_config.dart', () async {
    final exceptions = [
      './bin/tools/public_package_page_checker.dart',
      './lib/shared/configuration.dart',
      './lib/shared/env_config.dart',
      './test/shared/misc_source_files_test.dart',
    ];
    final files = Directory('.')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in files) {
      final content = await file.readAsString();
      expect(content.contains('Platform.environment'),
          exceptions.contains(file.path),
          reason: '${file.path} contains Platform.environment');
    }
  });

  test('cache-control is set only in frontend/handlers/headers.dart', () async {
    final exceptions = [
      'lib/frontend/handlers/headers.dart',
    ];
    final files = Directory('lib')
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));
    for (final file in files) {
      final content = await file.readAsString();
      final lc = content.toLowerCase();
      expect(
        content.contains('cacheControlHeader') ||
            (lc.contains('cache-control') &&
                !lc.contains('`cache-control`') && // allow in documentation
                !lc.contains('`cache-control: private`')),
        exceptions.contains(file.path),
        reason: '${file.path} seems to contain cache-control header',
      );
    }
  });
}
