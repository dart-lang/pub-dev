// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/update_package_likes.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  group('Adjust like counts', () {
    testWithProfile('no need to change like counts #1', fn: () async {
      final p1 = await packageBackend.lookupPackage('oxygen');
      expect(await updatePackageLikes(), 0);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.likes, p1!.likes);
    });

    testWithProfile('no need to change like counts #2', fn: () async {
      final p1 = await packageBackend.lookupPackage('oxygen');
      final client = await createFakeAuthPubApiClient(email: userAtPubDevEmail);
      await client.likePackage('oxygen');
      expect(await updatePackageLikes(), 0);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.likes, p1!.likes + 1);
    });

    testWithProfile('missing like', fn: () async {
      final p1 = await packageBackend.lookupPackage('oxygen');
      await withRetryTransaction(dbService, (tx) async {
        final p = await tx.lookupValue<Package>(
            dbService.emptyKey.append(Package, id: 'oxygen'));
        p.likes++;
        tx.insert(p);
      });
      expect(await updatePackageLikes(), 1);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.likes, p1!.likes);
    });

    testWithProfile('extra like', fn: () async {
      final p1 = await packageBackend.lookupPackage('oxygen');
      final user = await accountBackend.lookupUserByEmail('user@pub.dev');
      await dbService.commit(inserts: [
        Like()
          ..parentKey = user.key
          ..id = 'oxygen'
          ..packageName = 'oxygen'
          ..created = clock.now()
      ]);
      expect(await updatePackageLikes(), 1);
      final p2 = await packageBackend.lookupPackage('oxygen');
      expect(p2!.likes, p1!.likes + 1);
    });
  });
}
