// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/like_backend.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/database/schema.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/integrity.dart';
import 'package:test/test.dart';
import 'package:typed_sql/typed_sql.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('like integrity checks', () {
    Future<void> setLikesCount(String package, int value) async {
      await primaryDatabase.transactWithRetry(
        (db) => db.packages
            .where((p) => p.name.equalsValue(package))
            .update((p, set) => set(likesCount: value.asExpr))
            .execute(),
      );
    }

    // The post-test background tasks would repair these states, hence the
    // checks are called directly and the state is restored before returning.

    testWithProfile(
      'SQL likes count differs from the like rows',
      fn: () async {
        await setLikesCount('oxygen', 10);
        final problems = await findAllIntegrityProblems().toList();
        expect(
          problems,
          contains(
            allOf(contains('"oxygen"'), contains('like count difference')),
          ),
        );
        await likeBackend.reconcileLikesCount('oxygen');
        expect(await findAllIntegrityProblems().toList(), isEmpty);
      },
    );

    testWithProfile(
      'SQL likes count is negative',
      fn: () async {
        await setLikesCount('oxygen', -1);
        final problems = await findAllIntegrityProblems().toList();
        expect(
          problems,
          contains(allOf(contains('"oxygen"'), contains('negative'))),
        );
        await likeBackend.reconcileLikesCount('oxygen');
        expect(await findAllIntegrityProblems().toList(), isEmpty);
      },
    );

    testWithProfile(
      'package missing from Datastore does not fail the check',
      fn: () async {
        final client = await createFakeAuthPubApiClient(
          email: userAtPubDevEmail,
        );
        await client.likePackage('oxygen');
        final p = (await packageBackend.lookupPackage('oxygen'))!;
        final key = dbService.emptyKey.append(Package, id: 'oxygen');
        await dbService.commit(deletes: [key]);

        final problems = await findAllIntegrityProblems().toList();
        expect(problems, isNotEmpty);

        await dbService.commit(inserts: [p]);
        expect(await findAllIntegrityProblems().toList(), isEmpty);
      },
    );
  });
}
