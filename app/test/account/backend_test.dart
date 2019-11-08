// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';

import '../shared/test_services.dart';

void main() {
  group('AccountBackend', () {
    testWithServices('No user', () async {
      final email = await accountBackend.getEmailOfUserId('no-user-id');
      expect(email, isNull);
    });

    testWithServices('Successful lookup', () async {
      final email = await accountBackend.getEmailOfUserId('a-example-com');
      expect(email, 'a@example.com');
      final u1 = await accountBackend.lookupUserById('a-example-com');
      expect(u1.email, 'a@example.com');
      expect(u1.oauthUserId, isNull);
      final u2 =
          await accountBackend.lookupOrCreateUserByEmail('a@example.com');
      expect(u2.id, u1.id);
    });

    testWithServices('Create missing user', () async {
      final oldIds =
          await dbService.query<User>().run().map((u) => u.userId).toList();

      final u = await accountBackend.lookupOrCreateUserByEmail('b@example.com');
      expect(u.userId, hasLength(36));
      expect(u.oauthUserId, isNull);
      expect(u.email, 'b@example.com');

      final ids =
          await dbService.query<User>().run().map((u) => u.userId).toList();
      expect(ids.length, oldIds.length + 1);
      expect(ids.contains('a-example-com'), isTrue);
      expect(ids.contains(u.userId), isTrue);
    });

    testWithServices('Authenticate: token failure', () async {
      final u = await accountBackend.authenticateWithBearerToken('x');
      expect(u, isNull);
    });

    testWithServices('Authenticate: pre-created', () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids1, ['admin-pub-dev']);

      final u1 = await accountBackend
          .authenticateWithBearerToken('a-at-example-dot-com');
      expect(u1.userId, 'a-example-com');
      expect(u1.email, 'a@example.com');

      final u2 = await accountBackend.lookupUserById('a-example-com');
      expect(u2.email, 'a@example.com');
      expect(u2.oauthUserId, 'a-example-com');

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids2, ['admin-pub-dev', 'a-example-com']);
    });

    testWithServices('Authenticate: new user', () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      expect(ids1, ['admin-pub-dev']);

      final u1 = await accountBackend
          .authenticateWithBearerToken('c-at-example-dot-com');
      expect(u1.userId, hasLength(36));
      expect(u1.email, 'c@example.com');

      final u2 = await accountBackend.lookupUserById(u1.userId);
      expect(u2.email, 'c@example.com');
      expect(u2.oauthUserId, 'c-example-com');

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toList();
      ids2.sort();
      expect(ids2, ['admin-pub-dev', 'c-example-com']);
    });
  });
}
