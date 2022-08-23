// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/tool/maintenance/remove_orphaned_likes.dart';
import 'package:test/test.dart';

import '../../shared/test_models.dart';
import '../../shared/test_services.dart';

void main() {
  group('Remove orphaned likes', () {
    testWithProfile('finds the like but no need to delete it', fn: () async {
      await createPubApiClient(authToken: userAtPubDevAuthToken)
          .likePackage('oxygen');
      final counts = await removeOrphanedLikes(minAgeThreshold: Duration.zero);
      expect(counts.found, 1);
      expect(counts.deleted, 0);
    });

    testWithProfile(
      'finds like without package',
      fn: () async {
        await createPubApiClient(authToken: userAtPubDevAuthToken)
            .likePackage('oxygen');
        await dbService.commit(
            deletes: [dbService.emptyKey.append(Package, id: 'oxygen')]);
        final counts =
            await removeOrphanedLikes(minAgeThreshold: Duration.zero);
        expect(counts.found, 1);
        expect(counts.deleted, 1);
      },
      // The deleted package is referenced from multiple places.
      // This is the first integrity issue returned.
      integrityProblem: 'Package "oxygen" is missing.',
    );

    testWithProfile(
      'finds like without userid',
      fn: () async {
        await createPubApiClient(authToken: userAtPubDevAuthToken)
            .likePackage('oxygen');
        final user = await accountBackend.lookupUserByEmail('user@pub.dev');
        await dbService.commit(deletes: [user.key]);
        final counts =
            await removeOrphanedLikes(minAgeThreshold: Duration.zero);
        expect(counts.found, 1);
        expect(counts.deleted, 1);
      },
      // The test deleted a User entity is referenced from multiple places.
      // The first integrity issue returned is about the mapping from the
      // mathing OauthUserId entity, and we are only matching it via a pattern.
      integrityProblem: RegExp(
          '^User ".*" is mapped from OAuthUserID "user-pub-dev", but does not have it set.'),
    );
  });
}
