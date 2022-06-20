// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:pub_dev/shared/utils.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('AccountBackend', () {
    testWithProfile('No user', fn: () async {
      expect(await accountBackend.getEmailOfUserId(createUuid()), isNull);
    });

    testWithProfile('Invalid userId', fn: () async {
      await expectLater(
        accountBackend.getEmailOfUserId('bad-user-id'),
        throwsA(isA<InvalidInputException>()),
      );
    });

    testWithProfile('Successful lookup', fn: () async {
      final user = await accountBackend.lookupUserByEmail('user@pub.dev');
      final email = await accountBackend.getEmailOfUserId(user.userId);
      expect(email, 'user@pub.dev');
      final u = await accountBackend.lookupUserById(user.userId);
      expect(u!.email, 'user@pub.dev');
      expect(u.oauthUserId, isNotNull);
      expect(u.id, user.id);
    });

    testWithProfile('Create missing user', fn: () async {
      final oldIds =
          await dbService.query<User>().run().map((u) => u.userId).toList();

      final u = await accountBackend.withBearerToken(
        createFakeAuthTokenForEmail('new-user@pub.dev'),
        () => requireAuthenticatedUser(),
      );
      expect(u.userId, hasLength(36));
      expect(u.oauthUserId, isNotNull);
      expect(u.email, 'new-user@pub.dev');

      final ids =
          await dbService.query<User>().run().map((u) => u.userId).toList();
      expect(ids.length, oldIds.length + 1);
      expect(ids.contains(u.userId), isTrue);
    });

    testWithProfile('Authenticate: token failure', fn: () async {
      await expectLater(
          () => accountBackend.withBearerToken(
              '', () => requireAuthenticatedUser()),
          throwsA(isA<AuthenticationException>()));
    });

    testWithProfile('Authenticate: pre-created', fn: () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids1, {'admin-pub-dev', 'user-pub-dev'});

      String? userId;
      await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('a@example.com'), () async {
        final u1 = await requireAuthenticatedUser();
        expect(u1.userId, hasLength(36));
        expect(u1.email, 'a@example.com');
        userId = u1.userId;
      });

      final u2 = await accountBackend.lookupUserById(userId!);
      expect(u2!.email, 'a@example.com');
      expect(u2.oauthUserId, 'a-example-com');

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids2, {'admin-pub-dev', 'user-pub-dev', 'a-example-com'});
    });

    testWithProfile('Authenticate: new user', fn: () async {
      final ids1 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids1, {'admin-pub-dev', 'user-pub-dev'});

      await accountBackend.withBearerToken(
          createFakeAuthTokenForEmail('c@example.com'), () async {
        final u1 = await requireAuthenticatedUser();
        expect(u1.userId, hasLength(36));
        expect(u1.email, 'c@example.com');

        final u2 = await accountBackend.lookupUserById(u1.userId);
        expect(u2!.email, 'c@example.com');
        expect(u2.oauthUserId, 'c-example-com');
      });

      final ids2 = await dbService
          .query<OAuthUserID>()
          .run()
          .map((u) => u.oauthUserId)
          .toSet();
      expect(ids2, {'admin-pub-dev', 'c-example-com', 'user-pub-dev'});
    });
  });
}
