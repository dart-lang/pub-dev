// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/update_package_likes.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../../database/package_sql_utils.dart';
import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  group('Adjust like counts', () {
    testWithProfile(
      'no need to change like counts #1',
      fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        expect(await updatePackageLikes(), 0);
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.likes, p1!.likes);
        await expectPackageInSqlMatchesDatastore('oxygen');
      },
    );

    testWithProfile(
      'no need to change like counts #2',
      fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        final client = await createFakeAuthPubApiClient(
          email: userAtPubDevEmail,
        );
        await client.likePackage('oxygen');
        expect(await updatePackageLikes(), 0);
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.likes, p1!.likes + 1);
      },
    );

    testWithProfile(
      'SQL likes count is higher than the rows',
      fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        await primaryDatabase.transactWithRetry(
          (db) => db.packages
              .where((p) => p.name.equalsValue('oxygen'))
              .update((p, set) => set(likesCount: p.likesCount + 1.asExpr))
              .execute(),
        );
        expect(await updatePackageLikes(), 1);
        expect(await likeBackend.reconcileLikesCount('oxygen'), isFalse);
        expect(await packageBackend.lookupLikesCount('oxygen'), p1!.likes);
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.likes, p1.likes);
        await expectPackageInSqlMatchesDatastore('oxygen');
      },
    );

    testWithProfile(
      'SQL likes count is lower than the rows',
      fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        await primaryDatabase.transactWithRetry(
          (db) => db.packageLikes
              .insertValue(
                userId: user.userId,
                package: 'oxygen',
                createdAt: clock.now().toUtc(),
              )
              .execute(),
        );
        expect(await updatePackageLikes(), 1);
        expect(await packageBackend.lookupLikesCount('oxygen'), p1!.likes + 1);
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.likes, p1.likes + 1);
        await expectPackageInSqlMatchesDatastore('oxygen');
      },
    );

    testWithProfile(
      'Datastore copy is repaired from SQL',
      fn: () async {
        final p1 = await packageBackend.lookupPackage('oxygen');
        await withRetryTransaction(dbService, (tx) async {
          final p = await tx.lookupValue<Package>(
            dbService.emptyKey.append(Package, id: 'oxygen'),
          );
          p.likes++;
          tx.insert(p);
        });
        // The SQL count is consistent, only the copy is repaired.
        expect(await updatePackageLikes(), 0);
        final p2 = await packageBackend.lookupPackage('oxygen');
        expect(p2!.likes, p1!.likes);
      },
    );
  });
}
