// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import 'test_models.dart';
import 'test_services.dart';

void main() {
  // The post-test verification runs each part of the Datastore integrity check
  // with its own checker. These tests make sure that the `packages` part loads
  // the users and publishers that its checks depend on.
  group('Datastore integrity check parts', () {
    final testProfile = defaultTestProfile.changeDefaultUser(userAtPubDevEmail);

    /// Removes `user@pub.dev`, who is the uploader of `oxygen` and the only
    /// member of `example.com` (the publisher of `neon`) in [testProfile].
    Future<String> removeUser() async {
      final user = await accountBackend.lookupUserByEmail(userAtPubDevEmail);
      await createPubApiClient(
        authToken: siteAdminToken,
      ).adminRemoveUser(user.userId);
      return user.userId;
    }

    testWithProfile(
      'packages part reports a package of an abandoned publisher',
      testProfile: testProfile,
      fn: () async {
        await removeUser();
        final neon = await packageBackend.lookupPackage('neon');
        await dbService.commit(inserts: [neon!..isDiscontinued = false]);
      },
      integrityProblem:
          'Package "neon" has an abandoned publisher, must be marked discontinued.',
    );

    testWithProfile(
      'packages part reports a deleted uploader',
      testProfile: testProfile,
      fn: () async {
        final userId = await removeUser();
        final oxygen = await packageBackend.lookupPackage('oxygen');
        await dbService.commit(
          inserts: [
            oxygen!..uploaders = [userId],
          ],
        );
      },
      integrityProblem: RegExp('^Package "oxygen" references a deleted User '),
    );
  });
}
