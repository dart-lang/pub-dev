// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/package/models.dart';
import 'package:test/test.dart';

import 'package:pub_dev/history/models.dart';
import 'package:pub_dev/tool/backfill/backfill_history.dart';

import '../../shared/test_services.dart';

void main() {
  group('backfill history', () {
    testWithProfile('all packages', fn: () async {
      // delete all history entities
      final keys = <Key>[];
      await for (final h in dbService.query<History>().run()) {
        keys.add(h.key);
      }
      await dbService.commit(deletes: keys);

      // count versions
      final allVersionsCount =
          await dbService.query<PackageVersion>().run().length;

      // backfill and check total count
      final count = await backfillHistoryAll(1, true);
      expect(count, allVersionsCount);
    });
  });
}
