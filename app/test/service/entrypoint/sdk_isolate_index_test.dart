// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/sdk_isolate_index.dart';
import 'package:test/test.dart';

final _logger = Logger('sdk_isolate_index_test');

void main() {
  group('SDK index inside an isolate', () {
    final indexRunner = IsolateRunner.uri(
      kind: 'index',
      logger: _logger,
      spawnUri: Uri.parse(
          'package:pub_dev/service/entrypoint/sdk_isolate_index.dart'),
    );

    tearDownAll(() async {
      await indexRunner.close();
    });

    test('start and work with index', () async {
      await indexRunner.start(1);

      final sdkIndex = SdkIsolateIndex(indexRunner);

      final rs = await sdkIndex.search('json');
      expect(rs.map((e) => e.toJson()).toList(), [
        {
          'sdk': 'dart',
          'library': 'dart:convert',
          'description': isNotNull,
          'url': 'https://api.dart.dev/stable/latest/dart-convert/',
          'score': isNotNull,
          'apiPages': isNotEmpty,
        },
        isA<Map>(), // second hit from `package:flutter_driver`
      ]);
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
