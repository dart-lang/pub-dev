// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';
import 'package:test/test.dart';

final _logger = Logger('search_index_test');

void main() {
  group('Search index inside an isolate', () {
    final collection = IsolateCollection(
      logger: _logger,
      servicesWrapperFn: fakeServicesWrapper,
    );
    late IsolateGroup indexGroup;

    tearDownAll(() async {
      await collection.close();
    });

    test('start and work with index', () async {
      indexGroup = await collection.startGroup(
        kind: 'index',
        count: 1,
        deadTimeout: null,
        spawnUri:
            Uri.parse('package:pub_dev/service/entrypoint/search_index.dart'),
      );

      // forward port to isolate group
      final delegatePort = ReceivePort();
      final subscription = delegatePort.listen((m) {
        final msg = m is RequestMessage
            ? m
            : Message.decodeFromMap(m as Map<String, dynamic>)
                as RequestMessage;
        indexGroup.processRequestMessage(msg);
      });

      // index calling the sendport
      final searchIndex = IsolateSearchIndex(delegatePort.sendPort);
      expect(await searchIndex.isReady(), true);

      // working search only with SDK results (no packages in the isolate)
      final rs =
          await searchIndex.search(ServiceSearchQuery.parse(query: 'json'));
      expect(rs.message, isNull);
      expect(rs.sdkLibraryHits, isNotEmpty);
      expect(rs.packageHits, isEmpty);

      await subscription.cancel();
    }, timeout: Timeout(Duration(minutes: 5)));
  });
}
