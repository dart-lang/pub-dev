// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/package/models.dart';
import 'package:test/test.dart';

import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/tool/backfill/backfill_audit.dart';

import '../../shared/test_services.dart';

void main() {
  group('backfill audit', () {
    testWithProfile('all packages', fn: () async {
      // count versions
      final allVersionsCount =
          await dbService.query<PackageVersion>().run().length;
      expect(allVersionsCount, greaterThan(0));

      // delete all audit entities
      final keys = <Key>[];
      await for (final h in dbService.query<AuditLogRecord>().run()) {
        keys.add(h.key);
      }
      expect(keys, hasLength(greaterThanOrEqualTo(allVersionsCount)));
      await dbService.commit(deletes: keys);

      // backfill and check total count
      final count = await backfillAuditAll(1, true);
      expect(count, allVersionsCount);
    });
  });
}
