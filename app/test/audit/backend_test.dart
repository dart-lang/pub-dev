// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:fake_gcloud/mem_datastore.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import 'package:pub_dev/audit/backend.dart';

void main() {
  group('before parameter parse and format', () {
    final backend = AuditBackend(DatastoreDB(MemDatastore()));

    test('nearby timestamps', () {
      final t1 = DateTime.now().toUtc();
      final t2 = t1.subtract(Duration(milliseconds: 1));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, t2.toIso8601String());
      expect(backend.parseBeforeQueryParameter(param), t2);
    });

    test('larger difference', () {
      final t1 = DateTime.now().toUtc();
      final t2 = t1.subtract(Duration(days: 2));
      final param = backend.nextTimestamp(t1, t2);
      expect(param, hasLength(10));
      final parsed = backend.parseBeforeQueryParameter(param);
      expect(t2.isBefore(parsed), true);
      expect(t1.isAfter(parsed), true);
    });
  });
}
