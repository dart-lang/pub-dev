// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';
import 'package:test/test.dart';

final _logger = Logger('search_index_test');

void main() {
  group('Search index inside an isolate', () {
    final indexRunner = IsolateRunner.uri(
      kind: 'index',
      logger: _logger,
      spawnUri:
          Uri.parse('package:pub_dev/service/entrypoint/search_index.dart'),
    );

    tearDownAll(() async {
      await indexRunner.close();
    });

    test('start and work with index', () async {
      await indexRunner.start(1);

      // index calling the sendport
      final searchIndex = IsolateSearchIndex(indexRunner);
      expect(await searchIndex.isReady(), true);

      // working search only with SDK results (no packages in the isolate)
      final rs =
          await searchIndex.search(ServiceSearchQuery.parse(query: 'json'));
      expect(rs.errorMessage, isNull);
      expect(rs.sdkLibraryHits, isNotEmpty);
      expect(rs.packageHits, isEmpty);
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
