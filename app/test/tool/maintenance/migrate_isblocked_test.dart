// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/backfill/backfill_new_fields.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  group('Migrate isBlocked', () {
    testWithProfile('package', fn: () async {
      final p1 = await packageBackend.lookupPackage('oxygen');
      await dbService.commit(
          inserts: [p1!..updateIsBlocked(isBlocked: true, reason: 'abc')]);
      await migrateIsBlocked();

      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.isModerated, true);
    });

    testWithProfile('publisher', fn: () async {
      final p1 = await publisherBackend.getPublisher('example.com');
      await dbService.commit(inserts: [p1!..markForBlocked()]);
      final members =
          await publisherBackend.listPublisherMembers('example.com');
      for (final m in members) {
        await accountBackend.updateBlockedFlag(m.userId, true);
      }
      final neon = await packageBackend.lookupPackage('neon');
      await dbService.commit(inserts: [neon!..isDiscontinued = true]);

      await migrateIsBlocked();

      final p2 = await publisherBackend.getPublisher('example.com');
      expect(p2!.isModerated, true);
    });

    testWithProfile('user', fn: () async {
      final u1 = await accountBackend.lookupUserByEmail('user@pub.dev');
      await dbService.commit(inserts: [u1..isBlocked = true]);
      await migrateIsBlocked();

      final u2 = await accountBackend.lookupUserByEmail('user@pub.dev');
      expect(u2.isModerated, true);
    });
  });
}
