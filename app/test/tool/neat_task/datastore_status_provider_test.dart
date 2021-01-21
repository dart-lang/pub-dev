// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/neat_task/datastore_status_provider.dart';

import '../../shared/test_services.dart';

void main() {
  group('DatastoreStatusProvider', () {
    testWithProfile('get empty status', fn: () async {
      final provider = DatastoreStatusProvider.create(dbService, 'task-id');
      expect(await provider.get(), isEmpty);
      expect(await provider.get(), isEmpty);
    });

    testWithProfile('set status', fn: () async {
      final provider = DatastoreStatusProvider.create(dbService, 'task-id');
      expect(await provider.set([1, 2]), isTrue);
      expect(await provider.get(), [1, 2]);
      expect(await provider.set([3, 4]), isTrue);
      expect(await provider.get(), [3, 4]);
    });

    testWithProfile('set status', fn: () async {
      final p1 = DatastoreStatusProvider.create(dbService, 'task-id');
      expect(await p1.set([1, 2]), isTrue);
      expect(await p1.get(), [1, 2]);

      final p2 = DatastoreStatusProvider.create(dbService, 'task-id');
      expect(await p2.set([3, 4]), isFalse);
      expect(await p2.get(), [1, 2]);
      expect(await p2.set([3, 4]), isTrue);
      expect(await p2.get(), [3, 4]);
    });
  });
}
